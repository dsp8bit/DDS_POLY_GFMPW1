`timescale 1ns / 1 ps

module  Datapath2b
#(	parameter DATA_WIDTH		= 16,
	parameter I_widthX			= 2,
	parameter I_widthCoefa0	= 7, 
	parameter I_widthCoefa1	= 7,
	parameter I_widthCoefa2	= 7,
	parameter I_widthOut		= 6,
	parameter I_widthOutF		= 2
)
(	input	clk_in,
	input	rst_in,
	input	enable,
	input	[I_widthX-1 : -(DATA_WIDTH-I_widthX)] x_argu,
	input	[I_widthCoefa0-1 : -(DATA_WIDTH-I_widthCoefa0)] a0_in,
	input	[I_widthCoefa1-1 : -(DATA_WIDTH-I_widthCoefa1)] a1_in,
	input	[I_widthCoefa2-1 : -(DATA_WIDTH-I_widthCoefa2)] a2_in,
	
	output signed [I_widthOutF-1 : -(DATA_WIDTH-I_widthOutF)] evaluation_out	
);

wire signed [I_widthOut -1: -(DATA_WIDTH-I_widthOut)]		x_argu1;
wire signed [I_widthOut -1: -(DATA_WIDTH-I_widthOut)]		x_argu2;
wire signed [I_widthOutF -1: -(DATA_WIDTH-I_widthOutF)]		x_argu3;
wire signed [I_widthX-1: -(DATA_WIDTH-I_widthX)] 			datax_argu1;
wire signed [I_widthX-1: -(DATA_WIDTH-I_widthX)] 			datax_argu2;
wire signed [I_widthX-1: -(DATA_WIDTH-I_widthX)] 			datax_argu3;
wire signed [I_widthCoefa0-1 : -(DATA_WIDTH-I_widthCoefa0)] awire1;

mac #(DATA_WIDTH,
	  I_widthX,
	  I_widthCoefa1,
	  I_widthCoefa2,
	  I_widthOut)
	mac1( .d_in		(x_argu),
	 	  .p_in		(a2_in),
	 	  .coef_in	(a1_in),
	 	  .d_out	(datax_argu1),
	 	  .p_out	(x_argu1)
	); 
  
register #(.DATA_WIDTH(DATA_WIDTH))
	delay1(.d_in	(datax_argu1),
		  .clk_in	(clk_in),
		  .rst_in	(rst_in),
		  .enable	(enable),
		  .d_out	(datax_argu2)
  );

register #(.DATA_WIDTH(DATA_WIDTH))
	delay2(.d_in	(x_argu1),
 		  .clk_in	(clk_in),
		  .rst_in	(rst_in),
		  .enable	(enable),
		  .d_out	(x_argu2)
  );

register #(.DATA_WIDTH(DATA_WIDTH))
	delay3(.d_in	(a0_in),
 		  .clk_in	(clk_in),
		  .rst_in	(rst_in),
		  .enable	(enable),
		  .d_out	(awire1)
  );
  
mac #(DATA_WIDTH,
	  I_widthX,
	  I_widthOut,
	  I_widthCoefa0,
	  I_widthOutF)
	mac2( .d_in		(datax_argu2),
		  .p_in		(x_argu2),
		  .coef_in	(awire1),
		  .d_out	(datax_argu3),
		  .p_out	(x_argu3)
  );

//register #(.DATA_WIDTH(DATA_WIDTH))delay4(.d_in(x_argu3), .clk_in(clk_in), .rst_in(rst_in), .d_out(urgn_out));
register #(.DATA_WIDTH(DATA_WIDTH))
	delay5(.d_in	(x_argu3),
		  .clk_in	(clk_in),
		  .rst_in	(rst_in),
		  .enable	(enable),
		  .d_out	(evaluation_out)
  );
  
endmodule
