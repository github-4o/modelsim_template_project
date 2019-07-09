library ieee;
use ieee.std_logic_1164.all;


entity tester1 is
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

architecture v1 of tester1 is

begin

    process

        procedure set (val: std_logic) is
        begin
            oClk <= '0';
            oSignals <= (oSignals'range => val);
            wait for 5 ns;
            oClk <= '1';
            wait for 5 ns;
        end procedure;

        procedure test (val: std_logic) is
        begin
            if iSignals /= (iSignals'range => val) then
                oTest_error <= '1';
            end if;
        end procedure;

    begin
        oTest_done <= '0';
        oTest_error <= '0';

        oClk <= '0';
        oSignals <= (oSignals'range => '0');
        oReset <= gReset_active_lvl;
        wait for 501 ns;

        oReset <= not gReset_active_lvl;

        set ('1');
        test ('1');

        set ('0');
        test ('0');

        if gFail = 1 then
            oTest_error <= '1';
        else
            oTest_done <= '1';
        end if;

        wait;
    end process;

end v1;
