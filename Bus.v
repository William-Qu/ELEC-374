//Initialize MUX
module Bus(output [31:0]BusMuxOut,input [31:0]BusMuxInR0,BusMuxInR1,BusMuxInR2,BusMuxInR3,BusMuxInR4,BusMuxInR5,BusMuxInR6,BusMuxInR7,BusMuxInR8,BusMuxInR9,BusMuxInR10,BusMuxInR11,BusMuxInR12,BusMuxInR13,BusMuxInR14,BusMuxInR15,BusMuxInHI,BusMuxInLO,BusMuxInZHI,BusMuxInZLO,BusMuxInPC,BusMuxInMDR,BusMuxInINPORT,BusMuxInCSIGNEXTENDED,R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout,PCout, MDRout, InPortOut, Cout);
			
			wire [4:0]EnOut;
			generate
				encoder En (R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout,PCout, MDRout, InPortOut, Cout, EnOut);
				Multiplexer Mux (BusMuxIn-R0,BusMuxIn-R1,BusMuxIn-R2,BusMuxIn-R3,BusMuxIn-R4,BusMuxIn-R5,BusMuxIn-R6,BusMuxIn-R7,BusMuxIn-R8,BusMuxIn-R9,BusMuxIn-R10,BusMuxIn-R11,BusMuxIn-R12,BusMuxIn-R13,BusMuxIn-R14,BusMuxIn-R15,BusMuxIn-HI,BusMuxIn-LO,BusMuxIn-ZHI,BusMuxIn-ZLO,BusMuxIn-PC,BusMuxIn-MDR,BusMuxIn-INPORT,BusMuxIn-C-SIGN-EXTENDED, EnOut, BusMuxOut);
			endgenerate
					
endmodule
