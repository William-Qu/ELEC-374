module ALU(
input clk, clr, stop,
input [31:0] regA, regB,
input [4:0] OPCode, 
output [31:0] regLO, regHI
);

	generate
		if (OPCode == 'b00001) ; else 																		//SHL Module Name: 
		if (OPCode == 'b00010) ; else 																		//SHR Module Name: 
		if (OPCode == 'b00011) ; else 																		//Rotate L Module Name: 
		if (OPCode == 'b00100) ; else 																		//Rotate R Module Name: 
		if (OPCode == 'b00101) ; else 																		//AND Module Name: 
		if (OPCode == 'b00110) ; else 																		//OR Module Name: 
		if (OPCode == 'b00111) NOT Not (regA, regLO); else 											//NOT Module Name: NOT
		if (OPCode == 'b01000) twoCompliment neg (regA, regLO); else 								//Neg Module Name: twoCompliment
		if (OPCode == 'b01001) ; else 																		//Add Module Name: 
		if (OPCode == 'b01010) ; else 																		//Subtract Module Name: 
		if (OPCode == 'b01011) boothMultiplier mul (regA, regB, regHI, regLO); else 			//Multiply Module Name: boothMultiplier
		if (OPCode == 'b01100) nonRestoringDivisionPosiNeg div (regA, regB, regLO, regHI);  //Divide Module Name: nonRestoringDivisionPosiNeg
	endgenerate
	
endmodule