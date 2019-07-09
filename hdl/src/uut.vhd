library ieee;
use ieee.std_logic_1164.all;


entity uut is
    generic (
        gReset_active_lvl: std_logic := '0'
    );
    port (
        iClk: in std_logic;
        iReset: in std_logic;

        -- for illustration purposes only. valid port set goes here
        iSignals: in std_logic_vector;
        oSignals: out std_logic_vector
    );
end entity;

architecture v1 of uut is

begin

    process (iClk, iReset)
    begin
        if iReset = gReset_active_lvl then
            oSignals <= (oSignals'range => '0');
        else
            if iClk'event and iClk = '1' then
                oSignals <= iSignals;
            end if;
        end if;
    end process;

end v1;
