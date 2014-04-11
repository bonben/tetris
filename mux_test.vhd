--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:08:13 03/12/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/mux_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity mux_test is
end mux_test;

architecture behavior of mux_test is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component mux
    port(
      clock       : in  std_logic;
      reset       : in  std_logic;
      sel_mux     : in  std_logic;
      bus_cpt_mux : in  std_logic_vector(5 downto 0);
      bus_reg_mux : in  std_logic_vector(5 downto 0);
      bus_mux_out : out std_logic_vector(5 downto 0)
      );
  end component;


  --Inputs
  signal clock       : std_logic                    := '0';
  signal reset       : std_logic                    := '0';
  signal sel_mux     : std_logic                    := '0';
  signal bus_cpt_mux : std_logic_vector(5 downto 0) := (others => '0');
  signal bus_reg_mux : std_logic_vector(5 downto 0) := (others => '0');

  --Outputs
  signal bus_mux_out : std_logic_vector(5 downto 0);

  -- Clock period definitions
  constant clock_period : time := 10 ns;
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : mux port map (
    clock       => clock,
    reset       => reset,
    sel_mux     => sel_mux,
    bus_cpt_mux => bus_cpt_mux,
    bus_reg_mux => bus_reg_mux,
    bus_mux_out => bus_mux_out
    );

  -- Clock process definitions
  clock_process : process
  begin
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    wait for clock_period/2;
  end process;


  -- Stimulus process
  stim_proc : process
  begin
    reset       <= '1';
	 ce <='1';	
    wait for 100 ns;
    reset       <= '0';
    bus_cpt_mux <= "111000";
    bus_reg_mux <= "000111";
    sel_mux     <= '0';
    wait for clock_period*10;
    sel_mux     <= '1';
    wait for clock_period*10;
    sel_mux     <= '0';


    wait;
  end process;

end;
