`timescale 1ns/1ns

module ROM_memA0
#(	parameter DATA_WIDTH=32, 
	parameter ADDR_WIDTH=5, 
	parameter file="coefA0Cos.txt"
)
(	input clk,
	input enable,
	input [(ADDR_WIDTH-1):0] addr,
	output reg [(DATA_WIDTH-1):0] data
);

always @(posedge clk) begin
	if (enable)	begin
		case (addr)
			 0 : data = 32'h02000091;
			 1 : data = 32'h02006e4e;
			 2 : data = 32'h0203749f;
			 3 : data = 32'h020d299a;
			 4 : data = 32'h0223040e;
			 5 : data = 32'h024b18fb;
			 6 : data = 32'h028b3164;
			 7 : data = 32'h02e7cc40;
			 8 : data = 32'h036322be;
			 9 : data = 32'h03fc45c6;
			10 : data = 32'h04ae6b05;
			11 : data = 32'h05707d62;
			12 : data = 32'h063500ef;
			13 : data = 32'h06ea554e;
			14 : data = 32'h077b5b51;
			15 : data = 32'h07d07bec;
			16 : data = 32'h07d10770;
			17 : data = 32'h0764dd3d;
			18 : data = 32'h067645d9;
			19 : data = 32'h04f3e412;
			20 : data = 32'h02d29e1f;
			21 : data = 32'h000f5d77;
			22 : data = 32'hfcb083fb;
			23 : data = 32'hf8c6f6d2;
			24 : data = 32'hf46ea348;
			25 : data = 32'hefce67ab;
			26 : data = 32'heb1751cc;
			27 : data = 32'he6832d65;
			28 : data = 32'he25266b6;
			29 : data = 32'hdec94fa3;
			30 : data = 32'hdc2cdfe9;
			31 : data = 32'hdabf1269;
		endcase
	end
end

endmodule
