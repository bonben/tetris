----------------------------------------------------------------------------------
--! @file
--! @brief Top level module
----------------------------------------------------------------------------------

--! Use standard library
library IEEE;
--! Use logic elements
use IEEE.STD_LOGIC_1164.all;

--! Entity of the top level module tetris.

entity tetris is
  port (RESET   : in  std_logic; --! Reset active high
        CLK100M : in  std_logic; --! 100 MHz clock
        HS      : out std_logic; --! Horizontal sync for VGA
        VS      : out std_logic; --! Vertical sync for VGA
        RGB     : out std_logic_vector(7 downto 0); --! RGB (323) for VGA
        HAUT    : in  std_logic; --! Up input button
        GAUCHE  : in  std_logic; --! Left input button
        BAS     : in  std_logic; --! Down input button
        DROITE  : in  std_logic; --! Right input Button
        CENTRE  : in  std_logic; --! Center input button
        AN      : out std_logic_vector(3 downto 0); --! Bus to light up one of the 4 digits of the 7 segments display
        SEG     : out std_logic_vector(7 downto 0)  --! Segments to light up
        );
end tetris;

--! @brief Standard architecture
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
  signal ce_lock_mem      : std_logic;
  signal en_mem_c         : std_logic;
  signal r_w_c            : std_logic;
  signal en_mem           : std_logic;
  signal r_w              : std_logic;
  signal fin_jeu          : std_logic;
  signal fin_score        : std_logic;
  signal score            : std_logic_vector(5 downto 0);


  component IP_clk is
    port
      (
        CLK_IN1  : in  std_logic;
        CLK_OUT1 : out std_logic
        );
  end component;

  component gestion_score
    port (
      RESET     : in  std_logic;
      CLK25M    : in  std_logic;
      CE100HZ   : in  std_logic;
      SCORE     : in  std_logic_vector(5 downto 0);
      FIN_JEU   : in  std_logic;
      FIN_SCORE : out std_logic;
      CENTER    : in  std_logic;
      AN        : out std_logic_vector(3 downto 0);
      SEG       : out std_logic_vector(7 downto 0)
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
          CE        : in  std_logic;
          R_W       : out std_logic;
          EN_MEM    : out std_logic;
          FIN_JEU   : out std_logic;
          FIN_SCORE : in  std_logic;
          SCORE     : out std_logic_vector(5 downto 0);
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

  ce_lock_mem <= not lock_mem;

  Clock_manager : IP_clk
    port map
    (
      CLK_IN1  => CLK100M,
      CLK_OUT1 => CLK25M);

  instance_gestion_score : gestion_score
    port map
    (
      RESET,
      CLK25M,
      ce100Hz,
      score,
      fin_jeu,
      fin_score,
      CENTRE,
      AN,
      SEG
      );

  instance_coeur : coeur
    port map
    (
      RESET,
      CLK25M,
      ce100Hz,
      ce_lock_mem,
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
      lock_mem,                         -- when lock, vga_controller
      en_mem_c,
      lock_mem,
      en_mem
      );

  mux_r_w : mux_2_1b
    port map (
      lock_mem,                         -- when lock, vga_controller
      r_w_c,
      ce_lock_mem,
      r_w
      );

  mux_address : mux_2_8b
    port map(
      lock_mem,                         -- when lock, vga_controller
      address_c,
      address_v,
      address
      );


end Behavioral;

