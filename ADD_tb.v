// and datapath_tb.v file: ADD_tb.v
`timescale 1ns/10ps
module ADD_tb;
	reg PCout, Zlowout, MDRout, R4out, R5out; // add any other signals to see in your simulation
	reg MARin, Zin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read, ADD, R0in, R2in, R3in;
	reg Clock;
	reg [31:0] Mdatain;
	
	reg clr, wren, ALUen;
	reg R0out, R1out, R2out, R3out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout, InportOut, Cout;
	reg r1ins, r4ins, r5ins, r6ins, r7ins, r8ins, r9ins, r10ins, r11ins, r12ins, r13ins, r14ins, r15ins, HIins, LOins, ZHIins, ZLOins,PCins, MDRins, Outports, IRins;
	wire [31:0] OutportOut;
	


	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
					Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
					T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
	reg [3:0] Present_state = Default;
	
Bus DUT (clr, Clock, wren, Read, ALUen,
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, ZHIout, ZLOout,PCout, MDRout, InportOut, Cout,
R0in, r1ins, R2in, R3in, r4ins, r5ins, r6ins, r7ins, r8ins, r9ins, r10ins, r11ins, r12ins, r13ins, r14ins, r15ins, HIins, LOins, ZHIins, ZLOins,PCins,MDRins, Outports, IRins,
Mdatain,
OutportOut);



// add test logic here
initial
	begin
		Clock = 0;
		forever #10 Clock = ~ Clock;
end

always @(posedge Clock) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default 			:		#40 Present_state = Reg_load1a;
			Reg_load1a 		: 	   #40 Present_state = Reg_load1b;
			Reg_load1b 		: 		#40 Present_state = Reg_load2a;
			Reg_load2a 		: 		#40 Present_state = Reg_load2b;
			Reg_load2b 		: 		#40 Present_state = Reg_load3a;
			Reg_load3a 		: 		#40 Present_state = Reg_load3b;
			Reg_load3b 		: 		#40 Present_state = T0;
			T0 				: 		#40 Present_state = T1;
			T1 				: 		#40 Present_state = T2;
			T2 				: 		#40 Present_state = T3;
			T3 				: 		#40 Present_state = T4;
			T4					:		#40 Present_state = T5;
	endcase
 end

always @(Present_state) // do the required job in each state
	begin
		case (Present_state) // assert the required signals in each clock cycle
			Default: begin
								PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
								R4out <= 0; R5out <= 0; MARin <= 0; Zin <= 0;
								PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
								IncPC <= 0; Read <= 0; ADD <= 0; clr <= 0; wren <= 1;
								R0in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'h00000000;
			end
			Reg_load1a: begin
								Mdatain <= 32'h00000012;
								Read = 0; MDRin = 0; // the first zero is there for completeness
								#10 Read <= 1; MDRin <= 1;
								#15 Read <= 0; MDRin <= 0;
			end
			Reg_load1b: begin
								#10 MDRout <= 1; R2in <= 1;
								#15 MDRout <= 0; R2in <= 0; // initialize R2 with the value $12
			end
			Reg_load2a: begin
								Mdatain <= 32'h00000014;
								#10 Read <= 1; MDRin <= 1;
								#15 Read <= 0; MDRin <= 0;
			end
			Reg_load2b: begin
								#10 MDRout <= 1; R3in <= 1;
								#15 MDRout <= 0; R3in <= 0; // initialize R3 with the value $14
			end
			Reg_load3a: begin
								Mdatain <= 32'h00000018;
								#10 Read <= 1; MDRin <= 1;
								#15 Read <= 0; MDRin <= 0;
			end
			Reg_load3b: begin
								#10 MDRout <= 1; R0in <= 1;
								#15 MDRout <= 0; R0in <= 0; // initialize R0 with the value $18
			end
			T0: begin // see if you need to de-assert these signals
								#10 PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
								#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
			end
			T1: begin
								 Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
								 Mdatain <= 32'b01010000000100011000000000000000; // opcode for “add R0, R2, R3”
								 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
			end
			T2: begin
								 #10 MDRout <= 1; IRins <= 1;
								 #15 MDRout <= 0; IRins <= 0;
			end
			T3: begin
								 #10 Cout <= 1; ZLOins <= 1;
								 #15 Cout <= 0; ZLOins <= 0;
			end
			T4: begin 
								R3out<= 1; Zin<=1;
			
			end
			T5: begin
								 #10 ZLOout <= 1; R0in <= 1;
								 #15 ZLOout <= 0; R0in <= 0;
			end
		endcase
	end
endmodule 