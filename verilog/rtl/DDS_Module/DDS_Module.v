module DDS_Module
#(	
 DATA_WIDTH=16
)
(	input clk,
	input rst,
	input Enable,
	input LoadP,
	input LoadF,
	input [(DATA_WIDTH-1):0] FreqPhase,
	output [15:0] io_oeb,
	output signed [(DATA_WIDTH-1):0] Cos_Out
); 
assign io_oeb[15:0] = {16{1'b0}};
// This DDS Module requires a Load pulse (positive an negative edge) for updating the phase an frequency.
// For continuos updating, the Load input should be connected to a square waveform. 
DDS #(.DATA_WIDTH(DATA_WIDTH)) 
	DDS_Stage(	.clk		(clk),
				.rst		(rst),
				.Enable		(Enable),
				.LoadP		(LoadP),
				.LoadF 	  (LoadF),
				.FreqPhase		(FreqPhase),
				.Cos_Out_reg(Cos_Out)
	); 
endmodule
