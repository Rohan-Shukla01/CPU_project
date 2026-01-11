module i281_CPU(inp, clock);
	input[15:0] inp;
	input clock;
	wire [7:0] s10, s11, s12, s13, s14, s15, s16, s18; 
	wire [15:0] s1 ;
	wire [5:0] s5, s6, s7, s8;
	wire [22:0] s2;
	wire [3:0] s3, s4, s17;
	wire [17:0] control;
	
	code_memory cmem(clock, s18[5:0], s8, inp, control[0], s1);
	opcode_decoder d1(s1[15:8], s2, 1'b1, s3);
	control_block c_block(s2, s3, s4, control);
	program_update_logic PUL(s8, s1[5:0], s6, s5);
	mux_nbit_2port #(.n(6)) PC_mux(control[1], s5, s6, s7);
	register #(.n(6)) PC(s7,clock, s8, control[2]);
	
	mux_nbit_2port ALU_source_mux(control[10], s1[7:0] , s10, s15);
	mux_nbit_2port ALU_result_mux(control[14], s1[7:0] , s16, s18);
	mux_nbit_2port DMEM_input_mux(control[15], inp[7:0], s10, s11);
	
	data_mem DMEM(s18[3:0], s18[3:0], s11, control[16], clock, s12);
	mux_nbit_2port Reg_writeback_mux(control[17], s12, s18, s13);
	
	reg_file Register_file(control[3], control[4], control[5],control[6], control[7],control[8],control[9], s13, s14, s10, clock);
	ALU ALU_unit(control[11],control[12], s14, s15, s16, s17[3], s17[2], s17[1], s17[0]);
	register #(.n(4)) Flags(s17, clock, s4, control[13]);
endmodule
	
	
	
	
	