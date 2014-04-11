----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:42 03/10/2014 
-- Design Name: 
-- Module Name:    ff - Behavioral 
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

entity ff is
  port (carry_in   : in  std_logic;
        carry_out  : out std_logic;
        load_ff_in : in  std_logic;
        init_ff_in : in  std_logic;
        ce         : in  std_logic;     -- clock enable
        clock      : in  std_logic;
        reset      : in  std_logic);
end ff;

architecture Behavioral of ff is


begin  -- Behavioral

  process (clock, reset) is
  begin  --Process
    if reset = '1'then
      carry_out <= '0';
    elsif clock'event and clock = '1' then
      if ce = '1' then
        if init_ff_in = '1' then
          carry_out <= '0';
        elsif load_ff_in = '1' then
          carry_out <= carry_in;
        end if;
      end if;
    end if;
  end process;
end Behavioral;

