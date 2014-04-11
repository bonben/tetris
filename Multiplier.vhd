----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:03:51 04/07/2014 
-- Design Name: 
-- Module Name:    Multiplier - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplier is
    Port ( score : in  STD_LOGIC_VECTOR(5 DOWNTO 0);
           new_score : out  STD_LOGIC_VECTOR(13 DOWNTO 0));
end Multiplier;

architecture Behavioral of Multiplier is

begin

Process(score)
	variable operande : unsigned (8 downto 0):= "010011111"; --159
	
	begin
		if score = "111111" then -- 63
		new_score <= "10011100001111";
	
		else
		new_score <= std_logic_vector(resize(unsigned(score) * operande, 14));

		end if;
	end process;
end Behavioral;

