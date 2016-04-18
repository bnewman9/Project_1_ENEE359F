`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:05 02/10/2016 
// Design Name: 
// Module Name:    FullAdder 
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
module FullAdder(SUM,C_out,A,B,C_in);
	input A, B, C_in;
	output SUM, C_out;
wire w1, w2, w3;
nHalfAdder HA1(w1, w2, A, B);
nHalfAdder HA2(SUM, w3, C_in, w1);
assign C_out = w2 | w3;
    

endmodule
