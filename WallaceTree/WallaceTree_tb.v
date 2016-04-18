`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:35:17 02/24/2016
// Design Name:   WallaceTree
// Module Name:   H:/359F FPGAS/HW4_CLIU/WallaceTree_tb.v
// Project Name:  HW4_CLIU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: WallaceTree
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module WallaceTree_tb;

	// Inputs
	reg [15:0] x;
	reg [15:0] y;

	// Outputs
	wire [31:0] prod;

	// Instantiate the Unit Under Test (UUT)
	WallaceTree uut (
		.x(x), 
		.y(y), 
		.prod(prod)
	);

	initial begin
		// Initialize Inputs
		x = -4;
		y = 12;
		#100;
		x = -51;
		y = 2;
		#100;
		x = 41;
		y = 12;
		#100;
		x = 0;
		y = 142;
		#100;
		x = 1011;
		y = 15;
		#100;
		x = -5;
		y = 5;
		#100;
		x = 4011;
		y = 142;
		#100;
		x = 7;
		y = 8;
		#100;
		x = -1;
		y = 1;
		#100;
        
		// Add stimulus here

	end
      
endmodule

