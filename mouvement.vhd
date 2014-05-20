---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:10:12 02/19/2013 
-- Design Name: 
-- Module Name:    fsm - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mouvement is
  generic (
    rot_period   : std_logic_vector(6 downto 0) := "0001111";  -- periode de decalage (20 - >  200 ms)
    decal_period : std_logic_vector(6 downto 0) := "0001000");  -- periode de rotation (8 - >  80 ms)

  port (
    clock     : in  std_logic;
    CE_100Hz  : in  std_logic;
    reset     : in  std_logic;
    fsm_ready : in  std_logic;
    haut      : in  std_logic;
    gauche    : in  std_logic;
    DROITE    : in  std_logic;
    BAS       : in  std_logic;
    CHUTE     : out std_logic;
    ROT       : out std_logic;
    DECAL     : out std_logic;
    SENS      : out std_logic;
    LEVEL     : in std_logic_vector(5 downto 0);
    ce        : in  std_logic
    );
end mouvement;

architecture Behavioral of mouvement is

  signal chute_period : std_logic_vector(6 downto 0) := "0100011";  -- periode de chute (50 - >  500 ms)

  signal chute_counter : std_logic_vector(6 downto 0) := "0000000";
  signal rot_counter   : std_logic_vector(6 downto 0) := "0000000";
  signal decal_counter : std_logic_vector(6 downto 0) := "0000000";


begin
  process (clock, reset) is
  begin  -- process
    
   
    if clock'event and clock = '1' then         -- rising clock edge
      if reset = '1' then
        chute_period  <= "0100011";
        chute_counter <= "0000000";
        decal_counter <= "0000000";
        rot_counter   <= "0000001";  --rot counter shifted to avoid having rot and decal at the same time
        CHUTE         <= '0';
        ROT           <= '0';
        DECAL         <= '0';
        SENS          <= '0';
      else
       
        if LEVEL < 10 then
			 chute_period <= "0100011";--35
		  elsif LEVEL < 20 then	
          chute_period <= "0011110";--30
		  elsif LEVEL < 30 then	
          chute_period <= "0011001";--25
		  elsif LEVEL < 40 then	
          chute_period <= "0010100";--20
		  else
			 chute_period <= "0001111";--15
		  end if;
			 
			 
			 
			 
        if CE_100Hz = '1' and ce = '1' then     -- counting on 100 Hz frequency
          if chute_counter >= chute_period then  -- every chute_period, pulse
            if fsm_ready = '1' then     -- fsm ready to read input
              chute_counter <= "0000000";
              CHUTE         <= '1';  -- CHUTE is reset whenever CE_100Hz is not high
            end if;
          else
            if BAS = '1' then
              chute_counter <= chute_counter + 6;
            else
              chute_counter <= chute_counter + 1;
            end if;
          end if;

          if rot_counter = rot_period then          -- every rot_period
            if fsm_ready = '1' and HAUT = '1' then  -- counter is started only when button is activated
              rot_counter <= "0000000";
              ROT         <= '1';  -- ROT is reset whenever CE_100Hz is not high
            end if;
          else
            rot_counter <= rot_counter + 1;
          end if;

          if decal_counter = decal_period then  -- every decal_period
            if fsm_ready = '1' and (GAUCHE = '1' xor DROITE = '1') then
              decal_counter <= "0000000";
              DECAL         <= '1';  -- DECAL is reset whenever CE_100Hz is not high
              if GAUCHE = '1' then
                SENS <= '0';
              else                      -- DROITE = '1' 
                SENS <= '1';
              end if;
            end if;
          else
            decal_counter <= decal_counter + 1;
          end if;
          
        elsif ce = '1' then  --DECAL, ROT and CHUTE reset whenever CE_100 is low
          ROT   <= '0';
          DECAL <= '0';
          CHUTE <= '0';
        end if;
      end if;
    end if;
  end process;
end Behavioral;

