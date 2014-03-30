----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:10:12 02/19/2013 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux_4_8b is
  port (
    SEL_MUX : in  std_logic_vector(1 downto 0);
    BUS_0   : in  std_logic_vector(7 downto 0);
    BUS_1   : in  std_logic_vector(7 downto 0);
    BUS_2   : in  std_logic_vector(7 downto 0);
    BUS_3   : in  std_logic_vector(7 downto 0);
    BUS_OUT : out std_logic_vector(7 downto 0)
    );
end mux_4_8b;

architecture Behavioral of mux_4_8b is

begin
  process (SEL_MUX, BUS_0, BUS_1, BUS_2, BUS_3) is
  begin  -- process
    case SEL_MUX is
      when "00"  => BUS_OUT <= BUS_0;
      when "01"  => BUS_OUT <= BUS_1;
      when "10"  => BUS_OUT <= BUS_2;
      when "11"  => BUS_OUT <= BUS_3;
      when others => BUS_OUT <= BUS_3;
    end case;
    
  end process;

end Behavioral;

