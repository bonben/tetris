--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:36:58 03/29/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/tetris/test_gestion_chute.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: gestion_chute
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
 
ENTITY test_gestion_chute IS
END test_gestion_chute;
 
ARCHITECTURE behavior OF test_gestion_chute IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT gestion_chute
    PORT(
         CLOCK : IN  std_logic;
         RESET : IN  std_logic;
         DEBUT : IN  std_logic;
         FIN : OUT  std_logic;
         NEXT_POS : OUT  std_logic_vector(12 downto 0);
         CURRENT_POS : IN  std_logic_vector(12 downto 0);
         LOAD : OUT  std_logic;
         ADDRESS : OUT  std_logic_vector(7 downto 0);
         DATA_R : IN  std_logic_vector(7 downto 0);
         R_W : OUT  std_logic;
         EN_MEM : OUT  std_logic;
         CE : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal DEBUT : std_logic := '0';
   signal CURRENT_POS : std_logic_vector(12 downto 0) := (others => '0');
   signal DATA_R : std_logic_vector(7 downto 0) := (others => '0');
   signal CE : std_logic := '0';

 	--Outputs
   signal FIN : std_logic;
   signal NEXT_POS : std_logic_vector(12 downto 0);
   signal LOAD : std_logic;
   signal ADDRESS : std_logic_vector(7 downto 0);
   signal R_W : std_logic;
   signal EN_MEM : std_logic;

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gestion_chute PORT MAP (
          CLOCK => CLOCK,
          RESET => RESET,
          DEBUT => DEBUT,
          FIN => FIN,
          NEXT_POS => NEXT_POS,
          CURRENT_POS => CURRENT_POS,
          LOAD => LOAD,
          ADDRESS => ADDRESS,
          DATA_R => DATA_R,
          R_W => R_W,
          EN_MEM => EN_MEM,
          CE => CE
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
      reset <= '1';
      wait for 100 ns;	
		reset <= '0';
		DEBUT <= '1';
		CURRENT_POS <= "0000000000000";
		CE <= '1';
		DATA_R <= "01101101";
      wait for CLOCK_period*20;
		DATA_R <= "00000000";
		wait for CLOCK_period*20;
		CURRENT_POS <= "1111111100000";
		

      -- insert stimulus here 

      wait;
   end process;

END;
