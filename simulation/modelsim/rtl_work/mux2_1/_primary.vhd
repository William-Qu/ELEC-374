library verilog;
use verilog.vl_types.all;
entity mux2_1 is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        s               : in     vl_logic;
        y               : out    vl_logic
    );
end mux2_1;
