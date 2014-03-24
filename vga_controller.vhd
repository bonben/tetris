----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:52:15 02/14/2013 
-- Design Name: 
-- Module Name:   vga_controller - Behavioral 
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
-- Deliver numbers from 1 to 49
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_controller is
  
  port (
    clk25M   : in    std_logic;         -- 25 MHz clock
    reset    : in    std_logic;
    HS       : out   std_logic;         -- horizontal synch
    VS       : out   std_logic;         -- vertical synch
    MEM      : in    std_logic_vector(7 downto 0);
    ADDRESS  : inout std_logic_vector(7 downto 0);
    RGB      : out   std_logic_vector(7 downto 0);
    LOCK_MEM : out   std_logic
    );
end entity vga_controller;




architecture RTL of vga_controller is

  signal hcounter         : unsigned(9 downto 0) := "0000000000";  -- horizontal counter
  signal vcounter         : unsigned(9 downto 0) := "0000000000";  -- vertical counter
  signal vcountenable     : std_logic            := '0';  -- vertical counter count enable
  signal vlastcountenable : std_logic            := '0';  -- vertical count enable last clock cycle
  signal hsdelay          : std_logic            := '0';  -- artificail signal to sycnhronize h and v pulse
  signal hsdelay2         : std_logic            := '0';  -- artificail signal to sycnhronize h and v pulse
  signal rgb_sig          : std_logic_vector(7 downto 0);  -- signal à maintenir dans un  registre.
  


begin  -- architecture RTL


  
  process (clk25M, reset) is
  begin  -- process


    if clk25M'event and clk25M = '1' then  -- rising clock edge
      if reset = '1' then                  -- asynchronous reset (active low)
        HS               <= '0';
        VS               <= '0';
        rgb_sig          <= "00000000";
        hcounter         <= "0000000000";
        vcounter         <= "0000000000";
        vcountenable     <= '0';
        vlastcountenable <= '0';
        ADDRESS          <= "00000000";
        LOCK_MEM         <= '0';
      else
        if hcounter < 799 then             -- compte 800 cycles d'horloges
          hcounter <= hcounter+1;
        else
          hcounter <= "0000000000";
        end if;

        if hcounter = 0 then
          hsdelay      <= '0';
          vcountenable <= '1';
        end if;
        if hcounter = 96 then
          hsdelay      <= '1';
          vcountenable <= '0';
        end if;
        hsdelay2         <= hsdelay;
        HS               <= hsdelay2;
        vlastcountenable <= vcountenable;
        if vlastcountenable = '0' and vcountenable = '1' then
          if vcounter < 520 then        --compte 521
            vcounter <= vcounter + 1;
          else
            vcounter <= "0000000000";
          end if;
        end if;

        if vcounter = 0 then
          VS <= '0';
        end if;
        if vcounter = 2 then
          VS <= '1';
        end if;
-- loading rgb
        if hcounter >= 343 and hcounter <= 582 then  -- tetris zone on the screen
          if((hcounter-343) mod 24) = 0 then    -- if new square
            LOCK_MEM <= '1';            -- first : lock memory
          elsif((hcounter-344) mod 24) = 0 then      -- second : load pixel
            rgb_sig  <= MEM;
            ADDRESS  <= ADDRESS + 1;    -- increment address
            LOCK_MEM <= '0';
          end if;
        elsif hcounter = 584 then       -- end tetris zone
          rgb_sig <= "00000000";
          if vcounter >= 7 and vcounter < 487 then
              -- if the next pixel line is not a new tetris line
            if not((vcounter >= 30) and (((vcounter - 30) mod 24) = 0)) then
              ADDRESS <= ADDRESS - 10;
            end if;
          else
            ADDRESS <= "00000000"; -- outside the tetris value, reset ADDRESS
          end if;
          
        end if;
      end if;
    end if;
  end process;

  RGB <= rgb_sig;
  
end architecture RTL;



