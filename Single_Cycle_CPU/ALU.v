
// following the inslide architecture for ALU, which is very simple and intuitive

module ALU(c12,c13, A_in, B_in, ALU_result, carry, overflow, negative, zero);
	input c12, c13;
	input[7:0] A_in, B_in;
	output [7:0] ALU_result;
	output carry, overflow, negative, zero;
	wire shift_out, carry_add, overflow_add;
	wire[7:0] A_out_shift, A_out_add, ALU_result_temp;
	
	shifter shift(c13, shift_out, A_in, A_out_shift);
	adder add(A_in, B_in, carry_add, overflow_add, A_out_add, c13);
	assign ALU_result_temp = c12? A_out_add: A_out_shift;
	assign carry= c12? carry_add : shift_out;
	assign overflow = c12? overflow_add: 1'b0;
	assign ALU_result= ALU_result_temp;
	
	assign negative= ALU_result_temp[7];
	assign zero= ALU_result_temp=={8{1'b0}};
	
endmodule
