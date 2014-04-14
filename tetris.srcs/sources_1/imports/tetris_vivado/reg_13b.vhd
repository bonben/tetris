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

entity reg_13b is
  port (LOAD    : in  std_logic;
        BUS_OUT : out std_logic_vector (12 downto 0);
        BUS_IN  : in  std_logic_vector (12 downto 0);
        clock   : in  std_logic;
        reset   : in  std_logic;
        CE      : in  std_logic
        );
end reg_13b;

architecture Behavioral of reg_13b is
begin  -- Behavioral

  process (clock, reset) is
  begin  --Process
    
    if clock'event and clock = '1' then
      if reset = '1' then
        BUS_OUT <= "0000000000000";
      elsif CE = '1' then
        if LOAD = '1' then
          BUS_OUT <= BUS_IN;
        end if;
      end if;
    end if;
  end process;
end Behavioral;



