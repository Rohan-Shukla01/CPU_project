module sign_extend_16bits(A_in, A_out);
	input[7:0] A_in;
	output[15:0] A_out;
	
	assign A_out ={ {8{A_in[7]}}, A_in };
endmodule
