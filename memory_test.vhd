--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:09:21 03/12/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/memory_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory
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

entity memory_test is
end memory_test;

architecture behavior of memory_test is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component memory
    port(
      enable_m_in : in  std_logic;
      r_w_in      : in  std_logic;
      address_in  : in  std_logic_vector(5 downto 0);
      memory_out  : out std_logic_vector(7 downto 0);
      memory_in   : in  std_logic_vector(7 downto 0);
      clock       : in  std_logic;
      reset       : in  std_logic;
      ce          : in  std_logic
      );
  end component;


  --Inputs
  signal enable_m_in : std_logic                    := '0';
  signal r_w_in      : std_logic                    := '0';
  signal address_in  : std_logic_vector(5 downto 0) := (others => '0');
  signal memory_in   : std_logic_vector(7 downto 0) := (others => '0');
  signal clock       : std_logic                    := '0';
  signal reset       : std_logic                    := '0';
  signal ce          : std_logic                    := '0';

  --Outputs
  signal memory_out : std_logic_vector(7 downto 0);

  -- Clock period definitions
  constant clock_period : time := 10 ns;
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : memory port map (
    enable_m_in => enable_m_in,
    r_w_in      => r_w_in,
    address_in  => address_in,
    memory_out  => memory_out,
    memory_in   => memory_in,
    clock       => clock,
    reset       => reset,
    ce          => ce
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
    ce          <= '1';
	 reset <='1';
    -- hold reset state for 100 ns.
    wait for 100 ns;
	 reset <='0';
    enable_m_in <= '0';
    r_w_in      <= '0';
    address_in  <= "000010";
    memory_in   <= "11110000";
    wait for clock_period*10;
    enable_m_in <= '1';
    wait for clock_period*10;
    r_w_in      <= '1';
    address_in  <= "000001";
    memory_in   <= "01010101";
    wait for clock_period*10;
    r_w_in      <= '0';
    address_in  <= "000001";
    memory_in   <= "01010101";
    wait for clock_period*10;

    -- insert stimulus here 

    wait;
  end process;

end;
