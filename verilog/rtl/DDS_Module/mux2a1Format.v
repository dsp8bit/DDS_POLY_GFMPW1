`timescale 1ns / 1 ps

module mux2a1Format
#(	parameter DATA_WIDTH	= 16,
	parameter I_width 		= 2,
	parameter F_width		= DATA_WIDTH-I_width
)
(	input select,
	input [I_width-1 : -F_width] DataA,
	input [I_width-1 : -F_width] DataB,

	output [I_width-1 : -F_width]DataOut
);

assign DataOut = (select == 1'b1)? DataA:DataB;

endmodule
