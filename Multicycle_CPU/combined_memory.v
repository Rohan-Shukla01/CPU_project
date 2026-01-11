module combined_memory(clock, write_enable, address, A_in, A_out);
	input clock, write_enable;
	input[7:0] address;
	input[15:0] A_in;
	output[15:0] A_out;
	integer i;
	reg [15:0] mem[255:0];
	
		initial begin
		
		for (i=0; i<64; i=i+1) begin
			mem[i]= 16'b0000000000000000;	
		end

		
		
		mem[0] = 16'b0011010000000110;
		mem[1] = 16'b0011100000000111;
		mem[2] = 16'b1101011000000000;
		mem[3] = 16'b1111001100000001;
		mem[4] = 16'b1000110000111111;
		mem[5] = 16'b0100011000000000;
		mem[6] = 16'b0110011000000000;
		mem[7] = 16'b1011011000111010;
      
		mem[63] = 16'b0000000011111111;
	end
	
	always@(posedge clock) begin
		if(write_enable) begin
			mem[address]<= A_in;
		end
	end
	assign A_out=mem[address];
endmodule
