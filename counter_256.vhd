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

entity counter_256 is
  port (
    clock       : in  std_logic;
    reset       : in  std_logic;        -- asynchronous reset (active low)
    load_cpt    : in  std_logic;
    incr_cpt    : in  std_logic;
    decr_cpt    : in  std_logic;
    init_cpt    : in  std_logic;
    bus_cpt_in  : in  std_logic_vector(7 downto 0);
    bus_cpt_out : out std_logic_vector(7 downto 0);
    CE          : in  std_logic
    );
end counter_256;

architecture Behavioral of counter_256 is

  signal counter : unsigned(7 downto 0) := "00000000";
  
begin

  process (clock, reset) is                 -- register
  begin  -- PROCESS
    if reset = '1' then                     -- asynchronous reset (active low)
      counter <= "00000000";
    elsif clock'event and clock = '1' then  -- rising clock edge
      if ce = '1' then
        if init_cpt = '1' then
          counter <= "00000000";
        elsif load_cpt = '1' then
          counter <= unsigned(bus_cpt_in);
        elsif incr_cpt = '1' then
          counter <= counter + 1;
        elsif decr_cpt = '1' then
          counter <= counter - 1;
        end if;
      end if;
    end if;
  end process;

  bus_cpt_out <= std_logic_vector(counter);

end Behavioral;

