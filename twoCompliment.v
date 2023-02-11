module twoCompliment(input [31:0] d,output [31:0] q);
	integer k;
	reg j[31:0];
	always @ (*) begin
		for (k=0; k<32; k=k+1) 
			begin
				j <= !(d);
			end
		j <= j + 1'b1;
	end
	assign q = j;
	
endmodule
