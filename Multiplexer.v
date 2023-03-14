module Multiplexer(
input r0out, r1out, r2out, r3out, r4out, r5out, r6out, r7out, r8out, r9out, r10out, r11out, r12out, r13out, r14out, r15out,RegHiOut,RegLoOut,ZHiOut,ZLoOut,PCOut,MDROut,RegInportOut,CLoOut,
input [4:0] EnOut,
output [31:0] BusMuxOut
);
	reg [31:0] BusMuxOutTemp;

	//Set the temporary BusMuxOut to be the correct output depending on the logic signal
	always @ (*) begin
		if (EnOut == 5'b00000) BusMuxOutTemp = r0out;
		if (EnOut == 5'b00001) BusMuxOutTemp = r1out;
		if (EnOut == 5'b00010) BusMuxOutTemp = r2out;
		if (EnOut == 5'b00011) BusMuxOutTemp = r3out;
		if (EnOut == 5'b00100) BusMuxOutTemp = r4out;
		if (EnOut == 5'b00101) BusMuxOutTemp = r5out;
		if (EnOut == 5'b00110) BusMuxOutTemp = r6out;
		if (EnOut == 5'b00111) BusMuxOutTemp = r7out;
		if (EnOut == 5'b01000) BusMuxOutTemp = r8out;
		if (EnOut == 5'b01001) BusMuxOutTemp = r9out;
		if (EnOut == 5'b01010) BusMuxOutTemp = r10out;
		if (EnOut == 5'b01011) BusMuxOutTemp = r11out;
		if (EnOut == 5'b01100) BusMuxOutTemp = r12out;
		if (EnOut == 5'b01101) BusMuxOutTemp = r13out;
		if (EnOut == 5'b01110) BusMuxOutTemp = r14out;
		if (EnOut == 5'b01111) BusMuxOutTemp = r15out;
		if (EnOut == 5'b10000) BusMuxOutTemp = RegHiOut; 
		if (EnOut == 5'b10001) BusMuxOutTemp = RegLoOut;
		if (EnOut == 5'b10010) BusMuxOutTemp = ZHiOut;
		if (EnOut == 5'b10011) BusMuxOutTemp = ZLoOut;
		if (EnOut == 5'b10100) BusMuxOutTemp = PCOut;
		if (EnOut == 5'b10101) BusMuxOutTemp = MDROut;
		if (EnOut == 5'b10110) BusMuxOutTemp = RegInportOut;
		if (EnOut == 5'b10111) BusMuxOutTemp = CLoOut;
	end
	
	assign BusMuxOut = BusMuxOutTemp;
	
endmodule 