`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:40:46 02/24/2016 
// Design Name: 
// Module Name:    CSA 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CSA(x,y,z,sum,cout);
	
	parameter wit = 32;
	input [wit:0] x;
	input [wit:0] y;
	input [wit:0] z;
	
	output [wit:0] sum;
	output  [wit+1:0] cout;
	
	assign cout[0] = 0;

generate
	genvar i;
		for(i = 0; i <= wit; i = i+1)
		begin: A
		FullAdder fa1(sum[i],cout[i+1],x[i],y[i],z[i]);
		end
endgenerate
		


endmodule
