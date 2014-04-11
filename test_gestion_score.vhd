--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:44:50 04/11/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/tetris/test_gestion_score.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: gestion_score
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
 
ENTITY test_gestion_score IS
END test_gestion_score;
 
ARCHITECTURE behavior OF test_gestion_score IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT gestion_score
    PORT(
         RESET : IN  std_logic;
         CLK25M : IN  std_logic;
         CE100HZ : IN  std_logic;
         SCORE : IN  std_logic_vector(5 downto 0);
         FIN_JEU : IN  std_logic;
         FIN_SCORE : OUT  std_logic;
         CENTER : IN  std_logic;
         AN : OUT  std_logic_vector(3 downto 0);
         SEG : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '0';
   signal CLK25M : std_logic := '0';
   signal CE100HZ : std_logic := '0';
   signal SCORE : std_logic_vector(5 downto 0) := (others => '0');
   signal FIN_JEU : std_logic := '0';
   signal CENTER : std_logic := '0';

 	--Outputs
   signal FIN_SCORE : std_logic;
   signal AN : std_logic_vector(3 downto 0);
   signal SEG : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK25M_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gestion_score PORT MAP (
          RESET => RESET,
          CLK25M => CLK25M,
          CE100HZ => CE100HZ,
          SCORE => SCORE,
          FIN_JEU => FIN_JEU,
          FIN_SCORE => FIN_SCORE,
          CENTER => CENTER,
          AN => AN,
          SEG => SEG
        );

   -- Clock process definitions
   CLK25M_process :process
   begin
		CLK25M <= '0';
		wait for CLK25M_period/2;
		CLK25M <= '1';
		wait for CLK25M_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK25M_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
