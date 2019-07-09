library ieee;
use ieee.std_logic_1164.all;


entity testbench is
end entity;

architecture v1 of testbench is

    -- for illustration purposes only. forces tests to issue oTest_error = '1'
    constant cFail: integer range 0 to 1 := 0;
    constant cTest_num: natural := 2;

    component test_case
        generic (
            -- for illustration purposes only. forces tests to issue oTest_error = '1'
            gFail: integer range 0 to 1;
            gTest_number: natural
        );
        port (
            oTest_done: out std_logic;
            oTest_error: out std_logic
        );
    end component;

    component test_signals_mux
        port (
            iTest_done: in std_logic_vector;
            iTest_error: in std_logic_vector;

            oTest_done: out std_logic;
            oTest_error: out std_logic
        );
    end component;

    signal sTest_done: std_logic := '0';
    signal sTest_error: std_logic := '0';

    signal sTest_done_ar: std_logic_vector (cTest_num-1 downto 0);
    signal sTest_error_ar: std_logic_vector (cTest_num-1 downto 0);

begin

    tests: for i in 0 to cTest_num-1 generate

        one_test: test_case
            generic map (
                gFail => cFail,
                gTest_number => i
            )
            port map (
                oTest_done => sTest_done_ar (i),
                oTest_error => sTest_error_ar (i)
            );

    end generate;

    signals_mux: test_signals_mux
        port map (
            iTest_done => sTest_done_ar,
            iTest_error => sTest_error_ar,

            oTest_done => sTest_done,
            oTest_error => sTest_error
        );

end v1;
