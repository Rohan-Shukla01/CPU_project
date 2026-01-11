module control_block(A_in, Rx_Ry, Flags, c);
	input [22:0] A_in;
	input [3:0] Flags;
	output[17:0] c;
	input [3:0] Rx_Ry;
	 
	
	assign c[0]= |(A_in[2:1]);
	
	//todo assign c[1];
	assign c[1] = (A_in[18] | (A_in[19] & Flags[0]) | (A_in[20] & (~Flags[0])) | (A_in[21] & ((~Flags[0]) & (Flags[1] ~^ Flags[2]))) | (A_in[22] & (Flags[1] ~^ Flags[2])));
	//----------------------------------
	assign c[2] = 1'b1;
	assign c[3] = ((A_in[2] | A_in[4] | A_in[7] | A_in[8] | A_in[9] | A_in[10] | A_in[15] | A_in[16] | A_in[17] ) & Rx_Ry[3]) |
					  ((A_in[5] | A_in[12] | A_in[14]) & Rx_Ry[1]);
	assign c[4] = ((A_in[2] | A_in[4] | A_in[7] | A_in[8] | A_in[9] | A_in[10] | A_in[15] | A_in[16] | A_in[17] ) & Rx_Ry[2]) |
					  ((A_in[5] | A_in[12] | A_in[14]) & Rx_Ry[0]);
	assign c[5] = ((A_in[14] | A_in[13] ) & Rx_Ry[3] )| ((A_in[17] | A_in[9] | A_in[7] ) & Rx_Ry[1]);
	assign c[6] = ((A_in[14] | A_in[13] ) & Rx_Ry[2] )| ((A_in[17] | A_in[9] | A_in[7] ) & Rx_Ry[0]);
	assign c[7] = (A_in[16] | A_in[15]|A_in[12]| A_in[11] | A_in[10] | A_in[9] | A_in[8] | A_in[7] | A_in[6] | A_in[5]) & Rx_Ry[3];
	assign c[8] = (A_in[16] | A_in[15]|A_in[12]| A_in[11] | A_in[10] | A_in[9] | A_in[8] | A_in[7] | A_in[6] | A_in[5]) & Rx_Ry[2];
	assign c[9] = (A_in[16] | A_in[15]|A_in[12]| A_in[11] | A_in[10] | A_in[9] | A_in[8] | A_in[7] | A_in[6] | A_in[5]);
	assign c[10] = (A_in[2] | A_in[4] | A_in[5] | A_in[8] | A_in[10] | A_in[12] | A_in[14]);
	assign c[11] = (A_in[2] | A_in[4] | A_in[5] | A_in[7]|A_in[8] |A_in[9]| A_in[10] | A_in[12] | A_in[14] | A_in[17]);
	assign c[12] = (A_in[9] | A_in[10] | A_in[16] | A_in[17]);
	assign c[13] = |{A_in[10:7], A_in[17:15]};
	assign c[14] = (A_in[1]| A_in[3] | A_in[6] | A_in[11] | A_in[13]);
	assign c[15] = (A_in[3] | A_in[4]);
	assign c[16] = (A_in[14] | A_in[13] | A_in[3] | A_in[4]);
	assign c[17] = (A_in[11] | A_in[12]);
endmodule