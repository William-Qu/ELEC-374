module twoCompliment(input [31:0] d,output [31:0] q);
	reg j[31:0];
	always @ (*) begin
		j = !(d);
		j = j + 1'b1;
		q = j;
	end	
endmodule
