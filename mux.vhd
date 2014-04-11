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

entity mux is
  port (
    sel_mux     : in  std_logic;
    bus_cpt_mux : in  std_logic_vector(5 downto 0);
    bus_reg_mux : in  std_logic_vector(5 downto 0);
    bus_mux_out : out std_logic_vector(5 downto 0)
    );
end mux;

architecture Behavioral of mux is

begin
  process (bus_cpt_mux, bus_reg_mux, sel_mux) is
  begin  -- process
    if sel_mux = '0' then
      bus_mux_out <= bus_cpt_mux;
    else
      bus_mux_out <= bus_reg_mux;
    end if;
    
  end process;

end Behavioral;

