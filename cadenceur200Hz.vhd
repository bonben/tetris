----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:52:15 02/14/2013 
-- Design Name: 
-- Module Name:    cadenceur 100Hz - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cadenceur200Hz is
  port (
    clk25M  : in  std_logic;
    reset   : in  std_logic;
    ce200Hz : out std_logic
    );         
end cadenceur200Hz;

architecture Behavioral of cadenceur200Hz is

  signal internal_count : std_logic_vector(17 downto 0);

begin

  process (clk25M, reset)
  begin

    if clk25M'event and clk25M = '1' then        -- rising clock edge
      if reset = '1' then               -- asynchronous reset (active low)
        internal_count <= "000000000000000000";  -- initialization to zero
        ce200Hz        <= '0';
      elsif internal_count = 125000 then         -- implementation
      --elsif internal_count = 25 then    -- simulation
        internal_count <= "000000000000000000";  -- initialization to zero
        ce200Hz        <= '1';
      else
        internal_count <= internal_count + 1;
        ce200Hz        <= '0';
      end if;

    end if;
    
  end process;

end Behavioral;

