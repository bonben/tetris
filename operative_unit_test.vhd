--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:29:27 03/12/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/operative_unit_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: operative_unit
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY operative_unit_test IS
END operative_unit_test;
 
ARCHITECTURE behavior OF operative_unit_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT operative_unit
    PORT(
         sel_ual_in : IN  std_logic;
         load_accu_in : IN  std_logic;
         load_reg_in : IN  std_logic;
         load_ff_in : IN  std_logic;
         init_ff_in : IN  std_logic;
         carry_out : OUT  std_logic;
         memory_in : IN  std_logic_vector(7 downto 0);
         memory_out : OUT  std_logic_vector(7 downto 0);
         ce : IN  std_logic;
         reset : IN  std_logic;
         clock : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sel_ual_in : std_logic := '0';
   signal load_accu_in : std_logic := '0';
   signal load_reg_in : std_logic := '0';
   signal load_ff_in : std_logic := '0';
   signal init_ff_in : std_logic := '0';
   signal memory_in : std_logic_vector(7 downto 0) := (others => '0');
   signal ce : std_logic := '0';
   signal reset : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal carry_out : std_logic;
   signal memory_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: operative_unit PORT MAP (
          sel_ual_in => sel_ual_in,
          load_accu_in => load_accu_in,
          load_reg_in => load_reg_in,
          load_ff_in => load_ff_in,
          init_ff_in => init_ff_in,
          carry_out => carry_out,
          memory_in => memory_in,
          memory_out => memory_out,
          ce => ce,
          reset => reset,
          clock => clock
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
