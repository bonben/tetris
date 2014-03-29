----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:56 03/10/2014 
-- Design Name: 
-- Module Name:    memory - Behavioral 
-- Project Name: 
-- Target DeviCEs: 
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
--use IEEE.NUMERIC_STD.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;


entity memory is
  port (EN_MEM     : in  std_logic;
        R_W        : in  std_logic;
        ADDRESS    : in  std_logic_vector (7 downto 0);
        MEMORY_OUT : out std_logic_vector (7 downto 0);
        MEMORY_IN  : in  std_logic_vector (7 downto 0);
        CLOCK      : in  std_logic);

end memory;

architecture Behavioral of memory is



  type mem is array(0 to 255) of bit_vector(7 downto 0);

  impure function init_ram (ram_file_name : in string) return mem is
    file ram_file      : text is in ram_file_name;
    variable line_name : line;
    variable my_memory : mem;
  begin
    for I in mem'range loop
      readline (ram_file, line_name);
      read (line_name, my_memory(I));
    end loop;
    return my_memory;
  end function;

  signal my_memory : mem := init_ram("tetris.ram");


begin

  process (CLOCK)
  begin
    if CLOCK'event and CLOCK = '0' then
      if EN_MEM = '1' then
        if R_W = '1' then
          my_memory(conv_integer(ADDRESS)) <= to_bitvector(MEMORY_IN);
        end if;
        MEMORY_OUT <= to_stdlogicvector(my_memory(conv_integer(ADDRESS)));
      end if;
    end if;
  end process;

end Behavioral;





