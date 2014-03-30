--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:31:44 03/29/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/tetris/test_tetris.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tetris
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
 
ENTITY test_tetris IS
END test_tetris;
 
ARCHITECTURE behavior OF test_tetris IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tetris
    PORT(
         RESET : IN  std_logic;
         CLK100M : IN  std_logic;
         HS : OUT  std_logic;
         VS : OUT  std_logic;
         RGB : OUT  std_logic_vector(7 downto 0);
         HAUT : IN  std_logic;
         GAUCHE : IN  std_logic;
         BAS : IN  std_logic;
         DROITE : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '0';
   signal CLK100M : std_logic := '0';
   signal HAUT : std_logic := '0';
   signal GAUCHE : std_logic := '0';
   signal BAS : std_logic := '0';
   signal DROITE : std_logic := '0';

 	--Outputs
   signal HS : std_logic;
   signal VS : std_logic;
   signal RGB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK100M_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tetris PORT MAP (
          RESET => RESET,
          CLK100M => CLK100M,
          HS => HS,
          VS => VS,
          RGB => RGB,
          HAUT => HAUT,
          GAUCHE => GAUCHE,
          BAS => BAS,
          DROITE => DROITE
        );

   -- Clock process definitions
   CLK100M_process :process
   begin
		CLK100M <= '0';
		wait for CLK100M_period/2;
		CLK100M <= '1';
		wait for CLK100M_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for 200 ns;	
		reset <= '0';
		HAUT <= '0';
		BAS <= '0';
		GAUCHE <= '1';
		DROITE <= '0';

      wait;
   end process;

END;
