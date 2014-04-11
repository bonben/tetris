----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:56 03/10/2014 
-- Design Name: 
-- Module Name:    memory - Behavioral 
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
use IEEE.NUMERIC_STD.all;

entity memory_cpu is
  port (enable_m_in : in  std_logic;
        r_w_in      : in  std_logic;
        address_in  : in  std_logic_vector (5 downto 0);
        memory_out  : out std_logic_vector (7 downto 0);
        memory_in   : in  std_logic_vector (7 downto 0);
        clock       : in  std_logic;
        reset       : in  std_logic;
        ce          : in  std_logic);
end memory_cpu;

architecture Behavioral of memory_cpu is

  type mem is array (0 to 63) of std_logic_vector(7 downto 0);  --  64 blocks of 8 bits

  -- Test
--  signal my_memory : mem := (x"08", x"47", x"86", x"C4", x"C4", x"00", x"00", x"7E",
--                             x"FE", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
--                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
--                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
--                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
--                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
--                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
--                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00");
  -- PGCD
  signal my_memory : mem := (x"11", x"15", x"52", x"54", x"C9", x"94", x"51", x"CD",
                             x"C0", x"13", x"52", x"95", x"C0", x"CD", x"00", x"00",
                             x"00", x"FF", x"01", x"00", x"28", x"18", x"00", x"00",
                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
                             x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00");

begin  -- Behavioral

  process (clock, reset) is
  begin  --Process
    if reset = '1' then
      memory_out <= "00000000";

    elsif clock'event and clock = '0' then  --Front descendant
      if ce = '1' then
        if enable_m_in = '1' then
          if r_w_in = '1' then              --ecriture
            my_memory(TO_INTEGER(unsigned(address_in))) <= memory_in;
          end if;
          memory_out <= my_memory(TO_INTEGER(unsigned(address_in)));
          
        end if;
      end if;
    end if;
  end process;
end Behavioral;

