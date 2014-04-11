--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:14:33 04/11/2014
-- Design Name:   
-- Module Name:   C:/Users/Jeremy/Desktop/tetris/test_Display_driver.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Display_driver
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
 
ENTITY test_Display_driver IS
END test_Display_driver;
 
ARCHITECTURE behavior OF test_Display_driver IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Display_driver
    PORT(
         SCORE : IN  std_logic_vector(5 downto 0);
         BEST_YOU : IN  std_logic;
         SCORE_TEXT : IN  std_logic;
         CLOCK : IN  std_logic;
         RESET : IN  std_logic;
         DEF7_SEG : OUT  std_logic_vector(7 downto 0);
         ALLUM_MIL : OUT  std_logic;
         ALLUM_CENT : OUT  std_logic;
         ALLUM_DIZ : OUT  std_logic;
         ALLUM_UNI : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SCORE : std_logic_vector(5 downto 0) := (others => '0');
   signal BEST_YOU : std_logic := '0';
   signal SCORE_TEXT : std_logic := '0';
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal DEF7_SEG : std_logic_vector(7 downto 0);
   signal ALLUM_MIL : std_logic;
   signal ALLUM_CENT : std_logic;
   signal ALLUM_DIZ : std_logic;
   signal ALLUM_UNI : std_logic;

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Display_driver PORT MAP (
          SCORE => SCORE,
          BEST_YOU => BEST_YOU,
          SCORE_TEXT => SCORE_TEXT,
          CLOCK => CLOCK,
          RESET => RESET,
          DEF7_SEG => DEF7_SEG,
          ALLUM_MIL => ALLUM_MIL,
          ALLUM_CENT => ALLUM_CENT,
          ALLUM_DIZ => ALLUM_DIZ,
          ALLUM_UNI => ALLUM_UNI
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLOCK_period*10;
			RESET <= '1';
			SCORE <= "000000";
         BEST_YOU <= '0';
         SCORE_TEXT <= '0';
			
      wait for CLOCK_period*10;
			RESET <= '0';
			SCORE <= "111111";
         BEST_YOU <= '0';
         SCORE_TEXT <= '1';	

      wait for CLOCK_period*10;
			RESET <= '0';
			SCORE <= "111111";
         BEST_YOU <= '0';
         SCORE_TEXT <= '1';	

      wait for CLOCK_period*10;
			RESET <= '0';
			SCORE <= "000100";
         BEST_YOU <= '1';
         SCORE_TEXT <= '1';	

      wait for CLOCK_period*10;
			RESET <= '0';
			SCORE <= "000100";
         BEST_YOU <= '1';
         SCORE_TEXT <= '0';			
      -- insert stimulus here 

      wait;
   end process;

END;
