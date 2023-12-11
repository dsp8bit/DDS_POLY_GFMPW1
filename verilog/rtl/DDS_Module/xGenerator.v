`timescale 1ns / 1 ps

module xGenerator
#(	parameter DATA_WIDTH=16,
	parameter F_width=14,
	parameter I_width =DATA_WIDTH-F_width
)
(	input clk,
	input rst,
	input enable,
	input weFreq,
	input wePhase,
	input SelMuxCos,
	input set_regs,
	input [I_width-1 : -F_width] FreqPhase,

	output signed [I_width-1 : -F_width] xarguOut
);

reg signed [I_width-1 : -F_width] 	RegF;
reg signed [I_width-1 : -F_width] 	RegP;
reg signed [I_width-1 : -F_width] 	RegFrequency;
reg signed [I_width-1 : -F_width] 	RegPhase;
reg signed [I_width-1 : -F_width] 	RegCosPhase;

wire signed[I_width-1 : -F_width] 	CosPhaseOut;
wire signed[I_width : -F_width]		Cos;
wire signed[I_width : -F_width] 	CosNew;

always @(posedge clk, negedge rst) begin
	if(!rst) begin
		RegFrequency <= 0;
		RegPhase <= 0;
	end

	else begin
		if(weFreq) 
			RegF <= FreqPhase;

		if(wePhase)
			RegP <= FreqPhase;

		if(set_regs)begin
			RegFrequency <= RegF;
			RegPhase <= RegP;
		end
			
	end 

end
	
assign Cos = RegFrequency + RegCosPhase;
assign CosNew = RegPhase;

mux2a1Format #(.I_width(I_width), .F_width(F_width)) 
	Mux_CosPhase(.select(SelMuxCos),
				.DataA({1'b0,Cos[I_width-2 : -F_width]}),
				.DataB({1'b0,CosNew[I_width-2 : -F_width]}),
				.DataOut(CosPhaseOut)
	);

always @(posedge clk, negedge rst) begin
	if(!rst) begin
		RegCosPhase <= 0;
	end

	else begin
		if(enable)
		   RegCosPhase <= CosPhaseOut;
	end
end

assign xarguOut=RegCosPhase;

endmodule

