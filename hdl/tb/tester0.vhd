library ieee;
use ieee.std_logic_1164.all;


entity tester0 is
    generic (
        gReset_active_lvl: std_logic := '0';
        -- for illustration purposes only. forces tests to issue oTest_error = '1'
        gFail: integer range 0 to 1
    );
    port (
        oClk: out std_logic;

        -- to uut
        oReset: out std_logic;

        -- for illustration purposes only. valid port set goes here
        iSignals: in std_logic_vector;
        oSignals: out std_logic_vector;

        -- to sim top
        oTest_done: out std_logic;
        oTest_error: out std_logic
    );
end entity;

architecture v1 of tester0 is

begin

    process
    begin
        oTest_done <= '0';
        oTest_error <= '0';

        oClk <= '0';
        oReset <= gReset_active_lvl;

        oSignals <= (oSignals'range => '0');
        wait for 501 ns;

        if iSignals /= (iSignals'range => '0') then
            oTest_error <= '1';
        else
            if gFail = 1 then
                oTest_error <= '1';
            else
                oTest_done <= '1';
            end if;
        end if;

        wait;
    end process;

end v1;
