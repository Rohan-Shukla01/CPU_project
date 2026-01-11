module program_update_logic(pres_pc, pc_offset, PC_plus_1, PC_plus_offset);
	input [5:0] pres_pc, pc_offset;
	output [5:0] PC_plus_1, PC_plus_offset;
	
	wire [5:0] PC_temp;
	
	six_bit_adder a1(pres_pc, 6'b000001, PC_temp);
	six_bit_adder a2(PC_temp, pc_offset, PC_plus_offset);
	assign PC_plus_1= PC_temp;
endmodule
