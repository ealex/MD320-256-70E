module sync(
	input wire in_main_clock, 			// main system clock
	input wire[2:0] in_phase_counter,	// 4 phase counter
	
	output wire out_display_clock,
	output wire out_display_hs,
	output wire out_display_vs,
	output wire[8:0] out_coord_x,
	output wire[8:0] out_coord_y
);

// display parameters
// clock ~ 6MHz, 50% duty
// clock state machine
// phase 0: clock = 0
// phase 1: clock = 0
// phase 2: clock = 1
// phase 3: clock = 1
reg display_clock;
always @(posedge in_main_clock) begin
	case(in_phase_counter)
		3'b000: display_clock <= 1'b0;
		3'b001: display_clock <= 1'b0;
		3'b010: display_clock <= 1'b0;
		3'b011: display_clock <= 1'b0;
		3'b100: display_clock <= 1'b1;
		3'b101: display_clock <= 1'b1;
		3'b110: display_clock <= 1'b1;
		3'b111: display_clock <= 1'b1;
	endcase
end
assign out_display_clock = display_clock;

//  horizontal sync
localparam HS_ACTIVE = 9'd320;
localparam HS_SYNC = 9'd64;
localparam HS_PERIOD = (HS_ACTIVE+HS_SYNC);
reg[8:0] display_x_cnt;

localparam VS_ACTIVE = 9'd256;
localparam VS_SYNC = 9'd4;
localparam VS_PERIOD = (VS_ACTIVE+VS_SYNC);
reg[8:0] display_y_cnt;

always @(posedge in_main_clock) begin
	case(in_phase_counter)
		3'b000: begin			
			display_x_cnt <= display_x_cnt + 9'd1;
			if(display_x_cnt == HS_PERIOD) begin 
				display_x_cnt <= 9'd0;
				display_y_cnt <= display_y_cnt + 9'd1;
			end
			if(display_y_cnt == VS_PERIOD) display_y_cnt <= 9'd0;
		end
		default: begin
			display_x_cnt <= display_x_cnt;
			display_y_cnt <= display_y_cnt;
		end
	endcase
end
assign out_display_hs = (display_x_cnt < HS_ACTIVE);
assign out_display_vs = (display_y_cnt < VS_ACTIVE);
//assign out_display_vs = (display_y_cnt == 0);



// display coordinates
assign out_coord_x = (display_x_cnt < HS_ACTIVE) ? display_x_cnt : 9'd0;
assign out_coord_y = (display_y_cnt < VS_ACTIVE) ? display_y_cnt : 9'd0;
endmodule