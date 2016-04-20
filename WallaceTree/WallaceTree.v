`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:23 02/24/2016 
// Design Name: 
// Module Name:    WallaceTree 
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
module WallaceTree(
	input [15:0] x,
	input [15:0] y,
	output [31:0] prod
    );
	 wire [32:0] tempin [15:0];
	 wire [32:0] sums [13:0];
	 wire [32:0] carrys [13:0];
	 wire z;
	 reg [15:0] x1;
	 wire [31:0] prod1; 
	 reg neg;
	 assign z = 0;
	 
	 
	 always @ (*)
	 begin
	 if(x[15] == 1)
		begin
		x1 = (16'hFFFF - x + 1);
		neg = 1;
		end
	 else
		begin
		x1 = x;
		neg = 0;
		end
	 end
	 
	generate
		genvar i;
			for(i = 0; i < 16; i = i + 1)
			begin: A
				assign tempin[i] = (x1[i] * y) << i;
				end

	endgenerate
	
	
	CSA c0(tempin[0],tempin[1],tempin[2],sums[0],carrys[0]);
	CSA c1(tempin[3],tempin[4],tempin[5],sums[1],carrys[1]);
	CSA c2(tempin[6],tempin[7],tempin[8],sums[2],carrys[2]);
	CSA c3(tempin[9],tempin[10],tempin[11],sums[3],carrys[3]);
	CSA c4(tempin[12],tempin[13],tempin[14],sums[4],carrys[4]);
	CSA c5(sums[1],sums[0],carrys[0],sums[5],carrys[5]);
	CSA c6(carrys[1],sums[2],carrys[2],sums[6],carrys[6]);
	CSA c7(sums[3],carrys[3],sums[4],sums[7],carrys[7]);
	CSA c8(sums[5],carrys[5],sums[6],sums[8],carrys[8]);
	CSA c9(carrys[6],sums[7],carrys[7],sums[9],carrys[9]);
	CSA c10(sums[8],carrys[8],sums[9],sums[10],carrys[10]);
	CSA c11(carrys[9],tempin[15],carrys[4],sums[11],carrys[11]);
	CSA c12(sums[10],carrys[10],sums[11],sums[12],carrys[12]);
	CSA c13(sums[12],carrys[12],carrys[11],sums[13],carrys[13]);
	CPA final(sums[13],carrys[13],prod1,z);
	
	assign prod = neg?(~prod1 + 1):prod1;
	// assign prod[32] = z;
	 //CSA #(.wit(20)) e(
	// CSA #(20) csa1(x,y,z)
	
endmodule
