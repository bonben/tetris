----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:44 03/18/2014 
-- Design Name: 
-- Module Name:    allumage_digit - Behavioral 
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

entity allumage_digit is
    Port ( DIGIT_ACTIF : in  STD_LOGIC_VECTOR (3 downto 0);
			  ALLUM_MIL : out STD_LOGIC;
           ALLUM_CENT : out  STD_LOGIC;
           ALLUM_DIZ : out  STD_LOGIC;
           ALLUM_UNI : out  STD_LOGIC);
end allumage_digit;

architecture Behavioral of allumage_digit is


signal cent_sig, diz_sig, uni_sig, mil_sig : std_logic;

begin
process (DIGIT_ACTIF) is
	begin
		case(DIGIT_ACTIF) is
			when "0001" =>
					mil_sig <=  '1';
					cent_sig <= '1';
					diz_sig <=  '1';
					uni_sig <=  '0';
			when "0010" =>
					mil_sig <=  '1';
					cent_sig <= '1';
					diz_sig <=  '0';
					uni_sig <=  '1';
			when "0100" =>
					mil_sig <=  '1';
					cent_sig <= '0';
					diz_sig <=  '1';
					uni_sig <=  '1';
			when "1000" =>
					mil_sig <=  '0';
					cent_sig <= '1';
					diz_sig <=  '1';
					uni_sig <=  '1';
			when others =>
					mil_sig <=  '1';
					cent_sig <= '1';
					diz_sig <=  '1';
					uni_sig <=  '1';
		end case;
end process;

ALLUM_MIL <= mil_sig;
ALLUM_CENT <= cent_sig;
ALLUM_DIZ <= diz_sig;
ALLUM_UNI <= uni_sig;


end Behavioral;

