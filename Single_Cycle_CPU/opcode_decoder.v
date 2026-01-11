module opcode_decoder(A_in, Y_out, enable, A_vec_4bits);
	input [7:0] A_in;
	input enable;
	output[22:0] Y_out;
	wire y1,y12,y15;
	output[3:0] A_vec_4bits;
	wire  [15:0] Y_temp; 
	
	generic_decoder d1(enable, A_in[7:4], Y_temp);//{Y_out[0], y1, Y_out[5:14], y12, Y_out[17:18], y15});
	generic_decoder #(.n(2)) d2(y1, A_in[1:0], Y_out[4:1]);
	generic_decoder #(.n(2)) d3(y15, A_in[1:0], Y_out[22:19]);
	generic_decoder #(.n(1)) d4(y12, A_in[0], Y_out[16:15]);
	
	assign A_vec_4bits = A_in[3:0];
	assign Y_out[0] = Y_temp[0];
	assign y1= Y_temp[1];
	assign y12= Y_temp[12];
	assign y15= Y_temp[15];
	assign Y_out[14:5]= Y_temp[11:2];
	assign Y_out[18:17]= Y_temp[14:13];
endmodule