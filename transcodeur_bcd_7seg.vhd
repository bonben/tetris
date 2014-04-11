----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:38:26 03/18/2014 
-- Design Name: 
-- Module Name:    transcodeur_bcd_7seg - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity transcodeur_bcd_7seg is
  port (CHIFFRE   : in  std_logic_vector (3 downto 0);
         DEF_7SEG : out std_logic_vector (7 downto 0));
end transcodeur_bcd_7seg;

architecture Behavioral of transcodeur_bcd_7seg is
begin
  process (CHIFFRE)
  begin
    
    case CHIFFRE is
      --                           .gfedcba
      when "0000" => DEF_7SEG <= "11000000";  -- 0
      when "0001" => DEF_7SEG <= "11111001";  -- 1
      when "0010" => DEF_7SEG <= "10100100";  -- 2                                          a
      when "0011" => DEF_7SEG <= "10110000";  -- 3                                    ___
      when "0100" => DEF_7SEG <= "10011001";  -- 4 / Y                             f |     | b
      when "0101" => DEF_7SEG <= "10010010";  -- 5 / S                                ---  g  
      when "0110" => DEF_7SEG <= "10000010";  -- 6                                 e |___| c  .
      when "0111" => DEF_7SEG <= "11111000";  -- 7                                          d
      when "1000" => DEF_7SEG <= "10000000";  -- 8
      when "1001" => DEF_7SEG <= "10010000";  -- 9
      when "1010" => DEF_7SEG <= "10111111";  -- -
      when "1011" => DEF_7SEG <= "10000011";  -- b
      when "1100" => DEF_7SEG <= "10000110";  -- E
      when "1101" => DEF_7SEG <= "10000111";  -- t
      when "1110" => DEF_7SEG <= "11000001";  -- U
      when "1111" => DEF_7SEG <= "01111111";  -- .
      when others => DEF_7SEG <= "11111111";  -- -
                                   
    end case;
  end process;
end Behavioral;

