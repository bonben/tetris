----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:19 03/18/2014 
-- Design Name: 
-- Module Name:    mux_digit - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_digit is
    Port ( MIL  : in  STD_LOGIC_VECTOR (3 downto 0);
           CENT : in  STD_LOGIC_VECTOR (3 downto 0);
           DIZ : in  STD_LOGIC_VECTOR (3 downto 0);
           UNI : in  STD_LOGIC_VECTOR (3 downto 0);
           DIGIT_ACTIF : in  STD_LOGIC_VECTOR(3 downto 0);
           CHIFFRE : out  STD_LOGIC_VECTOR (3 downto 0));
end mux_digit;

architecture Behavioral of mux_digit is

signal chiffre_sig : std_logic_vector(3 downto 0);

begin
process (DIGIT_ACTIF,UNI,DIZ,CENT,MIL) is
	begin
		case (DIGIT_ACTIF) is 
			when "0001" =>
				chiffre_sig <= UNI;
			when "0010" =>
				chiffre_sig <= DIZ;
			when "0100" =>
				chiffre_sig <= CENT;
			when "1000" =>
				chiffre_sig <= MIL;
			when others =>
				chiffre_sig <= "1111";
		end case;
end process;

CHIFFRE <= chiffre_sig;

end Behavioral;

