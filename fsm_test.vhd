--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:35:23 03/10/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/fsm_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm
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

entity fsm_test is
end fsm_test;

architecture behavior of fsm_test is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component fsm
    port(
      clock         : in  std_logic;
      reset         : in  std_logic;
      op_in         : in  std_logic_vector(1 downto 0);
      carry_in      : in  std_logic;
      sel_ual_out   : out std_logic;
      load_reg_out  : out std_logic;
      load_accu_out : out std_logic;
      init_ff_out   : out std_logic;
      load_ff_out   : out std_logic;
      r_w_out       : out std_logic;
      enable_m_out  : out std_logic;
      load_cpt_out  : out std_logic;
      incr_cpt_out  : out std_logic;
      init_cpt_out  : out std_logic;
      sel_mux_out   : out std_logic;
      load_inst_out : out std_logic
      );
  end component;


  --Inputs
  signal clock    : std_logic                    := '0';
  signal reset    : std_logic                    := '0';
  signal op_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal carry_in : std_logic                    := '0';

  --Outputs
  signal sel_ual_out   : std_logic;
  signal load_reg_out  : std_logic;
  signal load_accu_out : std_logic;
  signal init_ff_out   : std_logic;
  signal load_ff_out   : std_logic;
  signal r_w_out       : std_logic;
  signal enable_m_out  : std_logic;
  signal load_cpt_out  : std_logic;
  signal incr_cpt_out  : std_logic;
  signal init_cpt_out  : std_logic;
  signal sel_mux_out   : std_logic;
  signal load_inst_out : std_logic;

  -- Clock period definitions
  constant clock_period : time := 10 ns;
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : fsm port map (
    clock         => clock,
    reset         => reset,
    op_in         => op_in,
    carry_in      => carry_in,
    sel_ual_out   => sel_ual_out,
    load_reg_out  => load_reg_out,
    load_accu_out => load_accu_out,
    init_ff_out   => init_ff_out,
    load_ff_out   => load_ff_out,
    r_w_out       => r_w_out,
    enable_m_out  => enable_m_out,
    load_cpt_out  => load_cpt_out,
    incr_cpt_out  => incr_cpt_out,
    init_cpt_out  => init_cpt_out,
    sel_mux_out   => sel_mux_out,
    load_inst_out => load_inst_out
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
    -- hold reset state for 100 ns.
	 ce <='1';	
    reset    <= '1';
    op_in    <= "00";
    carry_in <= '0';
    wait for 100 ns;
    reset    <= '0';
    wait for clock_period*5;
    op_in    <= "01";
    wait for clock_period*4;
    op_in    <= "10";
    wait for clock_period*3;
    op_in    <= "11";
    wait for clock_period*3;
    carry_in <= '1';
    op_in    <= "11";
    wait;
  end process;

end;
