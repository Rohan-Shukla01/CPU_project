module code_memory(clock, write_select, read_select, inp, write_en, instruction);
	input [5:0] write_select, read_select;
	input [15:0] inp;
	input write_en, clock;
	output [15:0] instruction;
	
	reg [15:0] mem [63:0];
	integer i;
	
	initial begin
		
		for (i=0; i<64; i=i+1) begin
			mem[i]= 16'b0000000000000000;	
		end

		
		
		mem[0]= 16'b0011000000000000;
		mem[1]= 16'b1000110000001001;   // to be changed if no of elements are changing
		mem[2]= 16'b0011010000000000;
		mem[3]= 16'b1101001100000000;
		mem[4]= 16'b1111001100001110;
		mem[5]= 16'b1000110000001001;   // to be changed if no of elements are changing
		mem[6]= 16'b0110110000000000;
		mem[7]= 16'b1101011100000000;
		mem[8]= 16'b1111001100001000;
		mem[9]= 16'b1001100100000000;
		mem[10]= 16'b1001110100000001;
		mem[11]= 16'b1101111000000000;
		mem[12]= 16'b1111001100000010;
		mem[13]= 16'b1011110100000000;
		mem[14]= 16'b1011100100000001;
		mem[15]= 16'b0101010000000001;
		mem[16]= 16'b1110000011110100;
		mem[17]= 16'b0101000000000001;
		mem[18]= 16'b1110000011101110;
	end
	
	always@(posedge clock) begin
		if(write_en) begin
			mem[write_select]<= inp;
		end
	end
	
	assign instruction=mem[read_select];
endmodule
	
	