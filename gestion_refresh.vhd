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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_refresh is
  port (
    CLOCK           : in  std_logic;
    RESET           : in  std_logic;
    DEBUT           : in  std_logic;
    FIN             : out std_logic;
    NEXT_POS_GET    : in  std_logic_vector(12 downto 0);
    CURRENT_POS_GET : in  std_logic_vector(12 downto 0);
    CURRENT_POS_SET : out std_logic_vector(12 downto 0);
    LOAD_CURRENT    : out std_logic;
    COUNTER_R       : in  std_logic_vector(7 downto 0);
    COUNTER_W       : out std_logic_vector(7 downto 0);
    LOAD_COUNTER    : out std_logic;
    INCR_COUNTER    : out std_logic;
    DECR_COUNTER    : out std_logic;
    INIT_COUNTER    : out std_logic;
    REGISTER_R      : in  std_logic_vector(7 downto 0);
    LOAD_REGISTER   : out std_logic;
    REGISTER_W      : out std_logic_vector(7 downto 0);
    ADDRESS         : out std_logic_vector(7 downto 0);
    DATA_R          : in  std_logic_vector(7 downto 0);
    DATA_W          : out std_logic_vector(7 downto 0);
    R_W             : out std_logic;
    EN_MEM          : out std_logic;
    FIN_JEU         : out std_logic;
    CE              : in  std_logic
    );
end gestion_refresh;

architecture Behavioral of gestion_refresh is
  type fsm_state is (init, idle, delete0, write0, delete1, write1, delete2, write2, delete3, write3, delete4, write4, delete5, write5, delete6, write6, delete7, write7, delete8, write8, delete9, write9, delete10, write10, init_test_delrow, test_delrow, delrow_r, delrow_w, test_fin_jeu, fin_jeu_state, clean);
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

  process (current_state, DEBUT, COUNTER_R, DATA_R) is  -- ???
  begin  -- PROCESS
    case current_state is                               -- next state function

      when init => next_state <= clean;

      when idle =>
        if DEBUT = '1' then
          next_state <= delete0;
        else
          next_state <= idle;
        end if;

      when init_test_delrow =>
        next_state <= test_delrow;

      when test_fin_jeu =>
        if COUNTER_R = NEXT_POS_GET(12 downto 5) +12 then
          next_state <= write0;
        elsif DATA_R /= "01101101" and COUNTER_R < 199 then
          next_state <= fin_jeu_state;
        else
          next_state <= test_fin_jeu;
        end if;

      when fin_jeu_state =>
        next_state <= clean;
        
      when clean =>
        if COUNTER_R = 199 then
          next_state <= idle;
        else
          next_state <= clean;
        end if;
        
      when test_delrow =>
        if((conv_integer(COUNTER_R + 1) mod 10) = 0) and DATA_R /= "01101101" then
          next_state <= delrow_r;
        elsif COUNTER_R > 199 then
          next_state <= test_fin_jeu;
        else
          next_state <= test_delrow;
        end if;

      when delrow_r =>
        next_state <= delrow_w;

      when delrow_w =>
        if COUNTER_R = 0 then
          next_state <= init_test_delrow;
        else
          next_state <= delrow_r;
        end if;
        
      when delete0 =>
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          next_state <= init_test_delrow;
        else                            -- sinon
          next_state <= delete1;
        end if;

      when write0 =>
        next_state <= write1;
        
      when delete1 =>
        next_state <= delete2;
        
      when write1 =>
        next_state <= write2;
        
      when delete2 =>
        next_state <= delete3;
        
      when write2 =>
        next_state <= write3;
        
      when delete3 =>
        next_state <= delete4;
        
      when write3 =>
        next_state <= write4;
        
      when delete4 =>
        next_state <= delete5;
        
      when write4 =>
        next_state <= write5;
        
      when delete5 =>
        next_state <= delete6;
        
      when write5 =>
        next_state <= write6;
        
      when delete6 =>
        next_state <= delete7;
        
      when write6 =>
        next_state <= write7;
        
      when delete7 =>
        next_state <= delete8;
        
      when write7 =>
        next_state <= write8;
        
      when delete8 =>
        next_state <= delete9;
        
      when write8 =>
        next_state <= write9;
        
      when delete9 =>
        next_state <= delete10;
        
      when write9 =>
        next_state <= write10;
        
      when delete10 =>
        next_state <= write0;
        
      when write10 =>
        next_state <= idle;

    end case;
  end process;

  process (current_state, DATA_R, COUNTER_R) is  -- output function
  begin  -- PROCESS
    case current_state is
      when init =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= "00000000";
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '0';
        FIN_JEU         <= '0';
        COUNTER_W       <= "00000000";
        LOAD_COUNTER    <= '1';
        INCR_COUNTER    <= '0';
        DECR_COUNTER    <= '0';
        INIT_COUNTER    <= '0';
        LOAD_REGISTER   <= '0';
        REGISTER_W      <= "00000000";
      when idle =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= "00000000";
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '0';
        FIN_JEU         <= '0';
        COUNTER_W       <= "00000000";
        LOAD_COUNTER    <= '0';
        INCR_COUNTER    <= '0';
        DECR_COUNTER    <= '0';
        INIT_COUNTER    <= '0';
        LOAD_REGISTER   <= '0';
        REGISTER_W      <= "00000000";
        
      when init_test_delrow =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= "00000000";
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '0';
        FIN_JEU         <= '0';
        COUNTER_W       <= "00000000";
        LOAD_COUNTER    <= '0';
        INCR_COUNTER    <= '0';
        DECR_COUNTER    <= '0';
        INIT_COUNTER    <= '1';
        LOAD_REGISTER   <= '0';
        REGISTER_W      <= "00000000";



      when test_delrow =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= COUNTER_R;
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '1';
        FIN_JEU         <= '0';
        if(DATA_R /= "01101101")then
          if (conv_integer(COUNTER_R + 1) mod 10 = 0) then
            COUNTER_W    <= "00000000";
            LOAD_COUNTER <= '0';
            INCR_COUNTER <= '0';
          else
            COUNTER_W    <= "00000000";
            LOAD_COUNTER <= '0';
            INCR_COUNTER <= '1';
          end if;
        else
          COUNTER_W    <= COUNTER_R + 10 - (std_logic_vector(unsigned(COUNTER_R) mod 10));
          LOAD_COUNTER <= '1';
          INCR_COUNTER <= '0';
        end if;
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when fin_jeu_state =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= "00000000";
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '0';
        FIN_JEU         <= '1';
        COUNTER_W       <= "00000000";
        LOAD_COUNTER    <= '1';
        INCR_COUNTER    <= '0';
        DECR_COUNTER    <= '0';
        INIT_COUNTER    <= '0';
        LOAD_REGISTER   <= '0';
        REGISTER_W      <= "00000000";

      when clean =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= COUNTER_R;
        DATA_W          <= "01101101";
        R_W             <= '1';
        EN_MEM          <= '1';
        FIN_JEU         <= '0';
        COUNTER_W       <= "00000000";
        LOAD_COUNTER    <= '0';
        INCR_COUNTER    <= '1';
        DECR_COUNTER    <= '0';
        INIT_COUNTER    <= '0';
        LOAD_REGISTER   <= '0';
        REGISTER_W      <= "00000000";

      when delrow_r =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= COUNTER_R - 10;
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '1';
        FIN_JEU         <= '0';
        COUNTER_W       <= "00000000";
        LOAD_COUNTER    <= '0';
        INCR_COUNTER    <= '0';
        DECR_COUNTER    <= '0';
        INIT_COUNTER    <= '0';
        LOAD_REGISTER   <= '1';
        REGISTER_W      <= DATA_R;

      when delrow_w =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= COUNTER_R;
        DATA_W          <= REGISTER_R;
        R_W             <= '1';
        EN_MEM          <= '1';
        FIN_JEU         <= '0';
        COUNTER_W       <= "00000000";
        LOAD_COUNTER    <= '0';
        INCR_COUNTER    <= '0';
        DECR_COUNTER    <= '1';
        INIT_COUNTER    <= '0';
        LOAD_REGISTER   <= '0';
        REGISTER_W      <= "00000000";

      when test_fin_jeu =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= COUNTER_R;
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '1';
        FIN_JEU         <= '0';
        if COUNTER_R > 199 then
          COUNTER_W <= NEXT_POS_GET(12 downto 5) - 1;
        elsif COUNTER_R = NEXT_POS_GET(12 downto 5) +2 then
          COUNTER_W <= NEXT_POS_GET(12 downto 5) + 9;
        else
          COUNTER_W <= COUNTER_R + 1;
        end if;
        LOAD_COUNTER  <= '1';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete0 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5);
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        EN_MEM        <= '1';
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write0 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5);
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W           <= '1';
        EN_MEM        <= '1';
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete1 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) - 20;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "00011" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write1 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) - 20;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "00011" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete2 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) - 11;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "01001" or CURRENT_POS_GET(4 downto 0) = "00100" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;

        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write2 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) -11;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "01001"
          or NEXT_POS_GET(4 downto 0) = "00100" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete3 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) -10;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "01000"
          or CURRENT_POS_GET(4 downto 0) = "10000"
          or CURRENT_POS_GET(4 downto 0) = "11000"
          or CURRENT_POS_GET(4 downto 0) = "00001"
          or CURRENT_POS_GET(4 downto 0) = "10001"
          or CURRENT_POS_GET(4 downto 0) = "01010"
          or CURRENT_POS_GET(4 downto 0) = "00011"
          or CURRENT_POS_GET(4 downto 0) = "00100"
          or CURRENT_POS_GET(4 downto 0) = "10100" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write3 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) - 10;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "01000"
          or NEXT_POS_GET(4 downto 0) = "10000"
          or NEXT_POS_GET(4 downto 0) = "11000"
          or NEXT_POS_GET(4 downto 0) = "00001"
          or NEXT_POS_GET(4 downto 0) = "10001"
          or NEXT_POS_GET(4 downto 0) = "01010"
          or NEXT_POS_GET(4 downto 0) = "00011"
          or NEXT_POS_GET(4 downto 0) = "00100"
          or NEXT_POS_GET(4 downto 0) = "10100" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete4 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) - 9;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "00001"
          or CURRENT_POS_GET(4 downto 0) = "11100"
          or CURRENT_POS_GET(4 downto 0) = "01101" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write4 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) - 9;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "00001"
          or NEXT_POS_GET(4 downto 0) = "11100"
          or NEXT_POS_GET(4 downto 0) = "01101" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete5 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) - 1;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "00000"
          or CURRENT_POS_GET(4 downto 0) = "10000"
          or CURRENT_POS_GET(4 downto 0) = "11000"
          or CURRENT_POS_GET(4 downto 0) = "01001"
          or CURRENT_POS_GET(4 downto 0) = "11001"
          or CURRENT_POS_GET(4 downto 0) = "01011"
          or CURRENT_POS_GET(4 downto 0) = "01100"
          or CURRENT_POS_GET(4 downto 0) = "11100"
          or CURRENT_POS_GET(4 downto 0) = "00101"
          or CURRENT_POS_GET(4 downto 0) = "00110" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write5 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) - 1;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "00000"
          or NEXT_POS_GET(4 downto 0) = "10000"
          or NEXT_POS_GET(4 downto 0) = "11000"
          or NEXT_POS_GET(4 downto 0) = "01001"
          or NEXT_POS_GET(4 downto 0) = "11001"
          or NEXT_POS_GET(4 downto 0) = "01011"
          or NEXT_POS_GET(4 downto 0) = "01100"
          or NEXT_POS_GET(4 downto 0) = "11100"
          or NEXT_POS_GET(4 downto 0) = "00101"
          or NEXT_POS_GET(4 downto 0) = "00110" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete6 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) + 1;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "00000"
          or CURRENT_POS_GET(4 downto 0) = "01000"
          or CURRENT_POS_GET(4 downto 0) = "10000"
          or CURRENT_POS_GET(4 downto 0) = "01001"
          or CURRENT_POS_GET(4 downto 0) = "11001"
          or CURRENT_POS_GET(4 downto 0) = "00010"
          or CURRENT_POS_GET(4 downto 0) = "01010"
          or CURRENT_POS_GET(4 downto 0) = "01011"
          or CURRENT_POS_GET(4 downto 0) = "01100"
          or CURRENT_POS_GET(4 downto 0) = "11100"
          or CURRENT_POS_GET(4 downto 0) = "01101" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write6 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) + 1;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "00000"
          or NEXT_POS_GET(4 downto 0) = "01000"
          or NEXT_POS_GET(4 downto 0) = "10000"
          or NEXT_POS_GET(4 downto 0) = "01001"
          or NEXT_POS_GET(4 downto 0) = "11001"
          or NEXT_POS_GET(4 downto 0) = "00010"
          or NEXT_POS_GET(4 downto 0) = "01010"
          or NEXT_POS_GET(4 downto 0) = "01011"
          or NEXT_POS_GET(4 downto 0) = "01100"
          or NEXT_POS_GET(4 downto 0) = "11100"
          or NEXT_POS_GET(4 downto 0) = "01101" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete7 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) + 2;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "01011" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write7 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) + 2;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "01011" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete8 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) + 9;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "10001"
          or CURRENT_POS_GET(4 downto 0) = "00010"
          or CURRENT_POS_GET(4 downto 0) = "01100"
          or CURRENT_POS_GET(4 downto 0) = "00110" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write8 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) + 9;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "10001"
          or NEXT_POS_GET(4 downto 0) = "00010"
          or NEXT_POS_GET(4 downto 0) = "01100"
          or NEXT_POS_GET(4 downto 0) = "00110" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete9 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) + 10;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "00000"
          or CURRENT_POS_GET(4 downto 0) = "01000"
          or CURRENT_POS_GET(4 downto 0) = "11000"
          or CURRENT_POS_GET(4 downto 0) = "00001"
          or CURRENT_POS_GET(4 downto 0) = "10001"
          or CURRENT_POS_GET(4 downto 0) = "00010"
          or CURRENT_POS_GET(4 downto 0) = "00011"
          or CURRENT_POS_GET(4 downto 0) = "00100"
          or CURRENT_POS_GET(4 downto 0) = "10100"
          or CURRENT_POS_GET(4 downto 0) = "00101"
          or CURRENT_POS_GET(4 downto 0) = "01101"
          or CURRENT_POS_GET(4 downto 0) = "00110" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write9 =>
        FIN             <= '0';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '0';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) + 10;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "00000"
          or NEXT_POS_GET(4 downto 0) = "01000"
          or NEXT_POS_GET(4 downto 0) = "11000"
          or NEXT_POS_GET(4 downto 0) = "00001"
          or NEXT_POS_GET(4 downto 0) = "10001"
          or NEXT_POS_GET(4 downto 0) = "00010"
          or NEXT_POS_GET(4 downto 0) = "00011"
          or NEXT_POS_GET(4 downto 0) = "00100"
          or NEXT_POS_GET(4 downto 0) = "10100"
          or NEXT_POS_GET(4 downto 0) = "00101"
          or NEXT_POS_GET(4 downto 0) = "01101"
          or NEXT_POS_GET(4 downto 0) = "00110" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when delete10 =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD_CURRENT    <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5) + 11;
        DATA_W          <= "01101101";
        if (NEXT_POS_GET(12 downto 5) < 10) and (CURRENT_POS_GET(12 downto 5) >= 10) then  -- nouvelle piece
          R_W <= '0';                   -- on efface pas
        else                            -- sinon
          R_W <= '1';                   -- on efface
        end if;
        if CURRENT_POS_GET(4 downto 0) = "11001"
          or CURRENT_POS_GET(4 downto 0) = "01010"
          or CURRENT_POS_GET(4 downto 0) = "10100"
          or CURRENT_POS_GET(4 downto 0) = "00101" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

      when write10 =>
        FIN             <= '1';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD_CURRENT    <= '1';
        ADDRESS         <= NEXT_POS_GET(12 downto 5) + 11;
        case NEXT_POS_GET(2 downto 0) is
          when "000"  => DATA_W <= "11100000";
          when "001"  => DATA_W <= "00011100";
          when "010"  => DATA_W <= "00000011";
          when "011"  => DATA_W <= "11111100";
          when "100"  => DATA_W <= "11100011";
          when "101"  => DATA_W <= "00011111";
          when "110"  => DATA_W <= "10101010";
          when others => DATA_W <= "11111111";
        end case;
        R_W <= '1';
        if NEXT_POS_GET(4 downto 0) = "11001"
          or NEXT_POS_GET(4 downto 0) = "01010"
          or NEXT_POS_GET(4 downto 0) = "10100"
          or NEXT_POS_GET(4 downto 0) = "00101" then
          EN_MEM <= '1';
        else
          EN_MEM <= '0';
        end if;
        FIN_JEU       <= '0';
        COUNTER_W     <= "00000000";
        LOAD_COUNTER  <= '0';
        INCR_COUNTER  <= '0';
        DECR_COUNTER  <= '0';
        INIT_COUNTER  <= '0';
        LOAD_REGISTER <= '0';
        REGISTER_W    <= "00000000";

    end case;
  end process;


end Behavioral;


