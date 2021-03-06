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

entity coeur is
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
end coeur;

architecture Behavioral of coeur is

  signal fsm_ready, chute, rot, decal, sens, deb_rot, fin_rot, deb_decal, fin_decal, deb_chute, fin_chute, deb_refresh, fin_refresh, load_decal, load_chute, load_rot, load_next_pos, load_current_pos, en_mem_rot, r_w_rot, en_mem_chute, r_w_chute, en_mem_refresh, r_w_refresh, en_mem_decal, r_w_decal, load_counter, incr_counter, decr_counter, init_counter, load_register, ff_read, load_ff, init_ff, incr_score, init_score : std_logic;

  signal current_pos_get, current_pos_set, next_pos_get, next_pos_set, next_pos_decal, next_pos_rot, next_pos_chute : std_logic_vector(12 downto 0);

  signal address_decal, address_chute, address_rot, address_refresh, counter_r, counter_w, register_r, register_w : std_logic_vector(7 downto 0);

  signal score_temp : std_logic_vector(5 downto 0);
  
  signal sel_mux : std_logic_vector(1 downto 0);

  component counter64 is
    port (
      clock           : in  std_logic;
      reset           : in  std_logic;  -- asynchronous reset (active low)
      incr_counter    : in  std_logic;
      init_counter    : in  std_logic;
      bus_counter_out : out std_logic_vector(5 downto 0);
      ce              : in  std_logic
      );
  end component;

  component ffnewpiece is
    port (
      carry_out  : out std_logic;
      load_ff_in : in  std_logic;
      init_ff_in : in  std_logic;
      ce         : in  std_logic;       -- clock enable
      clock      : in  std_logic;
      reset      : in  std_logic);
  end component;

  component fsm is
    port (
      clock       : in  std_logic;
      reset       : in  std_logic;
      chute       : in  std_logic;
      rot         : in  std_logic;
      decal       : in  std_logic;
      fsm_ready   : out std_logic;
      fin_score   : in  std_logic;
      deb_decal   : out std_logic;
      fin_decal   : in  std_logic;
      deb_chute   : out std_logic;
      fin_chute   : in  std_logic;
      deb_rot     : out std_logic;
      fin_rot     : in  std_logic;
      deb_refresh : out std_logic;
      fin_refresh : in  std_logic;
      mux_add     : out std_logic_vector(1 downto 0);
      ce          : in  std_logic
      );
  end component;

  component mouvement is
    port (
      clock     : in  std_logic;
      CE_100Hz  : in  std_logic;
      reset     : in  std_logic;
      fsm_ready : in  std_logic;
      haut      : in  std_logic;
      gauche    : in  std_logic;
      droite    : in  std_logic;
      bas       : in  std_logic;
      chute     : out std_logic;
      rot       : out std_logic;
      decal     : out std_logic;
      sens      : out std_logic;
      LEVEL     : in std_logic_vector(5 downto 0);
      ce        : in  std_logic
      );
  end component;

  component reg_13b is
    port (
      LOAD    : in  std_logic;
      BUS_OUT : out std_logic_vector (12 downto 0);
      BUS_IN  : in  std_logic_vector (12 downto 0);
      clock   : in  std_logic;
      reset   : in  std_logic;
      CE      : in  std_logic
      );
  end component;

  component reg_8b is
    port (load_in    : in  std_logic;
          bus_8b_out : out std_logic_vector (7 downto 0);
          bus_8b_in  : in  std_logic_vector (7 downto 0);
          clock      : in  std_logic;
          reset      : in  std_logic;
          ce         : in  std_logic
          );
  end component;

  component mux_2_8b is
    port(
      SEL_MUX : in  std_logic;
      BUS_0   : in  std_logic_vector(7 downto 0);
      BUS_1   : in  std_logic_vector(7 downto 0);
      BUS_OUT : out std_logic_vector(7 downto 0)
      );
  end component;



  component mux_4_8b is
    port (
      SEL_MUX : in  std_logic_vector(1 downto 0);
      BUS_0   : in  std_logic_vector(7 downto 0);
      BUS_1   : in  std_logic_vector(7 downto 0);
      BUS_2   : in  std_logic_vector(7 downto 0);
      BUS_3   : in  std_logic_vector(7 downto 0);
      BUS_OUT : out std_logic_vector(7 downto 0)
      );
  end component;


  component mux_4_13b is
    port (
      SEL_MUX : in  std_logic_vector(1 downto 0);
      BUS_0   : in  std_logic_vector(12 downto 0);
      BUS_1   : in  std_logic_vector(12 downto 0);
      BUS_2   : in  std_logic_vector(12 downto 0);
      BUS_3   : in  std_logic_vector(12 downto 0);
      BUS_OUT : out std_logic_vector(12 downto 0)
      );
  end component;

  component mux_4_1b is
    port (
      SEL_MUX : in  std_logic_vector(1 downto 0);
      BUS_0   : in  std_logic;
      BUS_1   : in  std_logic;
      BUS_2   : in  std_logic;
      BUS_3   : in  std_logic;
      BUS_OUT : out std_logic
      );
  end component;

  component counter_256 is
    port (
      clock           : in  std_logic;
      reset           : in  std_logic;  -- asynchronous reset (active low)
      load_counter    : in  std_logic;
      incr_counter    : in  std_logic;
      decr_counter    : in  std_logic;
      init_counter    : in  std_logic;
      bus_counter_in  : in  std_logic_vector(7 downto 0);
      bus_counter_out : out std_logic_vector(7 downto 0);
      ce              : in  std_logic
      );
  end component;

  component gestion_decal is
    port (
      CLOCK       : in  std_logic;
      RESET       : in  std_logic;
      DEBUT       : in  std_logic;
      FIN         : out std_logic;
      SENS        : in  std_logic;
      NEXT_POS    : out std_logic_vector(12 downto 0);
      CURRENT_POS : in  std_logic_vector(12 downto 0);
      LOAD        : out std_logic;
      ADDRESS     : out std_logic_vector(7 downto 0);
      DATA_R      : in  std_logic_vector(7 downto 0);
      R_W         : out std_logic;
      EN_MEM      : out std_logic;
      CE          : in  std_logic
      );
  end component;

  component gestion_chute is
    port (
      CLOCK       : in  std_logic;
      RESET       : in  std_logic;
      DEBUT       : in  std_logic;
      FIN         : out std_logic;
      NEXT_POS    : out std_logic_vector(12 downto 0);
      CURRENT_POS : in  std_logic_vector(12 downto 0);
      LOAD        : out std_logic;
      ADDRESS     : out std_logic_vector(7 downto 0);
      DATA_R      : in  std_logic_vector(7 downto 0);
      R_W         : out std_logic;
      EN_MEM      : out std_logic;
      LOAD_FF     : out std_logic;
      CE          : in  std_logic
      );
  end component;

  component gestion_rot is
    port (
      CLOCK       : in  std_logic;
      RESET       : in  std_logic;
      DEBUT       : in  std_logic;
      FIN         : out std_logic;
      NEXT_POS    : out std_logic_vector(12 downto 0);
      CURRENT_POS : in  std_logic_vector(12 downto 0);
      LOAD        : out std_logic;
      ADDRESS     : out std_logic_vector(7 downto 0);
      DATA_R      : in  std_logic_vector(7 downto 0);
      R_W         : out std_logic;
      EN_MEM      : out std_logic;
      CE          : in  std_logic
      );
  end component;

  component gestion_refresh is
    port (
      CLOCK           : in  std_logic;
      RESET           : in  std_logic;
      DEBUT           : in  std_logic;
      FIN             : out std_logic;
      NEXT_POS_GET    : in  std_logic_vector(12 downto 0);
      CURRENT_POS_GET : in  std_logic_vector(12 downto 0);
      CURRENT_POS_SET : out std_logic_vector(12 downto 0);
      LOAD_CURRENT    : out std_logic;
      COUNTER_R       : in  std_logic_vector(7 downto 0);
      COUNTER_W       : out std_logic_vector(7 downto 0);
      LOAD_COUNTER    : out std_logic;
      INCR_COUNTER    : out std_logic;
      DECR_COUNTER    : out std_logic;
      INIT_COUNTER    : out std_logic;
      REGISTER_R      : in  std_logic_vector(7 downto 0);
      LOAD_REGISTER   : out std_logic;
      REGISTER_W      : out std_logic_vector(7 downto 0);
      ADDRESS         : out std_logic_vector(7 downto 0);
      DATA_R          : in  std_logic_vector(7 downto 0);
      DATA_W          : out std_logic_vector(7 downto 0);
      R_W             : out std_logic;
      EN_MEM          : out std_logic;
      FIN_JEU         : out std_logic;
      FF_READ         : in  std_logic;
      FF_INIT         : out std_logic;
      FIN_SCORE       : in  std_logic;
      INIT_SCORE      : out std_logic;
      INCR_SCORE      : out std_logic;
      CE              : in  std_logic
      );
  end component;

begin

  SCORE <= score_temp;


  instance_fsm : fsm
    port map (
      CLK25M,
      RESET,
      chute,
      rot,
      decal,
      fsm_ready,
      fin_score,
      deb_decal,
      fin_decal,
      deb_chute,
      fin_chute,
      deb_rot,
      fin_rot,
      deb_refresh,
      fin_refresh,
      sel_mux,
      CE
      );


  instance_mouvement : mouvement
    port map(
      CLK25M,
      CE_100Hz,
      RESET,
      fsm_ready,
      haut,
      gauche,
      droite,
      bas,
      chute,
      rot,
      decal,
      sens,
      score_temp,
      CE
      );

  register_score : counter64
    port map(
      CLK25M,
      RESET,
      incr_score,
      init_score,
      score_temp,
      CE
      );

  new_piece : ffnewpiece
    port map(
      ff_read,
      load_ff,
      init_ff,
      CE,
      CLK25M,
      RESET
      );


  next_pos_reg : reg_13b
    port map (
      load_next_pos,
      next_pos_get,
      next_pos_set,
      CLK25M,
      RESET,
      CE
      );

  current_pos_reg : reg_13b
    port map (
      load_current_pos,
      current_pos_get,
      current_pos_set,
      CLK25M,
      RESET,
      CE
      );


  mux_load : mux_4_1b
    port map(
      sel_mux(1 downto 0),
      load_decal,
      load_rot,
      load_chute,
      load_chute,
      load_next_pos
      );

  
  mux_address : mux_4_8b
    port map (
      sel_mux,
      address_decal,
      address_rot,
      address_chute,
      address_refresh,
      ADDRESS
      );

  mux_next_pos : mux_4_13b
    port map(
      sel_mux(1 downto 0),
      next_pos_decal,
      next_pos_rot,
      next_pos_chute,
      next_pos_chute,
      next_pos_set
      );

  mux_r_w : mux_4_1b
    port map(
      sel_mux,
      r_w_decal,
      r_w_rot,
      r_w_chute,
      r_w_refresh,
      R_W
      );

  mux_en_mem : mux_4_1b
    port map(
      sel_mux,
      en_mem_decal,
      en_mem_rot,
      en_mem_chute,
      en_mem_refresh,
      EN_MEM
      );


  instance_gestion_decal : gestion_decal
    port map (
      CLK25M,
      RESET,
      deb_decal,
      fin_decal,
      sens,
      next_pos_decal,
      current_pos_get,
      load_decal,
      address_decal,
      DATA_R,
      r_w_decal,
      en_mem_decal,
      CE
      );


  instance_gestion_chute : gestion_chute
    port map(
      CLK25M,
      RESET,
      deb_chute,
      fin_chute,
      next_pos_chute,
      current_pos_get,
      load_chute,
      address_chute,
      DATA_R,
      r_w_chute,
      en_mem_chute,
      load_ff,
      CE
      );


  instance_gestion_rot : gestion_rot
    port map(
      CLK25M,
      RESET,
      deb_rot,
      fin_rot,
      next_pos_rot,
      current_pos_get,
      load_rot,
      address_rot,
      DATA_R,
      r_w_rot,
      en_mem_rot,
      CE
      );


  instance_gestion_refresh : gestion_refresh
    port map(
      CLK25M,
      RESET,
      deb_refresh,
      fin_refresh,
      next_pos_get,
      current_pos_get,
      current_pos_set,
      load_current_pos,
      counter_r,
      counter_w,
      load_counter,
      incr_counter,
      decr_counter,
      init_counter,
      register_r,
      load_register,
      register_w,
      address_refresh,
      DATA_R,
      DATA_W,
      r_w_refresh,
      en_mem_refresh,
      FIN_JEU,
      ff_read,
      init_ff,
      FIN_SCORE,
      init_score,
      incr_score,
      CE
      );

  instance_counter_256 : counter_256
    port map(
      CLK25M,
      RESET,
      load_counter,
      incr_counter,
      decr_counter,
      init_counter,
      counter_w,
      counter_r,
      CE
      );

  instance_registre : reg_8b
    port map(
      load_register,
      register_r,
      register_w,
      CLK25M,
      RESET,
      CE
      );

end Behavioral;

