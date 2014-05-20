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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_chute is
  port (
    CLOCK       : in  std_logic;
    RESET       : in  std_logic;
    DEBUT       : in  std_logic;
    FIN         : out std_logic;
    NEXT_POS    : out std_logic_vector(12 downto 0);
    CURRENT_POS : in  std_logic_vector(12 downto 0);
    LOAD        : out std_logic;
    ADDRESS     : out std_logic_vector(7 downto 0);
    DATA_R      : in  std_logic_vector(7 downto 0);
    R_W         : out std_logic;
    EN_MEM      : out std_logic;
    LOAD_FF     : out std_logic;
    INCR_SCORE : out std_logic;
    CE          : in  std_logic
    );
end gestion_chute;

architecture Behavioral of gestion_chute is
  type fsm_state is (init, idle, read1, read2, read3, read4, read5, read6, read7, read8, read9, chute_state, no_chute_state);
  signal next_state, current_state : fsm_state;
  signal random_type               : std_logic_vector(2 downto 0);
begin

  process (clock, reset) is
  begin
    if clock'event and clock = '1' then  -- rising clock edge
      if reset = '1' then                -- asynchronous reset (active low)
        random_type <= "000";
      else
        if random_type = "110" then
          random_type <= "000";
        else
          random_type <= random_type + 1;
        end if;
      end if;
    end if;
  end process;


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
          -- last row
          if(CURRENT_POS(4 downto 0) = "10000"
             or CURRENT_POS(4 downto 0) = "01001"
             or CURRENT_POS(4 downto 0) = "01011"
             or CURRENT_POS(4 downto 0) = "11100"
             )
          then
            if CURRENT_POS(12 downto 5) >= 190 then
              next_state <= no_chute_state;
            else
              next_state <= read1;
            end if;
          elsif CURRENT_POS(12 downto 5) >= 180 then
            next_state <= no_chute_state;
          else
            next_state <= read1;
          end if;
        else
          next_state <= idle;
        end if;
        
      when read1 =>
        if DATA_R /= "01101101" and CURRENT_POS(4 downto 0) = "00100" then
          next_state <= no_chute_state;
        else
          next_state <= read2;
        end if;
        
      when read2 =>
        if DATA_R /= "01101101" and CURRENT_POS(4 downto 0) = "00001" then
          next_state <= no_chute_state;
        else
          next_state <= read3;
        end if;
        
      when read3 =>
        if DATA_R /= "01101101"
          and (CURRENT_POS(4 downto 0) = "00000"
               or CURRENT_POS(4 downto 0) = "10000"
               or CURRENT_POS(4 downto 0) = "11000"
               or CURRENT_POS(4 downto 0) = "01001"
               or CURRENT_POS(4 downto 0) = "11001"
               or CURRENT_POS(4 downto 0) = "01011"
               or CURRENT_POS(4 downto 0) = "11100"
               or CURRENT_POS(4 downto 0) = "00101") then
          next_state <= no_chute_state;
        else
          next_state <= read4;
        end if;
        
      when read4 =>
        if DATA_R /= "01101101"
          and (CURRENT_POS(4 downto 0) = "10000"
               or CURRENT_POS(4 downto 0) = "01001"
               or CURRENT_POS(4 downto 0) = "11001"
               or CURRENT_POS(4 downto 0) = "01010"
               or CURRENT_POS(4 downto 0) = "01011"
               or CURRENT_POS(4 downto 0) = "11100"
               or CURRENT_POS(4 downto 0) = "01100") then
          next_state <= no_chute_state;
        else
          next_state <= read5;
        end if;
        
      when read5 =>
        if DATA_R /= "01101101"
          and (CURRENT_POS(4 downto 0) = "00000"
               or CURRENT_POS(4 downto 0) = "01000"
               or CURRENT_POS(4 downto 0) = "10000"
               or CURRENT_POS(4 downto 0) = "01001"
               or CURRENT_POS(4 downto 0) = "00010"
               or CURRENT_POS(4 downto 0) = "01011"
               or CURRENT_POS(4 downto 0) = "01100"
               or CURRENT_POS(4 downto 0) = "11100"
               or CURRENT_POS(4 downto 0) = "01101") then
          next_state <= no_chute_state;
        else
          next_state <= read6;
        end if;
        
      when read6 =>
        if DATA_R /= "01101101"
          and CURRENT_POS(4 downto 0) = "01011" then
          next_state <= no_chute_state;
        else
          next_state <= read7;
        end if;
        
      when read7 =>
        if DATA_R /= "01101101"
          and (CURRENT_POS(4 downto 0) = "10001"
               or CURRENT_POS(4 downto 0) = "00010"
               or CURRENT_POS(4 downto 0) = "01100"
               or CURRENT_POS(4 downto 0) = "00110"
               ) then
          next_state <= no_chute_state;
        else
          next_state <= read8;
        end if;
        
      when read8 =>
        if DATA_R /= "01101101"
          and (CURRENT_POS(4 downto 2) = "000"
               or CURRENT_POS(2 downto 0) = "110"
               or CURRENT_POS(2 downto 0) = "101"
               or CURRENT_POS(4 downto 0) = "01000"
               or CURRENT_POS(4 downto 0) = "10001"
               or CURRENT_POS(4 downto 0) = "11000"
               or CURRENT_POS(4 downto 0) = "10010"
               or CURRENT_POS(4 downto 0) = "11010"
               or CURRENT_POS(4 downto 0) = "00100"
               or CURRENT_POS(4 downto 0) = "10100") then
          next_state <= no_chute_state;
        else
          next_state <= read9;
        end if;

      when read9 =>
        if DATA_R /= "01101101"
          and (CURRENT_POS(4 downto 0) = "11001"
               or CURRENT_POS(4 downto 0) = "01010"
               or CURRENT_POS(4 downto 0) = "10100"
               or CURRENT_POS(4 downto 0) = "00101") then
          next_state <= no_chute_state;
        else
          next_state <= chute_state;
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
        LOAD_FF  <= '0';
        INCR_SCORE <= '0';

        
      when idle =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= "00000000";
        R_W      <= '0';
        EN_MEM   <= '0';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read1 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) - 1;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';

      when read2 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 1;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read3 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 9;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read4 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 10;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read5 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 11;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read6 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 12;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read7 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 19;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read8 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 20;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when read9 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        LOAD     <= '0';
        ADDRESS  <= CURRENT_POS(12 downto 5) + 21;
        R_W      <= '0';
        EN_MEM   <= '1';
        LOAD_FF  <= '0';
        
        INCR_SCORE <= '0';
        
      when no_chute_state =>
        FIN                   <= '1';
        NEXT_POS(12 downto 3) <= "0000010100";
        NEXT_POS(2 downto 0)  <= random_type;
        LOAD                  <= '1';
        ADDRESS               <= "00000000";
        R_W                   <= '0';
        EN_MEM                <= '0';
        LOAD_FF               <= '1';
        
        INCR_SCORE <= '1';
        
      when chute_state =>
        FIN                   <= '1';
        NEXT_POS(12 downto 5) <= CURRENT_POS(12 downto 5) +10;
        NEXT_POS(4 downto 0)  <= CURRENT_POS(4 downto 0);
        LOAD                  <= '1';
        ADDRESS               <= "00000000";
        R_W                   <= '0';
        EN_MEM                <= '0';
        LOAD_FF               <= '0';
        
        INCR_SCORE <= '0';
        
    end case;
  end process;


end Behavioral;

