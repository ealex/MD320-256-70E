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
//localparam	character = 8'h21;
character_ram character_ram_inst (
	.WrAddress(11'd0),
	.RdAddress(character_ram_index),
	.Data(8'd0),
	.WE(1'b0), 
    .RdClock(main_clock),
	.RdClockEn(1'b1),
	.Reset(1'b0),
	.WrClock(main_clock),
	.WrClockEn(1'b0), 
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
	.o_Rx_Byte()
);

// debug signals
assign debug_out_display_clock = out_display_clock;
assign debug_out_display_data = out_display_data;
assign debug_out_display_hs = out_display_hs;
assign debug_out_display_vs = out_display_vs;
endmodule
