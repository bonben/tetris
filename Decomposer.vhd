----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:33:05 04/11/2014 
-- Design Name: 
-- Module Name:    Decomposer - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decomposer is
  port (
    CLOCK      : in  std_logic;
    RESET      : in  std_logic;
    NEW_SCORE  : in  std_logic_vector (13 downto 0);
    BEST_YOU   : in  std_logic;         -- 0 si BEST, 1 si YOU
    SCORE_TEXT : in  std_logic;         -- 0 si SCORE, 1 si TEXT
    MILLIEMES  : out std_logic_vector (3 downto 0);
    CENTAINES  : out std_logic_vector (3 downto 0);
    DIZAINES   : out std_logic_vector (3 downto 0);
    UNITES     : out std_logic_vector (3 downto 0));
end Decomposer;

architecture Behavioral of Decomposer is

subtype S16 is std_logic_vector(15 downto 0);

begin

  process(CLOCK, RESET) is
    
  begin
    if clock'event and clock = '1' then
      if reset = '1' then
        MILLIEMES <= "0000";
        CENTAINES <= "0000";
        DIZAINES  <= "0000";
        UNITES    <= "0000";
      else
        if SCORE_TEXT = '1' then
          if BEST_YOU = '0' then
            MILLIEMES <= x"B"; CENTAINES <= x"C"; DIZAINES <= x"5"; UNITES <= x"D";  -- bESt
          else
            MILLIEMES <= x"F"; CENTAINES <= x"4"; DIZAINES <= x"0"; UNITES <= x"E";  -- YOU
          end if;
        else
          case S16((resize(unsigned(NEW_SCORE),16))) is
            when x"0000" => MILLIEMES <= x"0"; CENTAINES <= x"0"; DIZAINES <= x"0"; UNITES <= x"0";
            when x"009F" => MILLIEMES <= x"0"; CENTAINES <= x"1"; DIZAINES <= x"5"; UNITES <= x"9";
            when x"013E" => MILLIEMES <= x"0"; CENTAINES <= x"3"; DIZAINES <= x"1"; UNITES <= x"8";
            when x"01DD" => MILLIEMES <= x"0"; CENTAINES <= x"4"; DIZAINES <= x"7"; UNITES <= x"7";
            when x"027C" => MILLIEMES <= x"0"; CENTAINES <= x"6"; DIZAINES <= x"3"; UNITES <= x"6";
            when x"031B" => MILLIEMES <= x"0"; CENTAINES <= x"7"; DIZAINES <= x"9"; UNITES <= x"5";
            when x"03BA" => MILLIEMES <= x"0"; CENTAINES <= x"9"; DIZAINES <= x"5"; UNITES <= x"4";
            when x"0459" => MILLIEMES <= x"1"; CENTAINES <= x"1"; DIZAINES <= x"1"; UNITES <= x"3";
            when x"04F8" => MILLIEMES <= x"1"; CENTAINES <= x"2"; DIZAINES <= x"7"; UNITES <= x"2";
            when x"0597" => MILLIEMES <= x"1"; CENTAINES <= x"4"; DIZAINES <= x"3"; UNITES <= x"1";
            when x"0636" => MILLIEMES <= x"1"; CENTAINES <= x"5"; DIZAINES <= x"9"; UNITES <= x"0";
            when x"06D5" => MILLIEMES <= x"1"; CENTAINES <= x"7"; DIZAINES <= x"4"; UNITES <= x"9";
            when x"0774" => MILLIEMES <= x"1"; CENTAINES <= x"9"; DIZAINES <= x"0"; UNITES <= x"8";
            when x"0813" => MILLIEMES <= x"2"; CENTAINES <= x"0"; DIZAINES <= x"6"; UNITES <= x"7";
            when x"08B2" => MILLIEMES <= x"2"; CENTAINES <= x"2"; DIZAINES <= x"2"; UNITES <= x"6";
            when x"0951" => MILLIEMES <= x"2"; CENTAINES <= x"3"; DIZAINES <= x"8"; UNITES <= x"5";
            when x"09F0" => MILLIEMES <= x"2"; CENTAINES <= x"5"; DIZAINES <= x"4"; UNITES <= x"4";
            when x"0A8F" => MILLIEMES <= x"2"; CENTAINES <= x"7"; DIZAINES <= x"0"; UNITES <= x"3";
            when x"0B2E" => MILLIEMES <= x"2"; CENTAINES <= x"8"; DIZAINES <= x"6"; UNITES <= x"2";
            when x"0BCD" => MILLIEMES <= x"3"; CENTAINES <= x"0"; DIZAINES <= x"2"; UNITES <= x"1";
            when x"0C6C" => MILLIEMES <= x"3"; CENTAINES <= x"1"; DIZAINES <= x"8"; UNITES <= x"0";
            when x"0D0B" => MILLIEMES <= x"3"; CENTAINES <= x"3"; DIZAINES <= x"3"; UNITES <= x"9";
            when x"0DAA" => MILLIEMES <= x"3"; CENTAINES <= x"4"; DIZAINES <= x"9"; UNITES <= x"8";
            when x"0E49" => MILLIEMES <= x"3"; CENTAINES <= x"6"; DIZAINES <= x"5"; UNITES <= x"7";
            when x"0EE8" => MILLIEMES <= x"3"; CENTAINES <= x"8"; DIZAINES <= x"1"; UNITES <= x"6";
            when x"0F87" => MILLIEMES <= x"3"; CENTAINES <= x"9"; DIZAINES <= x"7"; UNITES <= x"5";
            when x"1026" => MILLIEMES <= x"4"; CENTAINES <= x"1"; DIZAINES <= x"3"; UNITES <= x"4";
            when x"10C5" => MILLIEMES <= x"4"; CENTAINES <= x"2"; DIZAINES <= x"9"; UNITES <= x"3";
            when x"1164" => MILLIEMES <= x"4"; CENTAINES <= x"4"; DIZAINES <= x"5"; UNITES <= x"2";
            when x"1203" => MILLIEMES <= x"4"; CENTAINES <= x"6"; DIZAINES <= x"1"; UNITES <= x"1";
            when x"12A2" => MILLIEMES <= x"4"; CENTAINES <= x"7"; DIZAINES <= x"7"; UNITES <= x"0";
            when x"1341" => MILLIEMES <= x"4"; CENTAINES <= x"9"; DIZAINES <= x"2"; UNITES <= x"9";
            when x"13E0" => MILLIEMES <= x"5"; CENTAINES <= x"0"; DIZAINES <= x"8"; UNITES <= x"8";
            when x"147F" => MILLIEMES <= x"5"; CENTAINES <= x"2"; DIZAINES <= x"4"; UNITES <= x"7";
            when x"151E" => MILLIEMES <= x"5"; CENTAINES <= x"4"; DIZAINES <= x"0"; UNITES <= x"6";
            when x"15BD" => MILLIEMES <= x"5"; CENTAINES <= x"5"; DIZAINES <= x"6"; UNITES <= x"5";
            when x"165C" => MILLIEMES <= x"5"; CENTAINES <= x"7"; DIZAINES <= x"2"; UNITES <= x"4";
            when x"16FB" => MILLIEMES <= x"5"; CENTAINES <= x"8"; DIZAINES <= x"8"; UNITES <= x"3";
            when x"179A" => MILLIEMES <= x"6"; CENTAINES <= x"0"; DIZAINES <= x"4"; UNITES <= x"2";
            when x"1839" => MILLIEMES <= x"6"; CENTAINES <= x"2"; DIZAINES <= x"0"; UNITES <= x"1";
            when x"18D8" => MILLIEMES <= x"6"; CENTAINES <= x"3"; DIZAINES <= x"6"; UNITES <= x"0";
            when x"1977" => MILLIEMES <= x"6"; CENTAINES <= x"5"; DIZAINES <= x"1"; UNITES <= x"9";
            when x"1A16" => MILLIEMES <= x"6"; CENTAINES <= x"6"; DIZAINES <= x"7"; UNITES <= x"8";
            when x"1AB5" => MILLIEMES <= x"6"; CENTAINES <= x"8"; DIZAINES <= x"3"; UNITES <= x"7";
            when x"1B54" => MILLIEMES <= x"6"; CENTAINES <= x"9"; DIZAINES <= x"9"; UNITES <= x"6";
            when x"1BF3" => MILLIEMES <= x"7"; CENTAINES <= x"1"; DIZAINES <= x"5"; UNITES <= x"5";
            when x"1C92" => MILLIEMES <= x"7"; CENTAINES <= x"3"; DIZAINES <= x"1"; UNITES <= x"4";
            when x"1D31" => MILLIEMES <= x"7"; CENTAINES <= x"4"; DIZAINES <= x"7"; UNITES <= x"3";
            when x"1DD0" => MILLIEMES <= x"7"; CENTAINES <= x"6"; DIZAINES <= x"3"; UNITES <= x"2";
            when x"1E6F" => MILLIEMES <= x"7"; CENTAINES <= x"7"; DIZAINES <= x"9"; UNITES <= x"1";
            when x"1F0E" => MILLIEMES <= x"7"; CENTAINES <= x"9"; DIZAINES <= x"5"; UNITES <= x"0";
            when x"1FAD" => MILLIEMES <= x"8"; CENTAINES <= x"1"; DIZAINES <= x"0"; UNITES <= x"9";
            when x"204C" => MILLIEMES <= x"8"; CENTAINES <= x"2"; DIZAINES <= x"6"; UNITES <= x"8";
            when x"20EB" => MILLIEMES <= x"8"; CENTAINES <= x"4"; DIZAINES <= x"2"; UNITES <= x"7";
            when x"218A" => MILLIEMES <= x"8"; CENTAINES <= x"5"; DIZAINES <= x"8"; UNITES <= x"6";
            when x"2229" => MILLIEMES <= x"8"; CENTAINES <= x"7"; DIZAINES <= x"4"; UNITES <= x"5";
            when x"22C8" => MILLIEMES <= x"8"; CENTAINES <= x"9"; DIZAINES <= x"0"; UNITES <= x"4";
            when x"2367" => MILLIEMES <= x"9"; CENTAINES <= x"0"; DIZAINES <= x"6"; UNITES <= x"3";
            when x"2406" => MILLIEMES <= x"9"; CENTAINES <= x"2"; DIZAINES <= x"2"; UNITES <= x"2";
            when x"24A5" => MILLIEMES <= x"9"; CENTAINES <= x"3"; DIZAINES <= x"8"; UNITES <= x"1";
            when x"2544" => MILLIEMES <= x"9"; CENTAINES <= x"5"; DIZAINES <= x"4"; UNITES <= x"0";
            when x"25E3" => MILLIEMES <= x"9"; CENTAINES <= x"6"; DIZAINES <= x"9"; UNITES <= x"9";
            when x"2682" => MILLIEMES <= x"9"; CENTAINES <= x"8"; DIZAINES <= x"5"; UNITES <= x"8";
            when x"270F" => MILLIEMES <= x"9"; CENTAINES <= x"9"; DIZAINES <= x"9"; UNITES <= x"9";

            when others => MILLIEMES <= x"F"; CENTAINES <= x"F"; DIZAINES <= x"F"; UNITES <= x"F";
          end case;
        end if;
      end if;
    end if;
  end process;
end Behavioral;

