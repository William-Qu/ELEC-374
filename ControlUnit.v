module ControlUnit(
input clk, clr, wren, 
input [31:0] IR,
output 
)
//Built in registers to the ALU/ControlUnit
reg [31:0] r0;
reg [31:0] r1;
reg [31:0] r2;
reg [31:0] r3;
reg [31:0] r4;
reg [31:0] r5;
reg [31:0] r6;
reg [31:0] r7;
reg [31:0] r8;
reg [31:0] r9;
reg [31:0] r10;
reg [31:0] r11;
reg [31:0] r12;
reg [31:0] r13;
reg [31:0] r14;
reg [31:0] r15;

//IR Block Broken up
wire [4:0] OPCode;
wire [3:0] regASel, regBSel, destSel;
wire [31:0] dest, regA, regB;
wire [63:0] regZ;

//Break Up IR Block
assign OPCode = IR[31:27];
assign destSel = IR[26:23];
assign regASel = IR[22:19];
assign regBSel = IR[18:15];

//Temporary answers
wire [31:0] regLO, regHI, tempDest;

//Using regASel and regBSel, get the contents of the correct registers into regA and regB
	always @ (*) begin
		//Put contents of the correct register into regA using regASel
		if (regASel == 'b0000) regA = r0[31:0]; else
		if (regASel == 'b0001) regA = r1[31:0]; else
		if (regASel == 'b0010) regA = r2[31:0]; else
		if (regASel == 'b0011) regA = r3[31:0]; else
		if (regASel == 'b0100) regA = r4[31:0]; else
		if (regASel == 'b0101) regA = r5[31:0]; else
		if (regASel == 'b0110) regA = r6[31:0]; else
		if (regASel == 'b0111) regA = r7[31:0]; else
		if (regASel == 'b1000) regA = r8[31:0]; else
		if (regASel == 'b1001) regA = r9[31:0]; else
		if (regASel == 'b1010) regA = r10[31:0]; else
		if (regASel == 'b1011) regA = r11[31:0]; else
		if (regASel == 'b1100) regA = r12[31:0]; else
		if (regASel == 'b1101) regA = r13[31:0]; else
		if (regASel == 'b1110) regA = r14[31:0]; else
		if (regASel == 'b1111) regA = r15[31:0];
		
		//Put contents of the correct register into regB using regBSel
		if (regBSel == 'b0000) regB = r0[31:0]; else
		if (regBSel == 'b0001) regB = r1[31:0]; else
		if (regBSel == 'b0010) regB = r2[31:0]; else
		if (regBSel == 'b0011) regB = r3[31:0]; else
		if (regBSel == 'b0100) regB = r4[31:0]; else
		if (regBSel == 'b0101) regB = r5[31:0]; else
		if (regBSel == 'b0110) regB = r6[31:0]; else
		if (regBSel == 'b0111) regB = r7[31:0]; else
		if (regBSel == 'b1000) regB = r8[31:0]; else
		if (regBSel == 'b1001) regB = r9[31:0]; else
		if (regBSel == 'b1010) regB = r10[31:0]; else
		if (regBSel == 'b1011) regB = r11[31:0]; else
		if (regBSel == 'b1100) regB = r12[31:0]; else
		if (regBSel == 'b1101) regB = r13[31:0]; else
		if (regBSel == 'b1110) regB = r14[31:0]; else
		if (regBSel == 'b1111) regB = r15[31:0];
	end

//Do the computation with an ALU unit and get the output in the Z register
	generate
		ALU compute (clk, regA, regB, OPCode, regZ)
	endgenerate
	
//Set the HI and LO registers from the values attained in the Z register
assign regLO = regZ[31:0];
assign regHI = regZ[63:32];

	//This generate statement will be to determine which register to put the datas output into depending on destSel and if its not mult or div
	generate
		if (OPCode != 'b && OPCode != 'b) begin //If not multiplication or division, put regLO in proper register
			if (destSel == 'b0000) reg32bit tr0  (r0, regLO, clr, clk, wren); else
			if (destSel == 'b0001) reg32bit tr1  (r1, regLO, clr, clk, wren); else
			if (destSel == 'b0010) reg32bit tr2  (r2, regLO, clr, clk, wren); else
			if (destSel == 'b0011) reg32bit tr3  (r3, regLO, clr, clk, wren); else
			if (destSel == 'b0100) reg32bit tr4  (r4, regLO, clr, clk, wren); else
			if (destSel == 'b0101) reg32bit tr5  (r5, regLO, clr, clk, wren); else
			if (destSel == 'b0110) reg32bit tr6  (r6, regLO, clr, clk, wren); else
			if (destSel == 'b0111) reg32bit tr7  (r7, regLO, clr, clk, wren); else
			if (destSel == 'b1000) reg32bit tr8  (r8, regLO, clr, clk, wren); else
			if (destSel == 'b1001) reg32bit tr9  (r9, regLO, clr, clk, wren); else
			if (destSel == 'b1010) reg32bit tr10 (r10, regLO, clr, clk, wren); else
			if (destSel == 'b1011) reg32bit tr11 (r11, regLO, clr, clk, wren); else
			if (destSel == 'b1100) reg32bit tr12 (r12, regLO, clr, clk, wren); else
			if (destSel == 'b1101) reg32bit tr13 (r13, regLO, clr, clk, wren); else
			if (destSel == 'b1110) reg32bit tr14 (r14, regLO, clr, clk, wren); else
			if (destSel == 'b1111) reg32bit tr15 (r15, regLO, clr, clk, wren);
		end
	endgenerate

endmodule
