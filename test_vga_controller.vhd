--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:35:31 03/20/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Projets/VHDL/tetris/test_vga_controller.vhd
-- Project Name:  tetris
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: vga_controller
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
 
ENTITY test_vga_controller IS
END test_vga_controller;
 
ARCHITECTURE behavior OF test_vga_controller IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_controller
    PORT(
         clk25M : IN  std_logic;
         reset : IN  std_logic;
         HS : OUT  std_logic;
         VS : OUT  std_logic;
         MEM : IN  std_logic_vector(7 downto 0);
         ADDRESS : INOUT  std_logic_vector(7 downto 0);
         RGB : OUT  std_logic_vector(7 downto 0);
         LOCK_MEM : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk25M : std_logic := '0';
   signal reset : std_logic := '1';
   signal MEM : std_logic_vector(7 downto 0) := (others => '1');

	--BiDirs
   signal ADDRESS : std_logic_vector(7 downto 0);

 	--Outputs
   signal HS : std_logic;
   signal VS : std_logic;
   signal RGB : std_logic_vector(7 downto 0);
   signal LOCK_MEM : std_logic;

   -- Clock period definitions
   constant clk25M_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vga_controller PORT MAP (
          clk25M => clk25M,
          reset => reset,
          HS => HS,
          VS => VS,
          MEM => MEM,
          ADDRESS => ADDRESS,
          RGB => RGB,
          LOCK_MEM => LOCK_MEM
        );

   -- Clock process definitions
   clk25M_process :process
   begin
		clk25M <= '0';
		wait for clk25M_period/2;
		clk25M <= '1';
		wait for clk25M_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk25M_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
