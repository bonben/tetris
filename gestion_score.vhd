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

entity gestion_score is
  port (RESET     : in  std_logic;
        CLK25M    : in  std_logic;
        CE100HZ   : in  std_logic;
        SCORE     : in  std_logic_vector(5 downto 0);
        FIN_JEU   : in  std_logic;
        FIN_SCORE : out std_logic;
        CENTER    : in  std_logic;
        AN        : out std_logic_vector(3 downto 0);
        SEG       : out std_logic_vector(7 downto 0)
        );
end gestion_score;

architecture Behavioral of gestion_score is

  component fsm_score is
    port (
      clock      : in  std_logic;
      reset      : in  std_logic;
      ce100Hz    : in  std_logic;
      mux_mem    : out std_logic;       -- 1 : CPU
      -- 0 : Score
      center     : in  std_logic;
      deb_score  : in  std_logic;
      fin_score  : out std_logic;
      score      : in  std_logic_vector(5 downto 0);
      data_w     : out std_logic_vector(7 downto 0);
      data_r     : in  std_logic_vector(7 downto 0);
      en_mem     : out std_logic;
      r_w        : out std_logic;
      address    : out std_logic_vector(5 downto 0);
      score_disp : out std_logic_vector(5 downto 0);
      best_you   : out std_logic;
      score_text : out std_logic
      );
  end component;

  component mux_2_6b is
    port (
      SEL_MUX : in  std_logic;
      BUS_0   : in  std_logic_vector(5 downto 0);
      BUS_1   : in  std_logic_vector(5 downto 0);
      BUS_OUT : out std_logic_vector(5 downto 0)
      );
  end component;

  component mux_2_8b is
    port (
      SEL_MUX : in  std_logic;
      BUS_0   : in  std_logic_vector(7 downto 0);
      BUS_1   : in  std_logic_vector(7 downto 0);
      BUS_OUT : out std_logic_vector(7 downto 0)
      );
  end component;

  component mux_2_1b is
    port (
      SEL_MUX : in  std_logic;
      BUS_0   : in  std_logic;
      BUS_1   : in  std_logic;
      BUS_OUT : out std_logic
      );
  end component;


begin



  mux_address : mux_2_8b
    port map(
      lock_mem,                         -- when lock, vga_controller
      address_c,
      address_v,
      address
      );


end Behavioral;

