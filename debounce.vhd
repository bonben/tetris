library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Debounce Pushbutton: Filters out mechanical switch bounce for around 40Ms.
entity debounce is
  port(pb, clock_100Hz : in  std_logic;
       pb_debounced    : out std_logic);
end debounce;

architecture a of debounce is
  signal SHIFT_PB : std_logic_vector(3 downto 0);
begin

  -- Debounce clock should be approximately 10ms or 100Hz
  process
  begin
    wait until (clock_100Hz'event) and (clock_100Hz = '1');
    -- Use a shift register to filter switch contact bounce
    SHIFT_PB(2 downto 0) <= SHIFT_PB(3 downto 1);
    SHIFT_PB(3)          <= not PB;
    if SHIFT_PB(3 downto 0) = "0000" then
      PB_DEBOUNCED <= '1';
    else
      PB_DEBOUNCED <= '0';
    end if;
  end process;
end a;

