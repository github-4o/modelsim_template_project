library ieee;
use ieee.std_logic_1164.all;


entity test_case is
    generic (
        -- for illustration purposes only. forces tests to issue oTest_error = '1'
        gFail: integer range 0 to 1;
        gTest_number: natural
    );
    port (
        oTest_done: out std_logic;
        oTest_error: out std_logic
    );
end entity;

architecture v1 of test_case is

    component uut
        port (
            iClk: in std_logic;
            iReset: in std_logic;

            -- for illustration purposes only. valid port set goes here
            iSignals: in std_logic_vector;
            oSignals: out std_logic_vector
        );
    end component;

    component tester_mux
        generic (
            gTest_number: natural;
            -- for illustration purposes only. forces tests to issue oTest_error = '1'
            gFail: integer range 0 to 1
        );
        port (
            oClk: out std_logic;
            oReset: out std_logic;

            -- for illustration purposes only. valid port set goes here
            iSignals: in std_logic_vector;
            oSignals: out std_logic_vector;

            -- to sim top
            oTest_done: out std_logic;
            oTest_error: out std_logic
        );
    end component;

    signal sClk: std_logic;
    signal sReset: std_logic;
    signal sSignals_in: std_logic_vector (31 downto 0);
    signal sSignals_out: std_logic_vector (31 downto 0);

begin

    uut_inst: uut
        port map (
            iClk => sClk,
            iReset => sReset,

            iSignals => sSignals_in,
            oSignals => sSignals_out
        );

    one_tester: tester_mux
        generic map (
            gTest_number => gTest_number,
            gFail => gFail
        )
        port map (
            oClk => sClk,
            oReset => sReset,

            iSignals => sSignals_out,
            oSignals => sSignals_in,

            oTest_done => oTest_done,
            oTest_error => oTest_error
        );

end v1;
