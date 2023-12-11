`timescale 1ns / 1ps

module PolyROM
#(	parameter DATA_WIDTH	= 16,
	parameter ADDR_WIDTH	= 5,
	parameter I_widthX		= 2,
	parameter I_widthOutF	= 2,
	parameter I_widthCoef	= 7
)
(	input clk,
	input rst,
	input enable,
	input signed [I_widthX-1 : -(DATA_WIDTH-I_widthX)] x_argu,
	input [(ADDR_WIDTH-1):0] address_ram_in,

	output signed [I_widthOutF-1 : -(DATA_WIDTH-I_widthOutF)] evaluation_out
);
  
wire [I_widthX-1 : -(DATA_WIDTH-I_widthX)] x_argu_reg;
wire [DATA_WIDTH-1:0] q0;
wire [DATA_WIDTH-1:0] q1;
wire [DATA_WIDTH-1:0] q2;

ROM_memA0 #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) 
	MEM_A0(	.data	(q0), 
			.addr	(address_ram_in), 
			.clk	(clk),
			.enable	(enable)
	);

ROM_memA1 #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) 
	MEM_A1(	.data	(q1),
			.addr	(address_ram_in),
			.clk	(clk),
			.enable	(enable)
	);

ROM_memA2 #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) 
	MEM_A2(	.data	(q2),
			.addr	(address_ram_in),
			.clk	(clk),
			.enable	(enable)
	);
  
register #(.DATA_WIDTH(DATA_WIDTH))
	delay1(	.d_in	(x_argu),
			.clk_in	(clk),
			.rst_in	(rst),
			.enable	(enable),
			.d_out	(x_argu_reg)
	);

Datapath2b #(.DATA_WIDTH(DATA_WIDTH),
			 .I_widthX(I_widthX)) 
	DataMac(.x_argu	(x_argu_reg),
			.a0_in			(q0),
			.a1_in			(q1),
			.a2_in			(q2),
			.clk_in			(clk),
			.rst_in			(rst),
			.enable			(enable),
			.evaluation_out (evaluation_out)
	);

endmodule

