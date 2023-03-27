module Memory(
input clr, clk, write,
input [31:0] dataIn,
input [8:0] Addr,
output [31:0] dataOut
);
			reg [31:0] RAMregisters[511:0];

			initial begin
					$readmemh("bin_memory_file.txt", RAMregisters);
			end
			
			always@(*)
			begin
				if (write) RAMregisters[Addr] = dataIn;
			end
			assign dataOut = RAMregisters[Addr];
endmodule
