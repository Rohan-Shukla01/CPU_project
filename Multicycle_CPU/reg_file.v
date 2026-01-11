module reg_file(c4, c5, c6,c7, c8,c9,c10, A_in, A_out_c4c5, A_out_c6c7, clock);
	input[7:0] A_in;
	input c4,c5,c6,c7,c8,c9,c10, clock;
	output [7:0] A_out_c4c5, A_out_c6c7;
	
	wire wa,wb,wc,wd; // the write enable signals for the individual registers
	wire [7:0] A_reg, B_reg, C_reg, D_reg;
	register A(A_in, clock, A_reg, wa); // default value of parameter for register is 8
	register B(A_in, clock, B_reg, wb);
	register C(A_in, clock, C_reg, wc);
	register D(A_in, clock, D_reg, wd);
	mux_8bit mux1({c4,c5}, A_reg, B_reg, C_reg, D_reg, A_out_c4c5);
	mux_8bit mux2({c6,c7}, A_reg, B_reg, C_reg, D_reg, A_out_c6c7);
	
	assign wa= c10 & ({c8,c9}==2'b00 );
	assign wb= c10 & ({c8,c9}==2'b01 );
	assign wc= c10 & ({c8,c9}==2'b10 );
	assign wd= c10 & ({c8,c9}==2'b11 );
	
endmodule
