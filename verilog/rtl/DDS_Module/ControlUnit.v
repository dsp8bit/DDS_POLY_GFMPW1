`timescale 1ns / 1 ps

module ControlUnit
(
	input clk,
	input rst,
	input Enable, 
	input LoadP, 
	input LoadF, 

	output reg set_regs,
	output reg weFreq,
	output reg wePhase,
	output reg SelMuxCos
);

// Declare state register
reg	[2:0] state;
reg SelMuxConfig;
reg SelMuxConfigReg;

always@(*) begin
	if(( SelMuxConfigReg == 1'b0))
		SelMuxCos = 1'b0;
	else
	   SelMuxCos = 1'b1;
end

always@(posedge clk or negedge rst) begin
	if(!rst) begin
		SelMuxConfigReg <= 1'b0;
	end
	
	else begin
		SelMuxConfigReg <= SelMuxConfig;
	end			
end

// Declare states
parameter Evaluating	= 0;
parameter LoadingP		= 1;
parameter LoadingF		= 2;
parameter ConfiguringP	= 3;
parameter ConfiguringF	= 4;

// Output depends only on the state
always @(*) begin
	case (state)
		Evaluating:
		   begin
			  SelMuxConfig = 1'b1;
			  weFreq = 1'b0;
			  wePhase = 1'b0;
			  set_regs = 1'b0;
			end

		LoadingP:
		   begin
			  SelMuxConfig = 1'b1;
			  weFreq = 1'b0;
			  wePhase = 1'b1;
			  set_regs = 1'b0;
			end

		LoadingF:
		   begin
			  SelMuxConfig = 1'b1;
			  weFreq = 1'b1;
			  wePhase = 1'b0;
			  set_regs = 1'b0;
			end

		ConfiguringP:
		   begin
			  SelMuxConfig = 1'b0;
			  weFreq = 1'b0;
			  wePhase = 1'b0;
			  set_regs = 1'b1;
		   end

		ConfiguringF:
		   begin
			  SelMuxConfig = 1'b1;
			  weFreq = 1'b0;
			  wePhase = 1'b0;
			  set_regs = 1'b1;
		   end

		default:
			begin
			  SelMuxConfig = 1'b1;
			  weFreq = 1'b0;
			  wePhase = 1'b0;
			  set_regs = 1'b0;
			end
	endcase
end

// Determine the next state
always @ (posedge clk or negedge rst) begin
	if (!rst)
		state <= Evaluating;
	else
		case (state)
			Evaluating:
				if(Enable & LoadP & !LoadF)
					state <= LoadingP;
				else if(Enable & !LoadP & LoadF)
					state <= LoadingF;
				else
					state <= Evaluating;

			LoadingP:
				if(Enable & !LoadP & !LoadF)
					state <= ConfiguringP;
				else
					state <= LoadingP;

			LoadingF:
				if(Enable & !LoadP & !LoadF)
					state <= ConfiguringF;
				else if(Enable & LoadP & LoadF)
					state <= LoadingP;
				else
					state <= LoadingF;

			ConfiguringF, ConfiguringP:
				   state <= Evaluating;
	
			default : state <= Evaluating; 
		endcase
end
	
endmodule

