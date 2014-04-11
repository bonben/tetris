--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:14:44 03/12/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/control_unit_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: control_unit
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

entity control_unit_test is
end control_unit_test;

architecture behavior of control_unit_test is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component control_unit
    port(
      clock         : in  std_logic;
      reset         : in  std_logic;
      enable_m_out  : out std_logic;
      r_w_out       : out std_logic;
      address_out   : out std_logic_vector(5 downto 0);
      bus_mem_cu_in : in  std_logic_vector(7 downto 0);
      sel_ual_out   : out std_logic;
      load_reg_out  : out std_logic;
      load_accu_out : out std_logic;
      init_ff_out   : out std_logic;
      load_ff_out   : out std_logic;
      carry_in      : in  std_logic;
		ce 			  : in  std_logic
      );
  end component;


  --Inputs
  signal clock         : std_logic                    := '0';
  signal reset         : std_logic                    := '0';
  signal bus_mem_cu_in : std_logic_vector(7 downto 0) := (others => '0');
  signal carry_in      : std_logic                    := '0';
  signal ce            : std_logic							:= '1';

  --Outputs
  signal enable_m_out  : std_logic;
  signal r_w_out       : std_logic;
  signal address_out   : std_logic_vector(5 downto 0);
  signal sel_ual_out   : std_logic;
  signal load_reg_out  : std_logic;
  signal load_accu_out : std_logic;
  signal init_ff_out   : std_logic;
  signal load_ff_out   : std_logic;

  -- Clock period definitions
  constant clock_period : time := 10 ns;
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : control_unit port map (
    clock         => clock,
    reset         => reset,
    enable_m_out  => enable_m_out,
    r_w_out       => r_w_out,
    address_out   => address_out,
    bus_mem_cu_in => bus_mem_cu_in,
    sel_ual_out   => sel_ual_out,
    load_reg_out  => load_reg_out,
    load_accu_out => load_accu_out,
    init_ff_out   => init_ff_out,
    load_ff_out   => load_ff_out,
    carry_in      => carry_in,
	 ce            => ce
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
	 ce <='1';	
    reset    <= '1';
    wait for 100 ns;
    reset    <= '0';
    carry_in <= '0';
    bus_mem_cu_in <= "00101010";
    wait for clock_period*10;
    bus_mem_cu_in <= "01101010";
    wait for clock_period*10;
    bus_mem_cu_in <= "10101010";
    wait for clock_period*10;
    bus_mem_cu_in <= "00101010";
    wait for clock_period*10;
    bus_mem_cu_in <= "11101010";
    wait for clock_period*10;
    carry_in <= '0';
    bus_mem_cu_in <= "11101010";
    wait;
  end process;

end;
