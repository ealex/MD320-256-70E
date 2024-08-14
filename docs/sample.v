module top
(
	clk_50,
	el_tvid,
	el_vs,
	el_hs,
	el_vclk,
	el_vid
);

input 	wire 	clk_50;
output 	reg 	el_vid;
output 	reg 	el_tvid;
output 	wire 	el_vs = (y_count == 0);
output 	wire 	el_hs = x_count < 512;
output 	reg 	el_vclk;

reg [9:0] 	x_count;
reg [8:0] 	y_count;
reg [1:0] 	cnt;
reg	[13:0]	front_porch;
reg			poop;

initial begin
	el_tvid <= 0;
	el_vclk <= 0;
end


always @(posedge clk_50)
begin

	cnt <= cnt + 1;
	
	if(cnt == 1) el_vclk <= ~el_vclk;
	poop <= el_vclk;
	
	// 100uS front porch
	if(front_porch > 0) begin
		front_porch <= front_porch + 1;
		if(front_porch == 10000 ) begin
			front_porch <= 0;
			x_count <= 0;
			y_count <= 0;
		end
	end
	
	if(~el_vclk && poop) begin
		x_count <= x_count + 1;
		if(x_count == 520) begin
			x_count <= 0;
			y_count <= y_count + 1;
		end
		if(y_count == 256) front_porch <= 1;
	end
	
	el_vid <= ~img_data[x_count];
end

wire [511:0] img_data;

img	img_inst (
	.address 	( y_count ),
	.clock 		( clk_50 ),
	.q 			( img_data )
);

endmodule