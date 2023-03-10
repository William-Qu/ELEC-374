//Initialize MUX
module Bus(
input clr, clk, wren, MDRRead, ALUen, //Bits for enabling and disabling register functions
input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout,PCout, MDRout, InportOut, Cout, //Output Select Signals for which register were taking data from
input r0ins, r1ins, r2ins, r3ins, r4ins, r5ins, r6ins, r7ins, r8ins, r9ins, r10ins, r11ins, r12ins, r13ins, r14ins, r15ins, HIins, LOins, ZHIins, ZLOins,PCins, MDRins, Outports, IRins, //Input Select Signals for which register were putting data into
input [31:0] MDRMDataIn, //MDR Data In register
output [31:0] OutportOut //Outport Output Signal to output signals to a display
);
			
			//These are the output wires of the hardware modules
			wire [31:0] r0outf, r1outf, r2outf, r3outf, r4outf, r5outf, r6outf, r7outf, r8outf, r9outf, r10outf, r11outf, r12outf, r13outf, r14outf, r15outf;
			wire [31:0] MDROut, PCOut, RegHiOut, RegLoOut, IROut, ZLoOut, ZHiOut, BusMuxOut, RegInportOut, CLoOut, CHiOut;
			wire [63:0] ALUOutput;
			wire [4:0] EnIn, EnOut;
			
			//These are the input wires of the hardware modules
			reg [31:0] r0in, r1in, r2in, r3in, r4in, r5in, r6in, r7in, r8in, r9in, r10in, r11in, r12in, r13in, r14in, r15in;
			reg [31:0] MDRMuxIn, PCIn, RegHiIn, RegLoIn, IRIn, ZLoIn, ZHiIn, RegInportIn, RegOutportIn, CLoIn, CHiIn;
			
			//IR Breakdown Registers
			wire [4:0] OPCode;
			wire [3:0] regASel, regBSel, destSel;
			reg [31:0] regA, regB, immVal;
			
			//Generate Outside Hardware (Generally only in the ALU so far)
			generate
				reg32bit PC  (PCOut, PCIn, clr, clk, wren);
				reg32bit RegHi  (RegHiOut, RegHiIn, clr, clk, wren);
				reg32bit RegLo  (RegLoOut, RegLoIn, clr, clk, wren);
				reg32bit IR  (IROut, IRIn, clr, clk, wren);
				reg32bit ZLO (ZLoOut, ZLoIn, clr, clk, wren);
				reg32bit ZHI (ZHiOut, ZHiIn, clr, clk, wren);
				MDRunit mdr (MDRRead, clr, clk, wren, MDRMuxIn, MDRMDataIn, MDROut);
				
				reg32bit InPort (RegInportOut, RegInportIn, clr, clk, wren);
				reg32bit OutPort (RegOutportOut, RegOutportIn, clr, clk, wren);
				
				reg32bit CLO (CLoOut, CLoIn, clr, clk, wren);
				reg32bit CHI (CHiOut, CHiIn, clr, clk, wren);
				
				ALU Logic (clk, regA, regB, OPCode, ALUOutput);
				ALURegisters LogicReg (clr, clk, wren, r0in, r1in, r2in, r3in, r4in, r5in, r6in, r7in, r8in, r9in, r10in, r11in, r12in, r13in, r14in, r15in, r0outf, r1outf, r2outf, r3outf, r4outf, r5outf, r6outf, r7outf, r8outf, r9outf, r10outf, r11outf, r12outf, r13outf, r14outf, r15outf);
			endgenerate 
			
			//Generate the Bus Control System (Encoder and Multiplexer)
			generate
				encoder EnO (R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout,PCout, MDRout, InportOut, Cout, EnOut);
				encoder EnI (r0ins, r1ins, r2ins, r3ins, r4ins, r5ins, r6ins, r7ins, r8ins, r9ins, r10ins, r11ins, r12ins, r13ins, r14ins, r15ins, HIins, LOins, ZHIins, ZLOins,PCins, MDRins, IRins, Outports, EnIn);
				Multiplexer Mux (r0outf, r1outf, r2outf, r3outf, r4outf, r5outf, r6outf, r7outf, r8outf, r9outf, r10outf, r11outf, r12outf, r13outf, r14outf, r15outf,RegHiOut,RegLoOut,ZHiOut,ZLoOut,PCOut,MDROut,RegInportOut,CLoOut, EnOut, BusMuxOut);
			endgenerate
			
			
			
			//Set the Output Data From the Multiplexer to the correct input signal
			always @ (posedge clk) begin
				if (EnIn == 5'b00000) r0in = BusMuxOut;
				if (EnIn == 5'b00001) r1in = BusMuxOut;
				if (EnIn == 5'b00010) r2in = BusMuxOut;
				if (EnIn == 5'b00011) r3in = BusMuxOut;
				if (EnIn == 5'b00100) r4in = BusMuxOut;
				if (EnIn == 5'b00101) r5in = BusMuxOut;
				if (EnIn == 5'b00110) r6in = BusMuxOut;
				if (EnIn == 5'b00111) r7in = BusMuxOut;
				if (EnIn == 5'b01000) r8in = BusMuxOut;
				if (EnIn == 5'b01001) r9in = BusMuxOut;
				if (EnIn == 5'b01010) r10in = BusMuxOut;
				if (EnIn == 5'b01011) r11in = BusMuxOut;
				if (EnIn == 5'b01100) r12in = BusMuxOut;
				if (EnIn == 5'b01101) r13in = BusMuxOut;
				if (EnIn == 5'b01110) r14in = BusMuxOut;
				if (EnIn == 5'b01111) r15in = BusMuxOut;
				if (EnIn == 5'b10000) RegHiIn = BusMuxOut; 
				if (EnIn == 5'b10001) RegLoIn = BusMuxOut; 
				if (EnIn == 5'b10010) ZHiIn = BusMuxOut; 
				if (EnIn == 5'b10011) ZLoIn = BusMuxOut; 
				if (EnIn == 5'b10100) PCIn = BusMuxOut;
				if (EnIn == 5'b10101) MDRMuxIn = BusMuxOut; 	
				if (EnIn == 5'b10110) RegOutportIn = BusMuxOut;
				if (EnIn == 5'b10111) IRIn = BusMuxOut;
				
				if (EnIn == 5'b10000 && EnOut == 5'b10111) RegHiIn = CHiOut; 
				if (EnIn == 5'b10010 && EnOut == 5'b10111) ZHiIn = CHiOut; 
			end
					
			//Break Up IR Input
			assign OPCode = IROut[31:27];
			assign destSel = IROut[26:23];
			assign regASel = IROut[22:19];
			assign regBSel = IROut[18:15];

			//This always statement will use the IR to operate the ALU		
			always @ (*) begin
				immVal = IR[14:0];
	
				//Put contents of the correct register into regA using regASel
				if (regASel == 4'b0000) regA = r0outf[31:0]; else
				if (regASel == 4'b0001) regA = r1outf[31:0]; else
				if (regASel == 4'b0010) regA = r2outf[31:0]; else
				if (regASel == 4'b0011) regA = r3outf[31:0]; else
				if (regASel == 4'b0100) regA = r4outf[31:0]; else
				if (regASel == 4'b0101) regA = r5outf[31:0]; else
				if (regASel == 4'b0110) regA = r6outf[31:0]; else
				if (regASel == 4'b0111) regA = r7outf[31:0]; else
				if (regASel == 4'b1000) regA = r8outf[31:0]; else
				if (regASel == 4'b1001) regA = r9outf[31:0]; else
				if (regASel == 4'b1010) regA = r10outf[31:0]; else
				if (regASel == 4'b1011) regA = r11outf[31:0]; else
				if (regASel == 4'b1100) regA = r12outf[31:0]; else
				if (regASel == 4'b1101) regA = r13outf[31:0]; else
				if (regASel == 4'b1110) regA = r14outf[31:0]; else
				if (regASel == 4'b1111) regA = r15outf[31:0];
				
				if (OPCode[4] == 1'b1) regA = immVal;
				
				//Put contents of the correct register into regB using regBSel from the IR
				if (regBSel == 4'b0000) regB = r0outf[31:0]; else
				if (regBSel == 4'b0001) regB = r1outf[31:0]; else
				if (regBSel == 4'b0010) regB = r2outf[31:0]; else
				if (regBSel == 4'b0011) regB = r3outf[31:0]; else
				if (regBSel == 4'b0100) regB = r4outf[31:0]; else
				if (regBSel == 4'b0101) regB = r5outf[31:0]; else
				if (regBSel == 4'b0110) regB = r6outf[31:0]; else
				if (regBSel == 4'b0111) regB = r7outf[31:0]; else
				if (regBSel == 4'b1000) regB = r8outf[31:0]; else
				if (regBSel == 4'b1001) regB = r9outf[31:0]; else
				if (regBSel == 4'b1010) regB = r10outf[31:0]; else
				if (regBSel == 4'b1011) regB = r11outf[31:0]; else
				if (regBSel == 4'b1100) regB = r12outf[31:0]; else
				if (regBSel == 4'b1101) regB = r13outf[31:0]; else
				if (regBSel == 4'b1110) regB = r14outf[31:0]; else
				if (regBSel == 4'b1111) regB = r15outf[31:0];
			end
		
			//Put the ALU result into the C register
			always @ (posedge clk) begin
				if (ALUen) begin //If the ALU has been enabled then we can write data 
					CLoIn = ALUOutput[31:0];
					CHiIn = ALUOutput[63:32];
				end
			end
endmodule
