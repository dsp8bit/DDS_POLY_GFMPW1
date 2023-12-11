`timescale 1ns/1ns

module ROM_memA2
#(	parameter DATA_WIDTH=32, 
	parameter ADDR_WIDTH=5, 
	parameter file="coefA0Cos.txt"
)
(	input clk,
	input enable,
	input [(ADDR_WIDTH-1):0] addr,
	output reg [(DATA_WIDTH-1):0] data
); 
 
always @ (posedge clk) begin
	if (enable)	begin
		case (addr)
			 0 : data = 32'hd8ba3256;
			 1 : data = 32'hda36ab29;
			 2 : data = 32'hdd26e19b;
			 3 : data = 32'he16ded74;
			 4 : data = 32'he6e1b9b3;
			 5 : data = 32'hed4ca295;
			 6 : data = 32'hf46f8541;
			 7 : data = 32'hfc042cf0;
			 8 : data = 32'h03c00596;
			 9 : data = 32'h0b56f99a;
			10 : data = 32'h127e5e56;
			11 : data = 32'h18efd2a7;
			12 : data = 32'h1e6bf353;
			13 : data = 32'h22bccaa3;
			14 : data = 32'h25b7e33b;
			15 : data = 32'h273fe9d0;
			16 : data = 32'h2745cdaa;
			17 : data = 32'h25c954d7;
			18 : data = 32'h22d91e65;
			19 : data = 32'h1e92128c;
			20 : data = 32'h191e464d;
			21 : data = 32'h12b35d6b;
			22 : data = 32'h0b907abf;
			23 : data = 32'h03fbd310;
			24 : data = 32'hfc3ffa6a;
			25 : data = 32'hf4a90666;
			26 : data = 32'hed81a1aa;
			27 : data = 32'he7102d59;
			28 : data = 32'he1940cad;
			29 : data = 32'hdd43355d;
			30 : data = 32'hda481cc5;
			31 : data = 32'hd8c01630;
		endcase
	end
end

endmodule
