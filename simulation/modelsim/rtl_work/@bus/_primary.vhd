library verilog;
use verilog.vl_types.all;
entity \Bus\ is
    port(
        clr             : in     vl_logic;
        clk             : in     vl_logic;
        MDRRead         : in     vl_logic;
        ALUen           : in     vl_logic;
        R0out           : in     vl_logic;
        R1out           : in     vl_logic;
        R2out           : in     vl_logic;
        R3out           : in     vl_logic;
        R4out           : in     vl_logic;
        R5out           : in     vl_logic;
        R6out           : in     vl_logic;
        R7out           : in     vl_logic;
        R8out           : in     vl_logic;
        R9out           : in     vl_logic;
        R10out          : in     vl_logic;
        R11out          : in     vl_logic;
        R12out          : in     vl_logic;
        R13out          : in     vl_logic;
        R14out          : in     vl_logic;
        R15out          : in     vl_logic;
        HIout           : in     vl_logic;
        LOout           : in     vl_logic;
        ZHIout          : in     vl_logic;
        ZLOout          : in     vl_logic;
        PCout           : in     vl_logic;
        MDRout          : in     vl_logic;
        InportOut       : in     vl_logic;
        Cout            : in     vl_logic;
        r0ins           : in     vl_logic;
        r1ins           : in     vl_logic;
        r2ins           : in     vl_logic;
        r3ins           : in     vl_logic;
        r4ins           : in     vl_logic;
        r5ins           : in     vl_logic;
        r6ins           : in     vl_logic;
        r7ins           : in     vl_logic;
        r8ins           : in     vl_logic;
        r9ins           : in     vl_logic;
        r10ins          : in     vl_logic;
        r11ins          : in     vl_logic;
        r12ins          : in     vl_logic;
        r13ins          : in     vl_logic;
        r14ins          : in     vl_logic;
        r15ins          : in     vl_logic;
        HIins           : in     vl_logic;
        LOins           : in     vl_logic;
        ZHIins          : in     vl_logic;
        ZLOins          : in     vl_logic;
        PCins           : in     vl_logic;
        MDRins          : in     vl_logic;
        Inports         : in     vl_logic;
        Outports        : in     vl_logic;
        IRins           : in     vl_logic;
        MDRMDataIn      : in     vl_logic_vector(31 downto 0);
        OutportOut      : out    vl_logic_vector(31 downto 0)
    );
end \Bus\;
