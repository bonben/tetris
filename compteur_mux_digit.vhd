----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:51:23 03/18/2014 
-- Design Name: 
-- Module Name:    compteur_mux_digit - Behavioral 
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

entity compteur_mux_digit is
    Port ( H_MUX_ACTIF : in  STD_LOGIC;
           DIGIT_ACTIF : out  STD_LOGIC_VECTOR (3 downto 0));
end compteur_mux_digit;

architecture Behavioral of compteur_mux_digit is

signal digit_sig : std_logic_vector(3 downto 0) := "0001";

begin
process (H_MUX_ACTIF) is
	begin
		if H_MUX_ACTIF='1' and H_MUX_ACTIF'event then
			case (digit_sig) is 
				when "0001" =>
					digit_sig <= "0010";
				when "0010" =>
					digit_sig <= "0100";
				when "0100" =>
					digit_sig <= "1000";
				when "1000" =>
					digit_sig <= "0001";
				when others =>
					digit_sig <= "0000";
			end case;
		end if;
end process;

DIGIT_ACTIF <= digit_sig;

end Behavioral;

