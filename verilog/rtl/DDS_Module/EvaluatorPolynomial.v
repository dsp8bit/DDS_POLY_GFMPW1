`timescale 1ns / 1 ps

module EvaluatorPolynomial
#(	parameter DATA_WIDTH	= 16,
	parameter ADDR_WIDTH	= 5,
	parameter I_widthX		= 1,
	parameter I_widthCoef	= 7,
	parameter I_widthOutF	= 2,
	parameter fileA2 = "coefA2Cos.txt",
	parameter fileA1 = "coefA1Cos.txt",
	parameter fileA0 = "coefA0Cos.txt"
)
(	input clk,
	input rst,
	input enable,
	input signed [I_widthX-1 : -(DATA_WIDTH-I_widthX)] x_argu, 

	output signed [I_widthOutF-1 : -(DATA_WIDTH-I_widthOutF)] evaluation_out
 );

wire [I_widthX-1 : -(DATA_WIDTH-I_widthX)]	x_argu_out;
wire [ADDR_WIDTH-1:0]						address_agu_out;
wire [I_widthOutF-1 : -(32-I_widthOutF)]	w_evaluation_out;

assign evaluation_out = w_evaluation_out[I_widthOutF-1 : -(16-I_widthOutF)];
//PolyRAM #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH),.I_widthX(I_widthX),.fileA0(fileA0),.fileA1(fileA1),.fileA2(fileA2)) PolyRAM_1 (clk, rst, enable,x_argu_out, address_agu_out, evaluation_out);
PolyROM #(	.DATA_WIDTH(32),
			.ADDR_WIDTH(ADDR_WIDTH),
			.I_widthX(I_widthX)) 
	PolyRAM_1 (	.clk(clk),
				.rst(rst),
				.enable(enable),
				.x_argu({x_argu_out,16'h0000}),
				.address_ram_in(address_agu_out),
				.evaluation_out(w_evaluation_out)
	);

aguCosQI2_16b #(.DATA_WIDTH(DATA_WIDTH),
				.ADDR_WIDTH(ADDR_WIDTH),
				.I_width(I_widthX),
				.F_width(DATA_WIDTH-I_widthX)) 
	agu_1 (	.agu_control_in			(enable),
			.agu_urgn_in			(x_argu),
			.agu_reset_in			(rst),
			.agu_clock_in			(clk),
			.agu_address_coef_out	(address_agu_out),
			.agu_urgn_out			(x_argu_out)
	);

endmodule
