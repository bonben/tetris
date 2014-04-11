----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:50 03/10/2014 
-- Design Name: 
-- Module Name:    reg_8b - Behavioral 
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

entity reg_8b is
  port (load_in    : in  std_logic;
        bus_8b_out : out std_logic_vector (7 downto 0);
        bus_8b_in  : in  std_logic_vector (7 downto 0);
        clock      : in  std_logic;
        reset      : in  std_logic;
        ce         : in  std_logic
        );
end reg_8b;

architecture Behavioral of reg_8b is
begin  -- Behavioral

  process (clock, reset) is
  begin  --Process
    if reset = '1' then
      bus_8b_out <= "00000000";
    end if;
    if clock'event and clock = '1' then
      if ce = '1' then
        if load_in = '1' then
          bus_8b_out <= bus_8b_in;
        end if;
      end if;
    end if;
  end process;
end Behavioral;



