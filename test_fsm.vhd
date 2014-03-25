--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:10:08 03/25/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/tetris/test_fsm.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm
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
 
ENTITY test_fsm IS
END test_fsm;
 
ARCHITECTURE behavior OF test_fsm IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         chute : IN  std_logic;
         rot : IN  std_logic;
         decal : IN  std_logic;
         fsm_ready : OUT  std_logic;
         fin_score : IN  std_logic;
         deb_decal : OUT  std_logic;
         fin_decal : IN  std_logic;
         deb_chute : OUT  std_logic;
         fin_chute : IN  std_logic;
         deb_nl : OUT  std_logic;
         fin_nl : IN  std_logic;
         deb_rot : OUT  std_logic;
         fin_rot : IN  std_logic;
         deb_refresh : OUT  std_logic;
         fin_refresh : IN  std_logic;
         mux_add : OUT  std_logic_vector(2 downto 0);
         ce : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal chute : std_logic := '0';
   signal rot : std_logic := '0';
   signal decal : std_logic := '0';
   signal fin_score : std_logic := '0';
   signal fin_decal : std_logic := '0';
   signal fin_chute : std_logic := '0';
   signal fin_nl : std_logic := '0';
   signal fin_rot : std_logic := '0';
   signal fin_refresh : std_logic := '0';
   signal ce : std_logic := '0';

 	--Outputs
   signal fsm_ready : std_logic;
   signal deb_decal : std_logic;
   signal deb_chute : std_logic;
   signal deb_nl : std_logic;
   signal deb_rot : std_logic;
   signal deb_refresh : std_logic;
   signal mux_add : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm PORT MAP (
          clock => clock,
          reset => reset,
          chute => chute,
          rot => rot,
          decal => decal,
          fsm_ready => fsm_ready,
          fin_score => fin_score,
          deb_decal => deb_decal,
          fin_decal => fin_decal,
          deb_chute => deb_chute,
          fin_chute => fin_chute,
          deb_nl => deb_nl,
          fin_nl => fin_nl,
          deb_rot => deb_rot,
          fin_rot => fin_rot,
          deb_refresh => deb_refresh,
          fin_refresh => fin_refresh,
          mux_add => mux_add,
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
   stim_proc: process
   begin		
      reset <= '1';
		rot <= '0';
		decal <= '0';
		chute <= '0';
		ce <= '1';
      wait for 100 ns;	
		reset <= '0';
		fin_chute <= '1';
		fin_nl <= '1';
		fin_rot <= '1';
		fin_decal <= '1';
		fin_refresh <= '1';
		
      wait for clock_period*10;
		decal <= '1';
		wait for clock_period;
		decal <= '0';
		
		wait for clock_period*10;
		chute <= '1';
		wait for clock_period;
		chute <= '0';
		
		wait for clock_period*10;
		rot <= '1';
		wait for clock_period;
		rot <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
