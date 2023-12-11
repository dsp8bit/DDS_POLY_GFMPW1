`timescale 1ns / 1 ps

module  register 
#(	parameter DATA_WIDTH = 16
)          
(	input clk_in,
	input rst_in,
	input enable,
	input [(DATA_WIDTH-1):0] d_in,  

	output reg [(DATA_WIDTH-1):0] d_out
);	

always @(posedge clk_in or negedge rst_in) begin
	if (!rst_in) begin 
			d_out <= 0; 
	end
	
	else begin
	   if(enable) begin 
			d_out <= d_in;
		end	
	end
end

endmodule
