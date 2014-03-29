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

entity gestion_refresh is
  port (
    CLOCK           : in  std_logic;
    RESET           : in  std_logic;
    DEBUT           : in  std_logic;
    FIN             : out std_logic;
    NEXT_POS_GET    : in  std_logic_vector(12 downto 0);
    CURRENT_POS_GET : in  std_logic_vector(12 downto 0);
    CURRENT_POS_SET : out std_logic_vector(12 downto 0);
    LOAD            : out std_logic;
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
  type fsm_state is (init, idle, delete_current, write_new);
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
          next_state <= delete_current;
        else
          next_state <= idle;
        end if;
        
      when delete_current =>
        next_state <= write_new;
        
      when write_new =>
        next_state <= idle;

    end case;
  end process;

  process (current_state) is            -- output function
  begin  -- PROCESS
    case current_state is
      when init =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD            <= '0';
        ADDRESS         <= "00000000";
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '0';
        FIN_JEU         <= '0';

      when idle =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD            <= '0';
        ADDRESS         <= "00000000";
        DATA_W          <= "00000000";
        R_W             <= '0';
        EN_MEM          <= '0';
        FIN_JEU         <= '1';

      when delete_current =>
        FIN             <= '0';
        CURRENT_POS_SET <= "0000000000000";
        LOAD            <= '0';
        ADDRESS         <= CURRENT_POS_GET(12 downto 5);
        DATA_W          <= "01101101";
        R_W             <= '1';
        EN_MEM          <= '1';
        FIN_JEU         <= '0';

      when write_new =>
        FIN             <= '1';
        CURRENT_POS_SET <= NEXT_POS_GET;
        LOAD            <= '1';
        ADDRESS         <= NEXT_POS_GET(12 downto 5);
        DATA_W          <= "11100011";
        R_W             <= '1';
        EN_MEM          <= '1';
        FIN_JEU         <= '0';

    end case;
  end process;


end Behavioral;


