`timescale 1ns/1ns

module ROM_memA1
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
			 0 : data = 32'hffff292c;
			 1 : data = 32'hffe5ecab;
			 2 : data = 32'hff86e5be;
			 3 : data = 32'hfeb91212;
			 4 : data = 32'hfd5c2134;
			 5 : data = 32'hfb5b3e30;
			 6 : data = 32'hf8af2d5d;
			 7 : data = 32'hf55f9c9b;
			 8 : data = 32'hf1838ed5;
			 9 : data = 32'hed40d7b0;
			10 : data = 32'he8caa8cc;
			11 : data = 32'he45f3ee1;
			12 : data = 32'he044c8f4;
			13 : data = 32'hdcc5af33;
			14 : data = 32'hda2c6812;
			15 : data = 32'hd8bf1192;
			16 : data = 32'hd8bb092a;
			17 : data = 32'hda50be7e;
			18 : data = 32'hdd9ffbde;
			19 : data = 32'he2b4db62;
			20 : data = 32'he985987f;
			21 : data = 32'hf1f16465;
			22 : data = 32'hfbc057e4;
			23 : data = 32'h06a49055;
			24 : data = 32'h123c76c1;
			25 : data = 32'h1e1621eb;
			26 : data = 32'h29b3b58a;
			27 : data = 32'h349093c6;
			28 : data = 32'h3e272a60;
			29 : data = 32'h45f71b70;
			30 : data = 32'h4b8b7b29;
			31 : data = 32'h4e80d83f;
		endcase
	end
end

endmodule
