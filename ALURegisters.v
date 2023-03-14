module ALURegisters(
input clr, clk, wren,
output [31:0] r0outf, r1outf, r2outf, r3outf, r4outf, r5outf, r6outf, r7outf, r8outf, r9outf, r10outf, r11outf, r12outf, r13outf, r14outf, r15outf,
input [31:0] r0in, r1in, r2in, r3in, r4in, r5in, r6in, r7in, r8in, r9in, r10in, r11in, r12in, r13in, r14in, r15in
);

//Create the general 32-bit registers for use in the ALU/Control Unit from our code with input and output wires
	generate 
		reg32bit gr0  (r0outf, r0in, clr, clk, wren);
		reg32bit gr1  (r1outf, r1in, clr, clk, wren);
		reg32bit gr2  (r2outf, r2in, clr, clk, wren);
		reg32bit gr3  (r3outf, r3in, clr, clk, wren);
		reg32bit gr4  (r4outf, r4in, clr, clk, wren);
		reg32bit gr5  (r5outf, r5in, clr, clk, wren);
		reg32bit gr6  (r6outf, r6in, clr, clk, wren);
		reg32bit gr7  (r7outf, r7in, clr, clk, wren);
		reg32bit gr8  (r8outf, r8in, clr, clk, wren);
		reg32bit gr9  (r9outf, r9in, clr, clk, wren);
		reg32bit gr10 (r10outf, r10in, clr, clk, wren);
		reg32bit gr11 (r11outf, r11in, clr, clk, wren);
		reg32bit gr12 (r12outf, r12in, clr, clk, wren);
		reg32bit gr13 (r13outf, r13in, clr, clk, wren);
		reg32bit gr14 (r14outf, r14in, clr, clk, wren);
		reg32bit gr15 (r15outf, r15in, clr, clk, wren);
	endgenerate
endmodule 