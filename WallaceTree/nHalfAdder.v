`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:10:50 02/10/2016 
// Design Name: 
// Module Name:    nHalfAdder 
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
module nHalfAdder(
output SUM,
output C_out,
input A,
input B
    );

assign SUM = A ^ B;
assign C_out = A & B;

endmodule
