module data_mem(read_select, write_select, inp, write_en,clock, data_read);
	input [3:0] read_select, write_select;
	input [7:0] inp;
	input write_en, clock;
	output [7:0] data_read;
	reg [7:0] mem [15:0];
	integer i;
	initial begin 
		
		for (i= 0; i<16; i=i+1) begin
				mem[i] = 8'b00000000;
		end 
		mem[0] = 8'b00000111;
		mem[1] = 8'b00000011;
		mem[2] = 8'b00000010;
		mem[3] = 8'b00000001;
		mem[4] = 8'b00000110;
		mem[5] = 8'b00000100;
		mem[6] = 8'b00000101;
		mem[7] = 8'b00001000;
		mem[8] = 8'b00011001;
		mem[9] = 8'b00001000;
	end
	
	always@(posedge clock) begin
		if(write_en) mem[write_select]<= inp;
	end
	
	assign data_read= mem[read_select];
endmodule
		