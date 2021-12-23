library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench is
end entity;
 
architecture sim of TestBench is

    constant ClockFrequencyHz : integer := 100;
    constant ClockPeriod : time := 1000 ms / ClockFrequencyHz;
 
    signal Clk         : std_logic := '1';
    signal nRst        : std_logic := '0';
    signal NorthRed    : std_logic;
    signal NorthYellow : std_logic;
    signal NorthGreen  : std_logic;
    signal WestRed     : std_logic;
    signal WestYellow  : std_logic;
    signal WestGreen   : std_logic;
 
begin
 
    -- The Device Under Test
	-- creating module in the testbench
    i_TrafficLights : entity work.TrafficLights(rtl)
    generic map(ClockFrequencyHz => ClockFrequencyHz)--first one comes from
	--module and second one is constant comes from testbench(above we have declaration for it)
	
    --on the bottom we map second ones from here to the first ones that are timer 
	--modules entitiy port outputs with a same name
	port map (
        Clk         => Clk,
        nRst        => nRst,
        NorthRed    => NorthRed,
        NorthYellow => NorthYellow,
        NorthGreen  => NorthGreen,
        WestRed     => WestRed,
        WestYellow  => WestYellow,
        WestGreen   => WestGreen);
 
    -- Process for generating clock
    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench sequence
    process is
    begin
        wait until rising_edge(Clk);
        wait until rising_edge(Clk);
 
        -- Take the DUT out of reset
        nRst <= '1';
 
        wait;
    end process;
 
end architecture;