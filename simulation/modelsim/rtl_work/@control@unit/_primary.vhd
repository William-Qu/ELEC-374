library verilog;
use verilog.vl_types.all;
entity ControlUnit is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        wren            : in     vl_logic;
        IR              : in     vl_logic_vector(31 downto 0);
        r0outf          : out    vl_logic_vector(31 downto 0);
        r1outf          : out    vl_logic_vector(31 downto 0);
        r2outf          : out    vl_logic_vector(31 downto 0);
        r3outf          : out    vl_logic_vector(31 downto 0);
        r4outf          : out    vl_logic_vector(31 downto 0);
        r5outf          : out    vl_logic_vector(31 downto 0);
        r6outf          : out    vl_logic_vector(31 downto 0);
        r7outf          : out    vl_logic_vector(31 downto 0);
        r8outf          : out    vl_logic_vector(31 downto 0);
        r9outf          : out    vl_logic_vector(31 downto 0);
        r10outf         : out    vl_logic_vector(31 downto 0);
        r11outf         : out    vl_logic_vector(31 downto 0);
        r12outf         : out    vl_logic_vector(31 downto 0);
        r13outf         : out    vl_logic_vector(31 downto 0);
        r14outf         : out    vl_logic_vector(31 downto 0);
        r15outf         : out    vl_logic_vector(31 downto 0)
    );
end ControlUnit;
