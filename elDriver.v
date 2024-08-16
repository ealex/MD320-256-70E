module elDriver(
	// system wide inputs
	//input wire in_clock,
	
	// display
	output wire out_display_clock,
	output wire out_display_data,
	output wire out_display_hs,
	output wire out_display_vs,
	
	// communication interface
	// UART
	input wire UART_RX,
	
	// debug signals
	output wire debug_clock,
	output wire debug_out_display_clock,
	output wire debug_out_display_data,
	output wire debug_out_display_hs,
	output wire debug_out_display_vs
);

wire main_clock;
// use the internal oscillator
defparam OSCH_inst.NOM_FREQ = "53.20";
OSCH OSCH_inst(
	.STDBY(1'b0),
	.OSC(main_clock),
	.SEDSTDBY()
);
//assign debug_clock = main_clock;

// timing controller
// generate 4 phases
// phase 0: compute display x,y, hSync and vSync, display clock goes to 0
// phase 1: TBD
// phase 2: display clock goes to 1
// phase 3: TDB
reg[2:0] phase_counter=3'b000;
always @(posedge main_clock) begin
	phase_counter <= phase_counter + 3'b001;
end


wire[8:0] coord_x;
wire[8:0] coord_y;
sync sync_inst(
	.in_main_clock(main_clock),
	.in_phase_counter(phase_counter),
	.out_display_clock(out_display_clock),
	.out_display_hs(out_display_hs),
	.out_display_vs(out_display_vs),
	.out_coord_x(coord_x),
	.out_coord_y(coord_y)
);


// display data debug
/*
assign out_display_data = (coord_x == 10'd0) | (coord_x== 10'd319) 
							| (coord_y==9'd0) |  (coord_y==9'd10) 
							| (coord_y==9'd20) | (coord_y==9'd235) 
							| (coord_y==9'd245) | (coord_y==9'd255);
*/

// the screen is split into 8x8 grid => 40 chars by 32 rows
// this will allow a maximum of 1280 characters on the screen
wire[10:0] character_ram_index = (coord_x/8)+(40*(coord_y/8));
wire[7:0] character;
reg[7:0] ramWriteData;
reg[10:0] ramWriteAddress;
reg ramWriteEnable;
//localparam	character = 8'h21;
character_ram character_ram_inst (
	.WrAddress(ramWriteAddress),
	.RdAddress(character_ram_index),
	.Data(ramWriteData),
	.WE(ramWriteEnable), 
    .RdClock(main_clock),
	.RdClockEn(1'b1),
	.Reset(1'b0),
	.WrClock(main_clock),
	.WrClockEn(1'b1), 
    .Q(character)
);


// the font ROM requires 256*8 bytes - each font is 8x8
// it's storing only the first 127 characters => 1024 bytes
wire[9:0] fontRomAddr = (8*character)+coord_y[2:0];
wire[7:0] font_rom_data;
font_rom font_rom_inst (
	.Address(fontRomAddr),
	//.OutClock(main_clock),
	//.OutClockEn(1'b1),
	//.Reset(1'b0),
	.Q(font_rom_data)
);
assign out_display_data = font_rom_data[coord_x[2:0]];


// TODO : implement SPI interface - faster and better
// this is the interface towards the user
// it implements an 8N1 uart with baud 230400 - easy to test and the minimum baud rate
// with the current uart implementation (8 bit divider)
localparam UART_CLK_DIV = 8'd231; // (Frequency of i_Clock)/(Frequency of UART)
// serial port RX
wire uartRxNewByte;
wire[7:0] uartRxData;
uart_rx #(.CLKS_PER_BIT(UART_CLK_DIV)) UART_RX_INST (
	.i_Clock(main_clock),
	.i_Rx_Serial(UART_RX),
	.o_Rx_DV(uartNewByte),
	.o_Rx_Byte(uartRxData)
);

/**
	this is the state machine that controlls memory writes
	ramWriteData - stores the data that will be pushes to the  character RAM
	ramWriteAddress - current write address, set to 0 on reset then kept as it's current value
						it's incremented on normal writes, or set to a specific value on "addr set" commands
	ramWriteEnable - strobed once the operation is known
	oldRamColumn - stores the last updated column
	oldRamRow - stores the last updated row
	
	Commands: 
		0x00-0x7F - writes that character at the current ramWriteAddress and increments ramWriteAddress 
		0b10xxxxxx - updates oldRamColumn and recalculates ramWriteAddress
		0b11xxxxxx - updates oldRamRow and recalculates ramWriteAddress
*/
reg[5:0] oldRamColumn;
reg[5:0] oldRamRow;
reg[7:0] ramWriteStateMachine = 8'd0;
always @ (posedge main_clock) begin
	case (ramWriteStateMachine)
		8'b00000000: begin // this is the reset state
			ramWriteData <= 8'd0;
			ramWriteEnable <= 1'b0;
			ramWriteAddress <= 11'd0;
			oldRamColumn <= 8'd0;
			oldRamRow <= 8'd0;
			ramWriteStateMachine <= 8'b00000001;
		end
		8'b00000001: begin // wait for a new byte
			if(1'b1==uartNewByte) begin
				ramWriteData <= uartRxData;
				ramWriteEnable <= 1'b0;
				ramWriteAddress <= ramWriteAddress;
				ramWriteStateMachine <= 8'b00000010;
			end else begin
				// keep waiting for a new byte
				ramWriteStateMachine <= 8'b00000001;
			end
		end
		8'b00000010: begin // got a new byte, process it
			casez (ramWriteData)
				8'b00001010: begin //Line feed - increment ROW
					oldRamRow <= oldRamRow + 6'd1;
					oldRamColumn <= 6'd0;
					ramWriteStateMachine <= 8'b10000000;
				end
				8'b00001101: begin	// CR - ignored
					ramWriteStateMachine <= 8'b00000001;
				end
				8'b11111111: begin	// memory clear
					ramWriteStateMachine <= 8'b11100000;
				end
				8'b10??????: begin	// update COLUMN
					oldRamColumn <= ramWriteData[5:0];
					ramWriteStateMachine <= 8'b10000000;
				end
				8'b11??????: begin	// update ROW
					oldRamRow <= ramWriteData[5:0];
					ramWriteStateMachine <= 8'b10000000;
				end
				default: begin		// all other characters are treated as printable
					// trigger the write strobe
					ramWriteEnable <= 1'b1;
					ramWriteStateMachine <= 8'b11000000;
				end
			endcase
		end
		
// codes that start with 0b1000xxxx handle ramWriteAddress recalculation
		8'b10000000: begin	// one check to ensure we're in screen
			if(6'd39 < oldRamColumn) oldRamColumn <= 6'd0;
			if(6'd31 < oldRamRow) oldRamRow <= 6'd0;
			ramWriteStateMachine <= 8'b10000001;
		end
		8'b10000001: begin
			// recalculate ramWriteAddress and restart the machine
			ramWriteAddress <= oldRamColumn + oldRamRow*40;
			ramWriteStateMachine <= 8'b00000001;
		end






// codes that start with 0b1100xxxx are used to write a byte to video ram
		8'b11000000: begin
			// clear the write enable, increment the current write address and wait for a new character
			ramWriteEnable <= 1'b0;
			// keep track of the row and columnn
			oldRamColumn <= oldRamColumn + 1'd1;
			ramWriteStateMachine <= 8'b11000001;
		end
		8'b11000001: begin
			if(6'd39 < oldRamColumn) begin
				oldRamColumn <= 6'd0;
				oldRamRow <= oldRamRow + 6'd1;
			end
			ramWriteStateMachine <= 8'b11000010;
		end
		8'b11000010: begin
			if(6'd31 < oldRamRow) begin		// reset to TOP screen when running past the end
				oldRamRow <= 6'd0;
			end
			ramWriteStateMachine <= 8'b11000011;
		end
		8'b11000011: begin
			ramWriteAddress <= oldRamColumn + oldRamRow*40;
			ramWriteStateMachine <= 8'b00000001;
		end
		

// codes that start with 0b1110xxxx are used to erase the memory
		8'b11100000: begin // reset the memory pointer, and row and col
			ramWriteAddress <= 11'd0;
			oldRamRow <= 6'd0;
			oldRamColumn <= 6'd0;
			ramWriteData <= 8'd0;
			ramWriteStateMachine <= 8'b11100001;
		end
		8'b11100001: begin	// loop for 
			if( 11'd1281 == ramWriteAddress ) begin		// reached the end of the memory
				ramWriteAddress <= 11'd0;
				ramWriteStateMachine <= 8'b00000001;
			end else begin
				ramWriteEnable <= 1'b1;
				ramWriteStateMachine <= 8'b11100010;
			end
		end
		8'b11100010: begin
			ramWriteEnable <= 1'b0;
			ramWriteStateMachine <= 8'b11100011;
		end
		8'b11100011: begin
			ramWriteAddress <= ramWriteAddress + 11'd1;
			ramWriteStateMachine <= 8'b11100001;
		end


// final handler
		default: begin
			ramWriteStateMachine <= 8'b00000000;
		end
	endcase
end

// debug signals
assign debug_out_display_clock = out_display_clock;
assign debug_out_display_data = out_display_data;
assign debug_out_display_hs = out_display_hs;
assign debug_out_display_vs = out_display_vs;
endmodule
