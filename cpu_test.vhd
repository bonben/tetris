--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:26:06 03/13/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/cpu_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cpu
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
 
ENTITY cpu_test IS
END cpu_test;
 
ARCHITECTURE behavior OF cpu_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpu
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         ce : IN  std_logic;
         bus_out : OUT  std_logic_vector(7 downto 0);
         bus_in : OUT  std_logic_vector(7 downto 0);
         address : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal ce : std_logic := '0';

 	--Outputs
   signal bus_out : std_logic_vector(7 downto 0);
   signal bus_in : std_logic_vector(7 downto 0);
   signal address : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpu PORT MAP (
          clock => clock,
          reset => reset,
          ce => ce,
          bus_out => bus_out,
          bus_in => bus_in,
          address => address
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
      reset <= '1';
		ce <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;


END;
