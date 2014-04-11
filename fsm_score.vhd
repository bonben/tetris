----------------------------------------------------------------------------------
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_score is
  port (
    clock      : in  std_logic;
    reset      : in  std_logic;
    ce100Hz    : in  std_logic;
    mux_mem    : out std_logic;         -- 1 : CPU
                                     -- 0 : Score
    center     : in  std_logic;
    deb_score  : in  std_logic;
    fin_score  : out std_logic;
    score      : in  std_logic_vector(5 downto 0);
    data_w     : out std_logic_vector(7 downto 0);
    data_r     : in  std_logic_vector(7 downto 0);
    en_mem     : out std_logic;
    r_w        : out std_logic;
    address    : out std_logic_vector(5 downto 0);
    score_disp : out std_logic_vector(5 downto 0);
    best_you   : out std_logic;
    score_text : out std_logic

    );
end fsm_score;

architecture Behavioral of fsm_score is

  type fsm_state is (init, write_score, init_cpu, you, score_you, best, score_best, fin_score_state);
  signal next_state, current_state : fsm_state;
  signal alt_disp                  : std_logic_vector(6 downto 0);
begin

  process(clock, reset) is
  begin
    if clock'event and clock = '1' then  -- rising clock edge
      if reset = '1' then                -- asynchronous reset (active low)
        alt_disp <= "0000000";
      end if;
      if ce100Hz = '1' then
        if alt_disp >= "1100100" then
          alt_disp <= "0000000";
        else
          alt_disp <= alt_disp + 1;
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
        if ce100Hz = '1' then
          current_state <= next_state;
        end if;
      end if;
    end if;
  end process;

  process (current_state, deb_score, center, alt_disp) is  -- ???
  begin  -- PROCESS
    case current_state is               -- next state function
      when init =>
        if deb_score = '1' then
          next_state <= write_score;
        else
          next_state <= init;
        end if;

      when write_score => next_state <= init_cpu;

      when init_cpu => next_state <= you;

      when you =>
        if center = '1' then
          next_state <= fin_score_state;
        elsif alt_disp = 0 then
          next_state <= score_you;
        else
          next_state <= you;
        end if;

      when score_you =>
        if center = '1' then
          next_state <= fin_score_state;
        elsif alt_disp = 0 then
          next_state <= best;
        else
          next_state <= score_you;
        end if;

      when best =>
        if center = '1' then
          next_state <= fin_score_state;
        elsif alt_disp = 0 then
          next_state <= score_best;
        else
          next_state <= best;
        end if;

      when score_best =>
        if center = '1' then
          next_state <= fin_score_state;
        elsif alt_disp = 0 then
          next_state <= you;
        else
          next_state <= score_best;
        end if;

      when fin_score_state => next_state <= init;

    end case;
  end process;

  process (current_state) is            -- output function
  begin  -- PROCESS
    case current_state is
      
      when init =>
        mux_mem    <= '0';
        fin_score  <= '0';
        data_w     <= "00000000";
        en_mem     <= '0';
        r_w        <= '0';
        address    <= "000000";
        score_disp <= "000000";
        best_you   <= '0';
        score_text <= '0';

      when write_score =>
        mux_mem            <= '0';
        fin_score          <= '0';
        data_w(7 downto 6) <= "00";
        data_w(5 downto 0) <= score;
        en_mem             <= '1';
        r_w                <= '1';
        address            <= "001100";
        score_disp         <= "000000";
        best_you           <= '0';
        score_text         <= '0';

      when init_cpu =>
        mux_mem    <= '1';
        fin_score  <= '0';
        data_w     <= "00000000";
        en_mem     <= '0';
        r_w        <= '0';
        address    <= "000000";
        score_disp <= "000000";
        best_you   <= '0';
        score_text <= '0';

      when you =>
        mux_mem    <= '0';
        fin_score  <= '0';
        data_w     <= "00000000";
        en_mem     <= '0';
        r_w        <= '0';
        address    <= "000000";
        score_disp <= "000000";
        best_you   <= '1';
        score_text <= '1';

      when score_you =>
        mux_mem    <= '0';
        fin_score  <= '0';
        data_w     <= "00000000";
        en_mem     <= '0';
        r_w        <= '0';
        address    <= "000000";
        score_disp <= "000000";
        best_you   <= '0';
        score_text <= '0';

      when best =>
        mux_mem    <= '0';
        fin_score  <= '0';
        data_w     <= "00000000";
        en_mem     <= '0';
        r_w        <= '0';
        address    <= "000000";
        score_disp <= "000000";
        best_you   <= '1';
        score_text <= '1';

      when score_best =>
        mux_mem    <= '0';
        fin_score  <= '0';
        data_w     <= "00000000";
        en_mem     <= '1';
        r_w        <= '0';
        address    <= "001101";
        score_disp <= data_r(5 downto 0);
        best_you   <= '0';
        score_text <= '0';

      when fin_score_state =>
        mux_mem    <= '0';
        fin_score  <= '1';
        data_w     <= "00000000";
        en_mem     <= '0';
        r_w        <= '0';
        address    <= "000000";
        score_disp <= "000000";
        best_you   <= '0';
        score_text <= '0';


        
    end case;
  end process;
end Behavioral;
