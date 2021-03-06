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
  type fsm_state is (init, idle, read1, read2, read3, read4, read5, read6, read7, read8, read9, read10, decal_state, no_decal_state);
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
          if (SENS = '0'
              and (((conv_integer(CURRENT_POS(12 downto 5) - 1) mod 10) = 0 and
                    (
                      CURRENT_POS(4 downto 0) = "00000"
                      or CURRENT_POS(4 downto 0) = "10000"
                      or CURRENT_POS(4 downto 0) = "11000"
                      or CURRENT_POS(4 downto 0) = "01001"
                      or CURRENT_POS(4 downto 0) = "10001"
                      or CURRENT_POS(4 downto 0) = "11001"
                      or CURRENT_POS(4 downto 0) = "00010"
                      or CURRENT_POS(4 downto 0) = "01011"
                      or CURRENT_POS(4 downto 0) = "00100"
                      or CURRENT_POS(4 downto 0) = "01100"
                      or CURRENT_POS(4 downto 0) = "11100"
                      or CURRENT_POS(4 downto 0) = "00101"
                      or CURRENT_POS(4 downto 0) = "00110"
                      )
                    )
                   or ((conv_integer(CURRENT_POS(12 downto 5)) mod 10) = 0 and
                       (
                         CURRENT_POS(4 downto 0) = "01000"
                         or CURRENT_POS(4 downto 0) = "00001"
                         or CURRENT_POS(4 downto 0) = "01010"
                         or CURRENT_POS(4 downto 0) = "00011"
                         or CURRENT_POS(4 downto 0) = "10100"
                         or CURRENT_POS(4 downto 0) = "01101"
                         )
                       )
                   )
              )
            or (SENS = '1'
                and (((conv_integer(CURRENT_POS(12 downto 5) + 1) mod 10) = 0 and
                      (
                        CURRENT_POS(4 downto 0) = "11000"
                        or CURRENT_POS(4 downto 0) = "10001"
                        or CURRENT_POS(4 downto 0) = "00011"
                        or CURRENT_POS(4 downto 0) = "00100"
                        or CURRENT_POS(4 downto 0) = "00110"
                        )
                      )
                     or ((conv_integer(CURRENT_POS(12 downto 5) + 2) mod 10) = 0 and
                         (
                           CURRENT_POS(4 downto 0) = "00000"
                           or CURRENT_POS(4 downto 0) = "01000"
                           or CURRENT_POS(4 downto 0) = "10000"
                           or CURRENT_POS(4 downto 0) = "00001"
                           or CURRENT_POS(4 downto 0) = "01001"
                           or CURRENT_POS(4 downto 0) = "11001"
                           or CURRENT_POS(4 downto 0) = "00010"
                           or CURRENT_POS(4 downto 0) = "01010"
                           or CURRENT_POS(4 downto 0) = "00101"
                           or CURRENT_POS(4 downto 0) = "01101"
                           or CURRENT_POS(4 downto 0) = "01100"
                           or CURRENT_POS(4 downto 0) = "10100"
                           or CURRENT_POS(4 downto 0) = "11100"
                           )
                         )
                     or ((conv_integer(CURRENT_POS(12 downto 5) + 3) mod 10) = 0 and
                         CURRENT_POS(4 downto 0) = "01011"
                         )
                     )
                )
          then
            next_state <= no_decal_state;
          else
            next_state <= read1;
          end if;
        else
          next_state <= idle;
        end if;
        
      when read1 =>
        if DATA_R /= "01101101" and CURRENT_POS(4 downto 0) = "00011" then
          next_state <= no_decal_state;
        else
          next_state <= read2;
        end if;

      when read2 =>
        if DATA_R /= "01101101"
          and ((SENS = '0'
                and (CURRENT_POS(4 downto 0) = "01001"
                     or CURRENT_POS(4 downto 0) = "00100"
                     )
                )
               or (SENS = '1'
                   and CURRENT_POS(4 downto 0) = "01001"
                   )
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read3;
        end if;

      when read3 =>
        if DATA_R /= "01101101"
          and ((SENS = '0'
                and (CURRENT_POS(4 downto 0) = "01000"
                     or CURRENT_POS(4 downto 0) = "10000"
                     or CURRENT_POS(4 downto 0) = "11000"
                     or CURRENT_POS(4 downto 0) = "00001"
                     or CURRENT_POS(4 downto 0) = "10001"
                     or CURRENT_POS(4 downto 0) = "01010"
                     or CURRENT_POS(4 downto 0) = "00011"
                     or CURRENT_POS(4 downto 0) = "10100"
                     )
                )
               or (SENS = '1'
                   and (CURRENT_POS(4 downto 0) = "01000"
                        or CURRENT_POS(4 downto 0) = "10000"
                        or CURRENT_POS(4 downto 0) = "11000"
                        or CURRENT_POS(4 downto 0) = "10001"
                        or CURRENT_POS(4 downto 0) = "01010"
                        or CURRENT_POS(4 downto 0) = "00011"
                        or CURRENT_POS(4 downto 0) = "00100"
                        or CURRENT_POS(4 downto 0) = "10100"
                        )
                   )
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read4;
        end if;

      when read4 =>
        if DATA_R /= "01101101"
          and ((SENS = '0'
                and (CURRENT_POS(4 downto 0) = "11100"
                     or CURRENT_POS(4 downto 0) = "01101"
                     )
                )
               or (SENS = '1'
                   and (CURRENT_POS(4 downto 0) = "00001"
                        or CURRENT_POS(4 downto 0) = "11100"
                        or CURRENT_POS(4 downto 0) = "01101"
                        )
                   )
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read5;
        end if;

      when read5 =>
        if DATA_R /= "01101101"
          and ((SENS = '0'
                and (CURRENT_POS(4 downto 0) = "00000"
                     or CURRENT_POS(4 downto 0) = "10000"
                     or CURRENT_POS(4 downto 0) = "11000"
                     or CURRENT_POS(4 downto 0) = "01001"
                     or CURRENT_POS(4 downto 0) = "11001"
                     or CURRENT_POS(4 downto 0) = "01011"
                     or CURRENT_POS(4 downto 0) = "01100"
                     or CURRENT_POS(4 downto 0) = "11100"
                     or CURRENT_POS(4 downto 0) = "00101"
                     or CURRENT_POS(4 downto 0) = "00110"
                     )
                )
               or (SENS = '1'
                   and (CURRENT_POS(4 downto 0) = "11000"
                        or CURRENT_POS(4 downto 0) = "00001"
                        or CURRENT_POS(4 downto 0) = "10001"
                        or CURRENT_POS(4 downto 0) = "00011"
                        or CURRENT_POS(4 downto 0) = "00100"
                        or CURRENT_POS(4 downto 0) = "10100"
                        or CURRENT_POS(4 downto 0) = "00101"
                        or CURRENT_POS(4 downto 0) = "00110"
                        )
                   )
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read6;
        end if;

      when read6 =>
        if DATA_R /= "01101101"
          and ((SENS = '0'
                and (CURRENT_POS(4 downto 0) = "01000"
                     or CURRENT_POS(4 downto 0) = "00001"
                     or CURRENT_POS(4 downto 0) = "10001"
                     or CURRENT_POS(4 downto 0) = "00010"
                     or CURRENT_POS(4 downto 0) = "01010"
                     or CURRENT_POS(4 downto 0) = "00011"
                     or CURRENT_POS(4 downto 0) = "00100"
                     or CURRENT_POS(4 downto 0) = "10100"
                     or CURRENT_POS(4 downto 0) = "01101"
                     )
                )
               or (SENS = '1'
                   and (CURRENT_POS(4 downto 0) = "00000"
                        or CURRENT_POS(4 downto 0) = "01000"
                        or CURRENT_POS(4 downto 0) = "10000"
                        or CURRENT_POS(4 downto 0) = "01001"
                        or CURRENT_POS(4 downto 0) = "11001"
                        or CURRENT_POS(4 downto 0) = "00010"
                        or CURRENT_POS(4 downto 0) = "01010"
                        or CURRENT_POS(4 downto 0) = "01100"
                        or CURRENT_POS(4 downto 0) = "11100"
                        or CURRENT_POS(4 downto 0) = "01101"
                        )
                   )
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read7;
        end if;

      when read7 =>
        if DATA_R /= "01101101"
          and ((SENS = '0'
                and (CURRENT_POS(4 downto 0) = "10001"
                     or CURRENT_POS(4 downto 0) = "00010"
                     or CURRENT_POS(4 downto 0) = "01100"
                     or CURRENT_POS(4 downto 0) = "01110"
                     or CURRENT_POS(4 downto 0) = "00110"
                     )
                )
               or (SENS = '1' and CURRENT_POS(4 downto 0) = "01011")
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read8;
        end if;

      when read8 =>
        if DATA_R /= "01101101"
          and ((SENS = '0'
                and (CURRENT_POS(4 downto 0) = "00000"
                     or CURRENT_POS(4 downto 0) = "01000"
                     or CURRENT_POS(4 downto 0) = "11000"
                     or CURRENT_POS(4 downto 0) = "00001"
                     or CURRENT_POS(4 downto 0) = "11001"
                     or CURRENT_POS(4 downto 0) = "00011"
                     or CURRENT_POS(4 downto 0) = "00100"
                     or CURRENT_POS(4 downto 0) = "10100"
                     or CURRENT_POS(4 downto 0) = "00101"
                     or CURRENT_POS(4 downto 0) = "01101"
                     )
                )
               or (SENS = '1' and CURRENT_POS(4 downto 0) = "01100")
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read9;
        end if;

      when read9 =>
        if DATA_R /= "01101101"
          and ((SENS = '0' and CURRENT_POS(4 downto 0) = "01010")
               or (SENS = '1'
                   and (CURRENT_POS(4 downto 0) = "00000"
                        or CURRENT_POS(4 downto 0) = "01000"
                        or CURRENT_POS(4 downto 0) = "11000"
                        or CURRENT_POS(4 downto 0) = "00001"
                        or CURRENT_POS(4 downto 0) = "10001"
                        or CURRENT_POS(4 downto 0) = "00010"
                        or CURRENT_POS(4 downto 0) = "00011"
                        or CURRENT_POS(4 downto 0) = "01101"
                        or CURRENT_POS(4 downto 0) = "00110"
                        )
                   )
               )
        then
          next_state <= no_decal_state;
        else
          next_state <= read10;
        end if;

      when read10 =>
        if DATA_R /= "01101101"
          and SENS = '1'
          and (CURRENT_POS(4 downto 0) = "11001"
               or CURRENT_POS(4 downto 0) = "01010"
               or CURRENT_POS(4 downto 0) = "10100"
               or CURRENT_POS(4 downto 0) = "00101"
               )
        then
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
        
      when read1 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) - 21;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) - 19;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read2 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) - 12;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) - 10;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read3 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) - 11;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) - 9;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read4 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) - 10;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) - 8;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read5 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) - 2;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) + 1;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read6 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) - 1;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) + 2;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read7 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) + 8;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) + 3;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read8 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) + 9;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) + 10;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read9 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= CURRENT_POS(12 downto 5) + 10;
        else
          ADDRESS <= CURRENT_POS(12 downto 5) + 11;
        end if;
        LOAD   <= '0';
        R_W    <= '0';
        EN_MEM <= '1';

      when read10 =>
        FIN      <= '0';
        NEXT_POS <= "0000000000000";
        if SENS = '0' then
          ADDRESS <= "00000000";
        else
          ADDRESS <= CURRENT_POS(12 downto 5) + 12;
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

