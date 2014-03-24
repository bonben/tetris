----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:00 02/15/2011 
-- Design Name: 
-- Module Name:    CPU_8bits - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tetris is
  port (RESET   : in std_logic;
        CLK100M : in std_logic;
        HS      : out   std_logic;
        VS      : out   std_logic;
        RGB     : out   std_logic_vector(7 downto 0)
        );
end tetris;

architecture Behavioral of tetris is

  signal clk25M     : std_logic;
  signal address    : std_logic_vector(7 downto 0);
  signal memory_out : std_logic_vector(7 downto 0);
  signal memory_in  : std_logic_vector(7 downto 0);
  signal lock_mem   : std_logic;

  component IP_clk
    port
      (
        CLK_IN1  : in  std_logic;
        CLK_OUT1 : out std_logic
        );
  end component;

  component memory is
    port (EN_MEM     : in  std_logic;
          R_W        : in  std_logic;
          ADDRESS    : in  std_logic_vector (7 downto 0);
          MEMORY_OUT : out std_logic_vector (7 downto 0);
          MEMORY_IN  : in  std_logic_vector (7 downto 0);
          CLOCK      : in  std_logic);
  end component;

  component vga_controller is
    port (
      CLK25M   : in    std_logic;       -- 25 MHz clock
      RESET    : in    std_logic;
      HS       : out   std_logic;       -- horizontal synch
      VS       : out   std_logic;       -- vertical synch
      MEM      : in    std_logic_vector(7 downto 0);
      ADDRESS  : inout std_logic_vector(7 downto 0);
      RGB      : out   std_logic_vector(7 downto 0);
      LOCK_MEM : out   std_logic
      );
  end component;
  
begin

  Clock_manager : IP_clk
    port map
    (
      CLK_IN1  => CLK100M,
      CLK_OUT1 => CLK25M);

  instance_memory : memory
    port map (
      lock_mem,
      not lock_mem,
      address,
      memory_out,
      memory_in,
      clk25M);

  instance_vga_controller : vga_controller
    port map (
      clk25M,
      RESET,
      HS,
      VS,
      memory_out,
      address,
      RGB,
      lock_mem
      );

end Behavioral;

