`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:10:07 02/24/2016
// Design Name:   CSA
// Module Name:   H:/359F FPGAS/HW4_CLIU/CSA_tb.v
// Project Name:  HW4_CLIU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CSA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CSA_tb;

	// Inputs
	reg [32:0] x;
	reg [32:0] y;
	reg [32:0] z;

	// Outputs
	wire [32:0] sum;
	wire [33:0] cout;

	// Instantiate the Unit Under Test (UUT)
	CSA uut (
		.x(x), 
		.y(y), 
		.z(z), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		x = 0;
		y = 0;
		z = 0;
		#100;
      x = 1;
		y = 1;
		z = 1;
		#100;
      x = 2;
		y = 2;
		z = 2;
		#100;
      x = 4;
		y = 1;
		z = 6;
		#100;
      x = 12;
		y = 71;
		z = 2;
		#100;
      x = 62;
		y = 12;
		z = 77;
		#100;
		x = 100000;
		y = 100000000;
		z = 100000;
		#100;
        
        
		// Add stimulus here

	end
      
endmodule

