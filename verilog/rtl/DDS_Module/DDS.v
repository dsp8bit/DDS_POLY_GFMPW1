`timescale 1ns / 1 ps

module DDS
#(	parameter DATA_WIDTH	= 16,
	parameter ADDR_WIDTH	= 5,
	parameter I_widthX		= 1,
	parameter I_widthCoef	= 7,
	parameter I_widthOutF	= 2
)
(	input clk,
	input rst,
	input Enable,
	input LoadP,
	input LoadF,
	input [(DATA_WIDTH-1):0] FreqPhase,
	
	output signed [I_widthOutF-1 : -(DATA_WIDTH-I_widthOutF)] Cos_Out_reg
); 

wire [I_widthX-1 : -(DATA_WIDTH-I_widthX)] xarguOut;
wire [I_widthOutF-1 : -(DATA_WIDTH-I_widthOutF)] Cos_Out;
wire weFreq;
wire wePhase;
wire ena_Eval;
wire SelMuxCos;
wire set_regs;

reg SelCosSine;

EvaluatorPolynomial #(	.DATA_WIDTH(DATA_WIDTH),
						.ADDR_WIDTH(ADDR_WIDTH),
						.I_widthX(I_widthX))
	Block_Cosine(	.x_argu			(xarguOut),
					.clk		 (clk),
					.rst			(rst),
					.enable			(Enable),
					.evaluation_out	(Cos_Out_reg)
	);

xGenerator #(.F_width(DATA_WIDTH-I_widthX), .I_width(I_widthX)) 
	xPoints_Generator1(	.clk		(clk),
						.rst		(rst),
						.enable		(Enable),
						.weFreq		(weFreq),
						.wePhase	(wePhase),
						.SelMuxCos	(SelMuxCos),
						.set_regs	(set_regs),
						.FreqPhase	(FreqPhase),
						.xarguOut	(xarguOut)
	);

ControlUnit LCU(.clk		(clk),
				.rst		(rst),
				.Enable		(Enable),
				.LoadP		(LoadP),
				.LoadF		(LoadF),
				.set_regs	(set_regs),
				.weFreq		(weFreq),
				.wePhase	(wePhase),
				.SelMuxCos	(SelMuxCos)
			);
endmodule

