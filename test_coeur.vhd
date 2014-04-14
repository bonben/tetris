--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:49:03 04/14/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/tetris/test_coeur.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: coeur
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
 
ENTITY test_coeur IS
END test_coeur;
 
ARCHITECTURE behavior OF test_coeur IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT coeur
    PORT(
         RESET : IN  std_logic;
         CLK25M : IN  std_logic;
         CE_100Hz : IN  std_logic;
         CE : IN  std_logic;
         R_W : OUT  std_logic;
         EN_MEM : OUT  std_logic;
         FIN_JEU : OUT  std_logic;
         FIN_SCORE : IN  std_logic;
         SCORE : OUT  std_logic_vector(5 downto 0);
         ADDRESS : OUT  std_logic_vector(7 downto 0);
         DATA_R : IN  std_logic_vector(7 downto 0);
         DATA_W : OUT  std_logic_vector(7 downto 0);
         GAUCHE : IN  std_logic;
         DROITE : IN  std_logic;
         HAUT : IN  std_logic;
         BAS : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '0';
   signal CLK25M : std_logic := '0';
   signal CE_100Hz : std_logic := '0';
   signal CE : std_logic := '0';
   signal FIN_SCORE : std_logic := '0';
   signal DATA_R : std_logic_vector(7 downto 0) := (others => '0');
   signal GAUCHE : std_logic := '0';
   signal DROITE : std_logic := '0';
   signal HAUT : std_logic := '0';
   signal BAS : std_logic := '0';

 	--Outputs
   signal R_W : std_logic;
   signal EN_MEM : std_logic;
   signal FIN_JEU : std_logic;
   signal SCORE : std_logic_vector(5 downto 0);
   signal ADDRESS : std_logic_vector(7 downto 0);
   signal DATA_W : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK25M_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: coeur PORT MAP (
          RESET => RESET,
          CLK25M => CLK25M,
          CE_100Hz => CE_100Hz,
          CE => CE,
          R_W => R_W,
          EN_MEM => EN_MEM,
          FIN_JEU => FIN_JEU,
          FIN_SCORE => FIN_SCORE,
          SCORE => SCORE,
          ADDRESS => ADDRESS,
          DATA_R => DATA_R,
          DATA_W => DATA_W,
          GAUCHE => GAUCHE,
          DROITE => DROITE,
          HAUT => HAUT,
          BAS => BAS
        );

   -- Clock process definitions
   CLK25M_process :process
   begin
		CLK25M <= '0';
		wait for CLK25M_period/2;
		CLK25M <= '1';
		wait for CLK25M_period/2;
   end process;
 
  CE_100Hz_process :process
   begin
		CE_100Hz <= '0';
		wait for CLK25M_period/2 + CLK25M_period * 10;
		CE_100Hz <= '1';
		wait for CLK25M_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   RESET <= '1';
   CE <= '1';
   FIN_SCORE <= '0';
   DATA_R <= "00000000";
   GAUCHE <= '0';
   DROITE <= '0';
   HAUT <= '0';
   BAS <= '0';
      wait for 100 ns;	
	RESET <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
