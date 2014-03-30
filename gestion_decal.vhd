----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:00 02/15/2011 
-- Design Name: 
-- Module Name:    CPU_8bits - Behavioral 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_decal is
  port (
    CLOCK       : in  std_logic;
    RESET       : in  std_logic;
    DEBUT       : in  std_logic;
    FIN         : out std_logic;
    SENS        : in  std_logic;
    NEXT_POS    : out std_logic_vector(12 downto 0);
    CURRENT_POS : in  std_logic_vector(12 downto 0);
    LOAD        : out std_logic;
    ADDRESS     : out std_logic_vector(7 downto 0);
    DATA_R      : in  std_logic_vector(7 downto 0);
    R_W         : out std_logic;
    EN_MEM      : out std_logic;
    CE          : in  std_logic
    );
end gestion_decal;

architecture Behavioral of gestion_decal is
  type fsm_state is (init, idle, test, decal_state, no_decal_state);
  signal next_state, current_state : fsm_state;
  
begin
  process (clock, reset) is             -- register
  begin  -- PROCESS

    if clock'event and clock = '1' then  -- rising clock edge
      if reset = '1' then                -- asynchronous reset (active low)
        current_state <= init;
      else
        if ce = '1' then
          current_state <= next_state;
        end if;
      end if;
    end if;
  end process;

  process (current_state, DEBUT) is     -- ???
  begin  -- PROCESS
    case current_state is               -- next state function

      when init => next_state <= idle;

      when idle =>
        if DEBUT = '1' then
          -- on teste la collision contre les bords
          if (SENS = '0' and ((conv_integer(CURRENT_POS(12 downto 5)) mod 10) = 0)) or (SENS = '1' and (((conv_integer(CURRENT_POS(12 downto 5)) + 1) mod 10) = 0)) then
            next_state <= no_decal_state;
          else
            next_state <= test;
          end if;
        else
          next_state <= idle;
        end if;
        
      when test =>
        if DATA_R /= "01101101" then
          next_state <= no_decal_state;
        else
          next_state <= decal_state;
        end if;

      when others => next_state <= idle;

    end case;
  end process;

  process (current_state) is            -- output function
  begin  -- PROCESS
    case current_state is
      when init =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= "00000000";
        R_W      <= '0';
        EN_MEM   <= '0';
        
      when idle =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= "00000000";
        R_W      <= '0';
        EN_MEM   <= '0';
        
      when test =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '1' then 
          ADDRESS <= CURRENT_POS(12 downto 5) + 1;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) - 1;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';  
        
      when no_decal_state =>
        FIN      <= '1';
        NEXT_POS <= CURRENT_POS;
        LOAD     <= '1';
        ADDRESS  <= "00000000";
        R_W      <= '0';
        EN_MEM   <= '0';
        
      when decal_state =>
        FIN <= '1';
        if SENS = '1' then
          NEXT_POS(12 downto 5) <= CURRENT_POS(12 downto 5) + 1;
        else
          NEXT_POS(12 downto 5) <= CURRENT_POS(12 downto 5) - 1;
        end if;
        NEXT_POS(4 downto 0) <= CURRENT_POS(4 downto 0);
        LOAD                 <= '1';
        ADDRESS              <= "00000000";
        R_W                  <= '0';
        EN_MEM               <= '0';
        
    end case;
  end process;
end Behavioral;

