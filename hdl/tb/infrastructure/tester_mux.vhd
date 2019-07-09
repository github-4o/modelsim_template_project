library ieee;
use ieee.std_logic_1164.all;


entity tester_mux is
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
end entity;

architecture v1 of tester_mux is

    constant cTest_num: natural := 2;

    component tester0
        generic (
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

    component tester1
        generic (
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

begin

    assert gTest_number >= 0 and gTest_number < cTest_num
        report "invalid test number"
        severity failure;

    test0: if gTest_number = 0 generate

        tester0_inst: tester0
            generic map (
                gFail => gFail
            )
            port map (
                oClk => oClk,
                oReset => oReset,

                iSignals => iSignals,
                oSignals => oSignals,

                oTest_done => oTest_done,
                oTest_error => oTest_error
            );

    end generate;

    test1: if gTest_number = 1 generate

        tester1_inst: tester1
            generic map (
                gFail => gFail
            )
            port map (
                oClk => oClk,
                oReset => oReset,

                iSignals => iSignals,
                oSignals => oSignals,

                oTest_done => oTest_done,
                oTest_error => oTest_error
            );

    end generate;

end v1;
