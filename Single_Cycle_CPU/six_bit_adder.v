module six_bit_adder(A, B,S);
input [5 : 0] A,B;
output reg [5:0] S;

always@(*) begin

S = A + B;

end 
endmodule
