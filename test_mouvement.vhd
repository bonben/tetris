--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:16:14 03/29/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/tetris/test_mouvement.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mouvement
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

entity test_mouvement is
end test_mouvement;

architecture behavior of test_mouvement is

  -- Component Declaration for the Unit Under Test (UUT)
  
  component mouvement
    port(
      clock     : in  std_logic;
      CE_100Hz  : in  std_logic;
      reset     : in  std_logic;
      fsm_ready : in  std_logic;
      haut      : in  std_logic;
      gauche    : in  std_logic;
      DROITE    : in  std_logic;
      bas       : in  std_logic;
      CHUTE     : out std_logic;
      ROT       : out std_logic;
      DECAL     : out std_logic;
      SENS      : out std_logic;
      ce        : in  std_logic
      );
  end component;


  --Inputs
  signal clock     : std_logic := '0';
  signal CE_100Hz  : std_logic := '0';
  signal reset     : std_logic := '0';
  signal fsm_ready : std_logic := '0';
  signal haut      : std_logic := '0';
  signal gauche    : std_logic := '0';
  signal DROITE    : std_logic := '0';
  signal bas       : std_logic := '0';
  signal ce        : std_logic := '1';

  --Outputs
  signal CHUTE : std_logic;
  signal ROT   : std_logic;
  signal DECAL : std_logic;
  signal SENS  : std_logic;

  -- Clock period definitions
  constant clock_period    : time := 10 ns;
  constant ce_100Hz_period : time := 100 ns;
  
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : mouvement port map (
    clock     => clock,
    CE_100Hz  => CE_100Hz,
    reset     => reset,
    fsm_ready => fsm_ready,
    haut      => haut,
    gauche    => gauche,
    DROITE    => DROITE,
    bas       => bas,
    CHUTE     => CHUTE,
    ROT       => ROT,
    DECAL     => DECAL,
    SENS      => SENS,
    ce        => ce
    );

  -- Clock process definitions
  clock_process : process
  begin
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    wait for clock_period/2;
  end process;
  ce_100Hz_process : process
  begin
    CE_100Hz <= '1';
    wait for clock_period;
    CE_100Hz <= '0';
    wait for ce_100Hz_period-clock_period;
  end process;


  -- Stimulus process
  stim_proc : process
  begin
    reset     <= '1';
    fsm_ready <= '1';
    ce        <= '1';
    wait for 100 ns;
	 reset     <= '0';
    haut      <= '1';
    gauche    <= '0';
    DROITE    <= '0';
    bas       <= '0';

    wait for ce_100Hz_period*10;
    haut      <= '0';
    gauche    <= '0';
    DROITE    <= '1';
    bas       <= '0';
    wait for ce_100Hz_period*10;
    haut      <= '1';
    gauche    <= '1';
    DROITE    <= '0';
    bas       <= '0';
    wait for ce_100Hz_period*100;
    fsm_ready <= '0';
    haut      <= '1';
    gauche    <= '0';
    DROITE    <= '0';
    bas       <= '0';
    -- insert stimulus here 

    wait;
  end process;

end;
