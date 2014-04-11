--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:35:07 03/14/2014
-- Design Name:   
-- Module Name:   /home/leonardon/Ecole/Conception_processeur_elementaire/processeur/cpt_test.vhd
-- Project Name:  processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cpt
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
 
ENTITY cpt_test IS
END cpt_test;
 
ARCHITECTURE behavior OF cpt_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpt
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         load_cpt : IN  std_logic;
         incr_cpt : IN  std_logic;
         init_cpt : IN  std_logic;
         bus_cpt_in : IN  std_logic_vector(5 downto 0);
         bus_cpt_out : OUT  std_logic_vector(5 downto 0);
         ce : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal load_cpt : std_logic := '0';
   signal incr_cpt : std_logic := '0';
   signal init_cpt : std_logic := '0';
   signal bus_cpt_in : std_logic_vector(5 downto 0) := (others => '0');
   signal ce : std_logic := '0';

 	--Outputs
   signal bus_cpt_out : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpt PORT MAP (
          clock => clock,
          reset => reset,
          load_cpt => load_cpt,
          incr_cpt => incr_cpt,
          init_cpt => init_cpt,
          bus_cpt_in => bus_cpt_in,
          bus_cpt_out => bus_cpt_out,
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
  -- Stimulus process
  stim_proc : process
  begin
	 ce <='1';	
    reset      <= '1';
    bus_cpt_in <= "101010";

    wait for 100 ns;
    reset    <= '0';
    load_cpt <= '0';
    incr_cpt <= '0';
    init_cpt <= '1';

    wait for clock_period*10;
    load_cpt <= '1';
    incr_cpt <= '0';
    init_cpt <= '0';

    wait for clock_period*10;
    load_cpt <= '0';
    incr_cpt <= '1';
    init_cpt <= '0';


    wait;
  end process;
END;
