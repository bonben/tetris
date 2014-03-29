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
  port (RESET   : in  std_logic;
        CLK100M : in  std_logic;
        HS      : out std_logic;
        VS      : out std_logic;
        RGB     : out std_logic_vector(7 downto 0);
        HAUT    : in  std_logic;
        GAUCHE  : in  std_logic;
        BAS     : in  std_logic;
        DROITE  : in  std_logic
        );
end tetris;

architecture Behavioral of tetris is

  signal clk25M           : std_logic;
  signal ce100Hz          : std_logic;
  signal haut_debounced   : std_logic;
  signal gauche_debounced : std_logic;
  signal droite_debounced : std_logic;
  signal bas_debounced    : std_logic;
  signal address          : std_logic_vector(7 downto 0);
  signal address_c        : std_logic_vector(7 downto 0);
  signal address_v        : std_logic_vector(7 downto 0);
  signal memory_out       : std_logic_vector(7 downto 0);
  signal memory_in        : std_logic_vector(7 downto 0);
  signal lock_mem         : std_logic;
  signal en_mem_c         : std_logic;
  signal r_w_c            : std_logic;
  signal en_mem           : std_logic;
  signal r_w              : std_logic;
  signal fin_jeu          : std_logic;
  signal fin_score        : std_logic;
  signal score            : std_logic_vector(13 downto 0);


  component IP_clk is
    port
      (
        CLK_IN1  : in  std_logic;
        CLK_OUT1 : out std_logic
        );
  end component;

  component cadenceur is
    port (
      clk25M  : in  std_logic;
      reset   : in  std_logic;
      ce100Hz : out std_logic
      );        
  end component;

  component debounce is
    port(pb, clk25M, ce100Hz : in  std_logic;
         pb_debounced        : out std_logic);
  end component;


  component coeur is
    port (RESET     : in  std_logic;
          CLK25M    : in  std_logic;
          CE_100Hz  : in  std_logic;
          LOCK_MEM  : in  std_logic;
          R_W       : out std_logic;
          EN_MEM    : out std_logic;
          FIN_JEU   : out std_logic;
          FIN_SCORE : in  std_logic;
          SCORE     : out std_logic_vector(13 downto 0);
          ADDRESS   : out std_logic_vector(7 downto 0);
          DATA_R    : in  std_logic_vector(7 downto 0);
          DATA_W    : out std_logic_vector(7 downto 0);
          GAUCHE    : in  std_logic;
          DROITE    : in  std_logic;
          HAUT      : in  std_logic;
          BAS       : in  std_logic
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

  Clock_manager : IP_clk
    port map
    (
      CLK_IN1  => CLK100M,
      CLK_OUT1 => CLK25M);

  instance_coeur : coeur
    port map
    (
      RESET,
      CLK25M,
      ce100Hz,
      lock_mem,
      r_w_c,
      en_mem_c,
      fin_jeu,
      fin_score,
      score,
      address_c,
      memory_out,
      memory_in,
      gauche_debounced,
      droite_debounced,
      haut_debounced,
      bas_debounced
      );

  instance_cadenceur : cadenceur
    port map(
      clk25M,
      reset,
      ce100Hz
      );

  debounce_gauche : debounce
    port map
    (
      GAUCHE,
      clk25M,
      ce100Hz,
      gauche_debounced
      );

  debounce_droite : debounce
    port map
    (
      DROITE,
      clk25M,
      ce100Hz,
      droite_debounced
      );

  debounce_haut : debounce
    port map
    (
      HAUT,
      clk25M,
      ce100Hz,
      haut_debounced
      );

  debounce_bas : debounce
    port map
    (
      BAS,
      clk25M,
      ce100Hz,
      bas_debounced
      );

  instance_memory : memory
    port map (
      en_mem,
      r_w,
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
      address_v,
      RGB,
      lock_mem
      );


  
  mux_en_mem : mux_2_1b
    port map (
      lock_mem,
      lock_mem,
      en_mem_c,
      en_mem
      );

  mux_r_w : mux_2_1b
    port map (
      lock_mem,
      not lock_mem,
      r_w_c,
      r_w
      );

  mux_address : mux_2_8b
    port map(
      lock_mem,
      address_v,
      address_c,
      address
      );


end Behavioral;

