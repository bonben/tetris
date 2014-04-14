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
--use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2_1b is
  port (
    SEL_MUX : in  std_logic;
    BUS_0   : in  std_logic;
    BUS_1   : in  std_logic;
    BUS_OUT : out std_logic
    );
end mux_2_1b;

architecture Behavioral of mux_2_1b is

begin
  process (SEL_MUX, BUS_0, BUS_1) is
  begin  -- process
    if SEL_MUX = '0' then
      BUS_OUT <= BUS_0;
    else
      BUS_OUT <= BUS_1;
    end if;
  end process;

end Behavioral;

