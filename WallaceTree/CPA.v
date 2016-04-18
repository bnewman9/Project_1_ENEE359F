`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:04 02/24/2016 
// Design Name: 
// Module Name:    CPA 
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
module CPA(
	input [32:0] x,
	input [32:0] y,
	output [32:0] sum,
	output cout
    );
	 wire [32:0] cin;
	 assign cin[0] = 0;
	 
	generate
		genvar i;
			for(i = 0 ; i < 32; i = i + 1)
			begin: A
				FullAdder fa(sum[i],cin[i+1],x[i],y[i],cin[i]);
			end
	endgenerate
	
assign cout = cin[32]; 	
	
	

endmodule
