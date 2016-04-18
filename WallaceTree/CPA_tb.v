`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:05:59 02/24/2016
// Design Name:   CPA
// Module Name:   H:/359F FPGAS/HW4_CLIU/CPA_tb.v
// Project Name:  HW4_CLIU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPA_tb;

	// Inputs
	reg [31:0] x;
	reg [31:0] y;

	// Outputs
	wire [31:0] sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	CPA uut (
		.x(x), 
		.y(y), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		x = 0;
		y = 0;
		#100;
      x = 1;
		y = 1;
		#100;
      x = 2;
		y = 2;
		#100;
      x = 4;
		y = 1;
		#100;
      x = 12;
		y = 71;
		#100;
      x = 62;
		y = 12;
		#100;
		x = 5;
		y = 16;
		#100;
		x = 16'hFFFF;
		y = 16'hFFFF;

	end
      
endmodule

