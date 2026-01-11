module shifter(R, shift_out, A_in, A_out);
	input R;
	input [7:0] A_in;
	output shift_out;
	output [7:0] A_out;
	
	wire [7:0] A_temp_L, A_temp_R;
	wire shift_L, shift_R;
	assign shift_L= A_in[7];
	assign shift_R= A_in[0];
	assign A_temp_L= A_in<<1;
	assign A_temp_R = A_in>>1;
	assign A_out= (R==1'b1)? A_temp_R: A_temp_L;
	assign shift_out = (R==1'b1)? shift_R: shift_L;
endmodule
