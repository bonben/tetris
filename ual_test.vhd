--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:35:44 03/13/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/ual_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ual
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
 
ENTITY ual_test IS
END ual_test;
 
ARCHITECTURE behavior OF ual_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ual
    PORT(
         bus_reg_8b_ual_in : IN  std_logic_vector(7 downto 0);
         bus_reg_accu_ual_in : IN  std_logic_vector(7 downto 0);
         bus_ual_reg_accu_out : OUT  std_logic_vector(7 downto 0);
         carry_out : OUT  std_logic;
         sel_ual : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal bus_reg_8b_ual_in : std_logic_vector(7 downto 0) := (others => '0');
   signal bus_reg_accu_ual_in : std_logic_vector(7 downto 0) := (others => '0');
   signal sel_ual : std_logic := '0';

 	--Outputs
   signal bus_ual_reg_accu_out : std_logic_vector(7 downto 0);
   signal carry_out : std_logic;
   -- No clocks detected in port list. Replace h below with 
   -- appropriate port name 
 signal h : std_logic;
   constant h_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ual PORT MAP (
          bus_reg_8b_ual_in => bus_reg_8b_ual_in,
          bus_reg_accu_ual_in => bus_reg_accu_ual_in,
          bus_ual_reg_accu_out => bus_ual_reg_accu_out,
          carry_out => carry_out,
          sel_ual => sel_ual
        );

   -- Clock process definitions
   h_process :process
   begin
		h <= '0';
		wait for h_period/2;
		h <= '1';
		wait for h_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			bus_reg_8b_ual_in <= "01111110";
         bus_reg_accu_ual_in <= "00000001";
         
         sel_ual <= '1';
      wait for h_period*10;
			bus_reg_8b_ual_in <= "00000010";
         bus_reg_accu_ual_in <= "00000001";
         
         sel_ual <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
