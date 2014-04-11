--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:57:29 03/13/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/reg_8b_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg_8b
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
 
ENTITY reg_8b_test IS
END reg_8b_test;
 
ARCHITECTURE behavior OF reg_8b_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg_8b
    PORT(
         load_in : IN  std_logic;
         bus_8b_out : OUT  std_logic_vector(7 downto 0);
         bus_8b_in : IN  std_logic_vector(7 downto 0);
         clock : IN  std_logic;
         reset : IN  std_logic;
         ce : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal load_in : std_logic := '0';
   signal bus_8b_in : std_logic_vector(7 downto 0) := (others => '0');
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal ce : std_logic := '0';

 	--Outputs
   signal bus_8b_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg_8b PORT MAP (
          load_in => load_in,
          bus_8b_out => bus_8b_out,
          bus_8b_in => bus_8b_in,
          clock => clock,
          reset => reset,
          ce => ce
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
  stim_proc : process
  begin
    reset     <= '1';
	 ce <='1';	
    wait for 100 ns;
    load_in   <= '0';
    reset     <= '0';
    bus_8b_in <= "10101010";

    wait for clock_period*10;
    load_in <= '1';
    wait for clock_period*10;
    load_in <= '0';
    bus_8b_in <= "11110000";
    wait for clock_period*10;
    load_in <= '1';
    -- insert stimulus here 

    wait;
  end process;

END;
