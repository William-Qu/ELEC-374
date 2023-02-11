module boothMultiplier(
	input [31:0] multiplier, multiplicand,
	output [31:0] ansHI, ansLO
);
	reg [63:0] ans;
	reg [31:0] multiplicandTwos;
	
	twoCompliment(multiplicand, multiplicandTwos);
	
	
	
	
endmodule
