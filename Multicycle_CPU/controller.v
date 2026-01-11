module controller(A_in, A_vec_4bits, clock, C_out);
	input[22:0] A_in;
	input[3:0] A_vec_4bits;
	input clock;
	output reg [17:0] C_out;
	
	reg [3:0] state, nextstate;
	localparam S_idle = 4'b0000, S_decode = 4'b0001, S2 = 4'b0010, S3=4'b0011, S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000, S9 = 4'b1001,
	           S10= 4'b1010, S11= 4'b1011, S12 = 4'b1100, S13= 4'b1101, S14= 4'b1110, S15 = 4'b1111 ;
	always@(posedge clock) begin
		state<= nextstate;
	end
	
	always@(state, A_in) begin
		nextstate<= state;
		C_out<= {18{1'b0}};
		
		case(state)
			S_idle: begin
				C_out[1]<=1'b1;
				C_out[13]<=1'b0;
				C_out[5:4]<=2'b01;
				C_out[7:6]<=2'b11;
				C_out[9:8]<=2'b10;
				C_out[10]<=1'b1;
				nextstate<=S_decode;
			end
			S_decode: begin
				C_out[11]<= 1'b1;
				C_out[12]<=1'b1;
				if(A_in[12] || A_in[14]) nextstate<=S2;
				else if(A_in[6]) nextstate<=S5;
				else if(A_in[11] || A_in[13]) nextstate<= S6;
				else if(A_in[8]) nextstate<= S7;
				else if(A_in[10]) nextstate<= S9;
				else if(A_in[7]) nextstate<= S10;
				else if(A_in[9] || A_in[17]) nextstate<= S11;
				else if(A_in[18]) nextstate<= S12;
				else if(A_in[21] || A_in[22]) nextstate<= S14;
				else nextstate<= S_idle;
				
			end
			S2: begin
				C_out[5:4]<=2'b10;
				C_out[7:6]<=2'b01;
				C_out[9:8]<=2'b10;
				C_out[10]<=1'b1;
				if (A_in[12]) nextstate<= S3;
				else nextstate<= S13;
			end
			S3: begin
				C_out[13]<=1'b1;
				C_out[2]<=1'b1;
				nextstate<= S4;
			end
			S4: begin
				C_out[15:14]<=2'b01;
				C_out[3]<=1;
				nextstate<=S_idle;
			end
			S5: begin
				C_out[15:14]<= 2'b10;
				C_out[3]<=1'b1;
				nextstate<=S_idle;
			end
			S6: begin
				C_out[5:4]<= 2'b00;
				C_out[7:6]<= 2'b01;
				C_out[9:8]<= 2'b10;
				C_out[10]<= 1'b1;
				if(A_in[11]) nextstate<= S3;
				else nextstate<= S13;
			end
			S7: begin
				C_out[5:4]<= 2'b11;
				C_out[7:6]<= 2'b01;
				C_out[9:8]<= 2'b10;
				C_out[10]<= 1'b1;
				nextstate<= S8;
			end
			S8: begin 
				C_out[15:14]<= 2'b00;
				C_out[3]<=1'b1;
				nextstate<= S_idle;
			end
			S9: begin
				C_out[5:4]<= 2'b11;
				C_out[7:6]<= 2'b01;
				C_out[9:8]<= 2'b11;
				C_out[10]<= 1'b1;
				nextstate<= S8;
			end
			S10: begin
				C_out[5:4]<= 2'b10;
				C_out[7:6]<= 2'b00;
				C_out[9:8]<= 2'b10;
				C_out[10]<= 1'b1;
				nextstate<= S8;
			end
			S11: begin 
				C_out[5:4]<= 2'b11;
				C_out[7:6]<= 2'b10;
				C_out[9:8]<= 2'b11;
				C_out[10]<= 1'b1;
				C_out[16]<= 1'b1;
				if(A_in[17]) nextstate<= S_idle;
				else if(A_in[9]) nextstate<= S8;
			end
			S12: begin
				C_out[5:4]<= 2'b00;
				C_out[7:6]<= 2'b01;
				C_out[9:8]<= 2'b10;
				C_out[11]<= 1'b0;
				C_out[12]<= 1'b1;
				nextstate<= S_idle;
			end
			S13: begin
				C_out[13]<= 1'b1;
				C_out[0]<= 1'b1;
				nextstate<= S_idle;
			end
			S14: begin
				C_out[5:4] <= 2'b01;
				C_out[7:6] <= 2'b01;
				C_out[9:8] <= 2'b10;
				C_out[17] <= 1'b1;
				C_out[11] <= 1'b0;
				nextstate<= S_idle;
			end
			default: nextstate<= S_idle;
		endcase
	end
endmodule
			
			