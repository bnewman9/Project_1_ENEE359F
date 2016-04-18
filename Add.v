`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:36 04/13/2016 
// Design Name: 
// Module Name:    Add 
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
module Add(input clock, input reset, input [31:0] A, input [31:0] B, input add, output reg done, output reg [31:0] SUM);
	
	reg cont_add;
	reg swap;
	reg comp;
	reg done_f;
	
	reg [23:0] s1;
	reg [23:0] s2;
	
	reg signed [7:0] e1;
	reg signed [7:0] e2;
	
	reg [23:0] p_reg;
	reg g;
	reg r;
	reg s;

	reg [23:0] tmp_s;
	reg [7:0] tmp_e; 
	reg [24:0] tmp_c;
	
	reg [3:0] state;
	reg [3:0] next;
	parameter [3:0] IDLE = 4'b0000, ONE = 4'b0001, TWO = 4'b0010, THREE = 4'b0011, FOUR = 4'b0100,
		FIVE = 4'b0101, SIX = 4'b0110, SEVEN = 4'b0111, EIGHT = 4'b1000, DONE = 4'b1001;
	
	integer i = 0;

	
	//TODO: input "add" is not a button... so it will be constant 1.. need to modify state machine...
	
	always @ (posedge clock) begin
		if (reset) begin
			state <= IDLE;
			next <= IDLE;
			done <= 0;
			cont_add <= 0;
			done_f <= 0;
		end
		//else if ((add && done == 0)  || state == DONE) begin	
		else if ((add || cont_add)   || state == DONE) begin			
			case (state)
				IDLE: begin
					done_f <= 0;
					state <= next; 				
					next <= ONE;
					cont_add <= 1;
				end
				ONE: begin 
					done_f <= 0;
					state <= next;
					next <= TWO;
					cont_add <= 1;
				end
				TWO: begin
					done_f <= 0;
					state <= next;
					next <= THREE;
					cont_add <= 1;
				end 
				THREE: begin
					done_f <= 0;
					state <= next;
					next <= FOUR;
					cont_add <= 1;
				end
				FOUR: begin	
					done_f <= 0;
					state <= next;
					next <= FIVE;					
					cont_add <= 1;
				end
				FIVE: begin
					done_f <= 0;
					state <= next;
					next <= SIX;
					cont_add <= 1;
				end
				SIX: begin
					done_f <= 0;
					state <= next;
					next <= SEVEN;
					cont_add <= 1;
				end
				SEVEN: begin
					done_f <= 0;
					state <= next;
					next <= EIGHT;
					cont_add <= 1;
				end
				EIGHT: begin
					done_f <= 0;
					state <= next;
					next <= DONE;
					cont_add <= 1;
				end
				DONE: begin 				
					
					cont_add <= 0;
					if (done_f == 0) begin
						state <= next;
						next <= DONE;
						done_f <= 1;
						done <= 1;
					end
					else begin
						state <= next;					
						next <= IDLE;
						done <= 0;
					end
					
					
				end
			endcase
		end
	end
	
	always @ (state) begin				
			case (state)
				IDLE: begin 
					e1 = 0;
					e2 = 0;
					s1 = 0;
					s2 = 0;
					swap = 0;
					comp = 0;
					comp = 0;
					p_reg = 0;
					g = 0;
					r = 0;
					s = 0;
					tmp_s = 0;
					tmp_c = 0;
					tmp_e = 0;
				end
				ONE: begin
					s1 = {1'b1, A[22:0]};
					s2 = {1'b1, B[22:0]};
					
					e1 = A[30:23];
					e2 = B[30:23];					
				end
				TWO: begin									// If e1 < e2, swap operands
					if (e1 < e2) begin
						swap = 1;
						tmp_s = s1;
						s1 = s2;
						s2 = tmp_s;
						
						tmp_e = e1;
						e1 = e2;
						e2 = tmp_e;
					end
					//SUM = e1 - e2;
				end
				THREE: begin								// if signs are difference, take the 2's compliment of s2
					if (A[31] != B[31]) begin
						comp = 1;
						s2 = ~s2 + 1'b1;
					end
				end
				FOUR: begin									// shift s2 calculate g, r, and s
					p_reg = s2;
					if (A[31] != B[31]) begin						
						for (i=0; i < 24; i = i + 1) begin
							if (i < (e1-e2)) begin
								s = s || r;
								r = g;
								g = p_reg[0];
								p_reg[22:0] = p_reg[23:1];
								p_reg[23] = 1;								
							end 
						end
					end
					else begin
						for (i=0; i < 24; i = i + 1) begin
							if (i < (e1-e2)) begin
								s = s || r;
								r = g;
								g = p_reg[0];
								p_reg[22:0] = p_reg[23:1];
								p_reg[23] = 0;								
							end 
						end
					end
					
				end
				FIVE: begin									// add S = s1 + s2
					for (i = 0; i < 24; i = i + 1) begin
						tmp_s[i] = s1[i] ^ p_reg[i] ^ tmp_c[i];
						tmp_c[i+1] = (s1[i] & p_reg[i]) | ((s1[i] ^ p_reg[i]) & tmp_c[i]);
					end	
					if ((A[31] != B[31]) && tmp_s[23] && (tmp_c[24] == 0)) begin // negative number
						tmp_s = ~tmp_s + 1'b1;
						SUM[31] = 1;
					end
				end
				SIX: begin									// normalize S, add exponent if necessary
					if ((A[31] != B[31]) && e1 == e2) begin
						r = 0;
						s = 0;
					end
					else if (tmp_c[24] == 0 && tmp_s[23] == 0 && tmp_s[22] == 1) begin
						// no change to r an s
					end
					else if (tmp_c[24] == 0 && tmp_s[23] == 1) begin
						r = g;
						s = r || s;
					end
					
					if (A[31] == B[31] && tmp_c[24]) begin
						r = tmp_s[0];
						tmp_s[22:0] = tmp_s[23:1];
						tmp_s[23] = 1;
						e1 = e1 + 1;
						s = g || r || s;
					end
					else begin
						for (i = 0; i < 24; i = i + 1) begin
							if (tmp_s[23] == 0) begin
								e1 = e1 - 1;
								tmp_s[23:1] = tmp_s[22:0];
								if (i == 0) tmp_s[0] = g;
								else tmp_s[0] = 0;
							end
						end
					end
					
					
					
				end
				SEVEN: begin
					if ((r ^ tmp_s[0]) || (r ^ s)) begin
						tmp_c = 1;					
									
						for (i = 0; i < 24; i = i + 1) begin
							tmp_s[i] = tmp_s[i] ^ 0 ^ tmp_c[i];
							tmp_c[i+1] = (tmp_s[i] & 0) | ((tmp_s[i] ^ tmp_c[i]) & 0);
						end	
						
						if (tmp_c[24]) begin						
							tmp_s[22:0] = tmp_s[23:1];
							tmp_s[23] = 1;
							e1 = e1 + 1;						
						end						
					end					
				end
				EIGHT: begin
					e1 = e1 - 127;
					SUM[30:23] = e1;
					SUM[22:0] = tmp_s[22:0];
				
					if ((A[31] == B[31]) && A[31] == 1) begin
						SUM[31] = 1;
					end
					else if ((A[31] == B[31]) && A[31] == 0) begin
						SUM[31] = 0;
					end
					else if (A[31] != B[31]) begin
						if (swap && A[31] == 1 && B[31] == 0) begin
							SUM[31] = 0;
						end
						else if (swap && A[31] == 0 && B[31] == 1) begin
							SUM[31] = 1;
						end
						else if (swap == 0 && comp == 0 && A[31] == 0 && B[31] == 1) begin
							SUM[31] = 0;
						end
						else if (swap == 0 && comp == 0 && A[31] == 1 && B[31] == 0) begin
							SUM[31] = 1;
						end
						else if (swap == 0 && comp == 1 && A[31] == 0 && B[31] == 1) begin
							SUM[31] = 1;
						end
						else if (swap == 0 && comp == 1 && A[31] == 1 && B[31] == 0) begin
							SUM[31] = 0;
						end
						
					end
					
				end
				DONE: begin
					e1 = 0;
					e2 = 0;
					s1 = 0;
					s2 = 0;
					swap = 0;
					comp = 0;
					p_reg = 0;
					g = 0;
					r = 0;
					s = 0;
					tmp_s = 0;
					tmp_c = 0;
					tmp_e = 0;
					
				end
			endcase
	end
endmodule
