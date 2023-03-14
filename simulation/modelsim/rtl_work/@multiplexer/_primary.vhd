library verilog;
use verilog.vl_types.all;
entity Multiplexer is
    port(
        r0out           : in     vl_logic;
        r1out           : in     vl_logic;
        r2out           : in     vl_logic;
        r3out           : in     vl_logic;
        r4out           : in     vl_logic;
        r5out           : in     vl_logic;
        r6out           : in     vl_logic;
        r7out           : in     vl_logic;
        r8out           : in     vl_logic;
        r9out           : in     vl_logic;
        r10out          : in     vl_logic;
        r11out          : in     vl_logic;
        r12out          : in     vl_logic;
        r13out          : in     vl_logic;
        r14out          : in     vl_logic;
        r15out          : in     vl_logic;
        RegHiOut        : in     vl_logic;
        RegLoOut        : in     vl_logic;
        ZHiOut          : in     vl_logic;
        ZLoOut          : in     vl_logic;
        PCOut           : in     vl_logic;
        MDROut          : in     vl_logic;
        RegInportOut    : in     vl_logic;
        CLoOut          : in     vl_logic;
        EnOut           : in     vl_logic_vector(4 downto 0);
        BusMuxOut       : out    vl_logic_vector(31 downto 0)
    );
end Multiplexer;
