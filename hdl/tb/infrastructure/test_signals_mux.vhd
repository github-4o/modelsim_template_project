library ieee;
use ieee.std_logic_1164.all;


entity test_signals_mux is
    port (
        iTest_done: in std_logic_vector;
        iTest_error: in std_logic_vector;

        oTest_done: out std_logic;
        oTest_error: out std_logic
    );
end entity;

architecture v1 of test_signals_mux is

begin

    oTest_done <= '1' when iTest_done = (iTest_done'range => '1') else '0';
    oTest_error <= '1' when iTest_error /= (iTest_error'range => '0') else '0';

end v1;
