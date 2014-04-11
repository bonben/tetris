--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:22:27 04/07/2014
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
         clock : IN  std_logic;
         reset : IN  std_logic;
         ce100Hz : IN  std_logic;
         mux_mem : OUT  std_logic;
         center : IN  std_logic;
         deb_score : IN  std_logic;
         fin_score : OUT  std_logic;
         score : IN  std_logic_vector(5 downto 0);
         data_w : OUT  std_logic_vector(7 downto 0);
         data_r : IN  std_logic_vector(7 downto 0);
         en_mem : OUT  std_logic;
         r_w : OUT  std_logic;
         address : OUT  std_logic_vector(5 downto 0);
         score_disp : OUT  std_logic_vector(5 downto 0);
         best_you : OUT  std_logic;
         score_text : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal ce100Hz : std_logic := '0';
   signal center : std_logic := '0';
   signal deb_score : std_logic := '0';
   signal score : std_logic_vector(5 downto 0) := (others => '0');
   signal data_r : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal mux_mem : std_logic;
   signal fin_score : std_logic;
   signal data_w : std_logic_vector(7 downto 0);
   signal en_mem : std_logic;
   signal r_w : std_logic;
   signal address : std_logic_vector(5 downto 0);
   signal score_disp : std_logic_vector(5 downto 0);
   signal best_you : std_logic;
   signal score_text : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gestion_score PORT MAP (
          clock => clock,
          reset => reset,
          ce100Hz => ce100Hz,
          mux_mem => mux_mem,
          center => center,
          deb_score => deb_score,
          fin_score => fin_score,
          score => score,
          data_w => data_w,
          data_r => data_r,
          en_mem => en_mem,
          r_w => r_w,
          address => address,
          score_disp => score_disp,
          best_you => best_you,
          score_text => score_text
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
      wait for 100 ns;	
		reset <= '0';
		deb_score <= '1';
		ce100Hz <= '1';
		score <= "000111";
		data_r <= "00111000";
      wait for clock_period*10;

      wait;
   end process;

END;
