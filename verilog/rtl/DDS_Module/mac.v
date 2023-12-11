`timescale 1ns / 1ps

module mac 
#(	parameter DATA_WIDTH=16,
	parameter I_widthX=2, 
	parameter I_widthCoefa1=7,
	parameter I_widthCoefa0=7,
	parameter I_widthOut=2
)
(	input signed	[I_widthX-1: -(DATA_WIDTH-I_widthX)]			d_in,
	input signed 	[I_widthCoefa1 -1: -(DATA_WIDTH-I_widthCoefa1)]	p_in, 
	input signed 	[I_widthCoefa0 -1: -(DATA_WIDTH-I_widthCoefa0)]	coef_in,

	output signed 	[I_widthX -1: -(DATA_WIDTH-I_widthX)]			d_out,
	output signed 	[I_widthOut -1: -(DATA_WIDTH-I_widthOut)]  		p_out
);

localparam I_widthMult = I_widthX+I_widthCoefa1; 

wire signed	[I_widthMult -1 : -(2*DATA_WIDTH-I_widthMult)] fixed;
wire		[I_widthCoefa0 -1 : -(DATA_WIDTH-I_widthCoefa0 + (I_widthCoefa0-I_widthOut))]  accum; 

assign	fixed = d_in * p_in;	

assign	accum = fixed [I_widthOut-1 : -(DATA_WIDTH-I_widthOut)] + {coef_in,{(I_widthCoefa0-I_widthOut){1'b0}}};
assign	p_out = accum [I_widthOut -1 : -(DATA_WIDTH-I_widthCoefa0 + (I_widthCoefa0-I_widthOut))];
assign  d_out = d_in;

endmodule
