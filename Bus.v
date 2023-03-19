//Initialize MUX
module Bus(
input clr, clk, MDRRead, ALUen, incPC, //Bits for enabling and disabling register functions
input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout,PCout, MDRout, InportOut, Cout, //Output Select Signals for which register were taking data from
input r0ins, r1ins, r2ins, r3ins, r4ins, r5ins, r6ins, r7ins, r8ins, r9ins, r10ins, r11ins, r12ins, r13ins, r14ins, r15ins, HIins, LOins, ZHIins, ZLOins,PCins, MDRins, Inports, Outports, IRins, //Input Select Signals for which register were putting data into
input [31:0] MDRMDataIn, //MDR Data In register
output [31:0] OutportOut //Outport Output Signal to output signals to a display
);
			
			//These are the output wires of the hardware modules
			wire [31:0] r0outf, r1outf, r2outf, r3outf, r4outf, r5outf, r6outf, r7outf, r8outf, r9outf, r10outf, r11outf, r12outf, r13outf, r14outf, r15outf;
			wire [31:0] MDROut, PCOut, RegHiOut, RegLoOut, IROut, ZLoOut, ZHiOut, BusMuxOut, RegInportOut, RegOutportOut, CLoOut, CHiOut;
			wire [63:0] ALUOutput;
			wire [4:0] EnOut;
			
			//Output Registers of the ALU
			reg [31:0] CLoIn, CHiIn;
			
			//PC Incrementation Registers
			reg [31:0] IncrementedPC, PCIN;
			reg incPCTemp, PCinsTemp;
			
			//IR Breakdown Registers
			wire [4:0] OPCode;
			wire [3:0] regASel, regBSel;
			//wire [3:0] destSel;
			reg [31:0] regA, regB, immVal;
			
			//Generate Outside Hardware (Generally only in the ALU so far)
			generate
				reg32bit PC  (PCOut, PCIN, clr, clk, PCinsTemp);
				reg32bit RegHi  (RegHiOut, BusMuxOut, clr, clk, HIins);
				reg32bit RegLo  (RegLoOut, BusMuxOut, clr, clk, LOins);
				reg32bit IR  (IROut, BusMuxOut, clr, clk, IRins);
				reg32bit ZLO (ZLoOut, BusMuxOut, clr, clk, ZLOins);
				reg32bit ZHI (ZHiOut, BusMuxOut, clr, clk, ZHIins);
				MDRunit mdr (MDRRead, clr, clk, MDRins, BusMuxOut, MDRMDataIn, MDROut);
				
				reg32bit InPort (RegInportOut, BusMuxOut, clr, clk, Inports);
				reg32bit OutPort (RegOutportOut, BusMuxOut, clr, clk, Outports);
				
				reg32bit CLO (CLoOut, CLoIn, clr, clk, ALUen);
				reg32bit CHI (CHiOut, CHiIn, clr, clk, ALUen);
				
				ALU Logic (regA, regB, OPCode, ALUOutput);
				ALURegisters LogicReg (clr, clk, r0outf, r1outf, r2outf, r3outf, r4outf, r5outf, r6outf, r7outf, r8outf, r9outf, r10outf, r11outf, r12outf, r13outf, r14outf, r15outf, r0ins, r1ins, r2ins, r3ins, r4ins, r5ins, r6ins, r7ins, r8ins, r9ins, r10ins, r11ins, r12ins, r13ins, r14ins, r15ins, BusMuxOut);
			endgenerate 
			
			//Generate the Bus Control System (Encoder and Multiplexer)
			generate
				encoder EnO (R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout,PCout, MDRout, InportOut, Cout, EnOut);
				Multiplexer Mux (r0outf, r1outf, r2outf, r3outf, r4outf, r5outf, r6outf, r7outf, r8outf, r9outf, r10outf, r11outf, r12outf, r13outf, r14outf, r15outf,RegHiOut,RegLoOut,ZHiOut,ZLoOut,PCOut,MDROut,RegInportOut,CLoOut, EnOut, BusMuxOut);
			endgenerate
			
			//Break Up IR Input
			assign OPCode = IROut[31:27];
			//assign destSel = IROut[26:23];
			assign regASel = IROut[22:19];
			assign regBSel = IROut[18:15];

			//This always statement will use the IR to operate the ALU		
			always @ (*) begin
				immVal = IROut[14:0];
	
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
			always @ (*) begin
				CLoIn = ALUOutput[31:0];
				CHiIn = ALUOutput[63:32];
			end
			
			//Increment PC
			always @ (posedge clk) begin
				IncrementedPC = PCOut + incPC;
				PCIN = incPC ? IncrementedPC : BusMuxOut;
				PCinsTemp = incPC ? incPC : PCins;
			end
			
endmodule
