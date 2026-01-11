module generic_decoder(enable, w, y);
	parameter n=4;
	input[n-1:0] w;
	input enable;
	output reg [(1<<n)-1:0] y;
	always @(*) begin
		y = {(1<<n){1'b0}};
		if(enable==1'b1) y[w] = 1'b1;   // The non blocking assignment in combinational circuits 
												   //can lead to race conditions while simulating
	end 
endmodule
	