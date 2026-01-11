module CPU_multicycle(clock);
	input clock;
	wire[22:0] opcode;
	wire[3:0] A_4bits, flags;
	wire[17:0] C_out;
	wire[15:0] instr, Mem_write, A_out;
	wire[7:0] data_reg, w_reg_file,  RD1, RD2, RD1_reg, RD2_reg, ALU_A, ALU_B, addr, ALU_result, ALU_reg, PC_reg_in, PC_reg_out;
	wire carry, overflow, negative, zero;
	
	controller control(opcode, A_4bits, clock, C_out);
	opcode_decoder decode(instr[15:8], opcode, 1'b1, A_4bits);
	combined_memory mem(clock, C_out[0], addr, Mem_write, A_out);
	register #(.n(16)) instr_reg(A_out, clock, instr, C_out[1]);
	register data_register(A_out[7:0], clock, data_reg, C_out[2]);
	mux_8bit reg_file_mux(C_out[15:14], ALU_reg, data_reg, instr[7:0], {8{1'b1}}, w_reg_file);
	reg_file rf(instr[9], instr[8], instr[11], instr[10], instr[11], instr[10], C_out[3], w_reg_file, RD1, RD2, clock);
	register RD1_register(RD1, clock, RD1_reg, 1'b1);
	register RD2_register(RD2, clock, RD2_reg, 1'b1);
	mux_8bit ALU_mux_A(C_out[5:4],{8{1'b0}}, PC_reg_out, RD1_reg, RD2_reg, ALU_A);
	mux_8bit ALU_mux_B(C_out[7:6],RD2_reg,instr[7:0], RD1_reg,{{7{1'b0}}, 1'b1}, ALU_B);
	sign_extend_16bits sign_x(RD2_reg, Mem_write);
	ALU Arith_LU(C_out[9], C_out[8], ALU_A, ALU_B, ALU_result, carry, overflow, negative, zero);
	register #(.n(4)) flags_reg({carry, overflow, negative, zero}, clock, flags, C_out[16]);
	register ALU_register(ALU_result, clock, ALU_reg, C_out[10]); 
	mux_nbit_2port #(.n(8)) PC_mux(C_out[11], ALU_reg, ALU_result, PC_reg_in);
	register PC_reg(PC_reg_in, clock, PC_reg_out, (C_out[12] || (C_out[17] && (flags[1] ~^ flags[2]))));
	mux_nbit_2port #(.n(8)) address_mux(C_out[13], ALU_reg, PC_reg_out, addr);
endmodule
