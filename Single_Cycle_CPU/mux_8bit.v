module mux_8bit(select, A_in, B_in, C_in, D_in, arr_out); 
	
	input[7:0] A_in, B_in, C_in, D_in;
	output[7:0] arr_out;
	input[1:0] select;
	
	assign arr_out= (select==2'b00) ? A_in : 
						 (select==2'b01) ? B_in :
						 (select==2'b10) ? C_in:
						 (select==2'b11) ? D_in: {8{1'b0}};
endmodule