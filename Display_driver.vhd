----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:35 04/11/2014 
-- Design Name: 
-- Module Name:    Display_driver - Behavioral 
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

entity Display_driver is
  port (
    SCORE      : in  std_logic_vector (5 downto 0);
    BEST_YOU   : in  std_logic;
    SCORE_TEXT : in  std_logic;
    CLOCK      : in  std_logic;
    RESET      : in  std_logic;
    DEF7_SEG   : out std_logic_vector (7 downto 0);
    ALLUM_MIL  : out std_logic;
    ALLUM_CENT : out std_logic;
    ALLUM_DIZ  : out std_logic;
    ALLUM_UNI  : out std_logic);
end Display_driver;

architecture Behavioral of Display_driver is

  component Multiplier is
    port (score     : in  std_logic_vector(5 downto 0);
          new_score : out std_logic_vector(13 downto 0));
  end component;

  component Decomposer is
    port (
      CLOCK      : in  std_logic;
      RESET      : in  std_logic;
      NEW_SCORE  : in  std_logic_vector (13 downto 0);
      BEST_YOU   : in  std_logic;       -- 0 si BEST, 1 si YOU
      SCORE_TEXT : in  std_logic;       -- 0 si SCORE, 1 si TEXT
      MILLIEMES  : out std_logic_vector (3 downto 0);
      CENTAINES  : out std_logic_vector (3 downto 0);
      DIZAINES   : out std_logic_vector (3 downto 0);
      UNITES     : out std_logic_vector (3 downto 0));
  end component;

  component mux_digit is
    port (MIL         : in  std_logic_vector (3 downto 0);
          CENT        : in  std_logic_vector (3 downto 0);
          DIZ         : in  std_logic_vector (3 downto 0);
          UNI         : in  std_logic_vector (3 downto 0);
          DIGIT_ACTIF : in  std_logic_vector(3 downto 0);
          CHIFFRE     : out std_logic_vector (3 downto 0));
  end component;

  component transcodeur_bcd_7seg is
    port (CHIFFRE  : in  std_logic_vector (3 downto 0);
          DEF_7SEG : out std_logic_vector (7 downto 0));
  end component;

  component cadenceur200Hz is
    port (
      clk25M  : in  std_logic;
      reset   : in  std_logic;
      ce200Hz : out std_logic
      );         
  end component;

  component compteur_mux_digit is
    port (H_MUX_ACTIF : in  std_logic;
          DIGIT_ACTIF : out std_logic_vector (3 downto 0));
  end component;

  component allumage_digit is
    port (DIGIT_ACTIF : in  std_logic_vector (3 downto 0);
          ALLUM_MIL   : out std_logic;
          ALLUM_CENT  : out std_logic;
          ALLUM_DIZ   : out std_logic;
          ALLUM_UNI   : out std_logic);
  end component;

  signal new_score   : std_logic_vector(13 downto 0);
  signal milliemes   : std_logic_vector(3 downto 0);
  signal centaines   : std_logic_vector(3 downto 0);
  signal dizaines    : std_logic_vector(3 downto 0);
  signal unites      : std_logic_vector(3 downto 0);
  signal digit_actif : std_logic_vector (3 downto 0);
  signal chiffre     : std_logic_vector (3 downto 0);
  signal ce_100Hz    : std_logic;
begin

  instance_Multiplier : Multiplier
    port map
    (
      SCORE,
      new_score
      );

  instance_Decomposer : Decomposer
    port map
    (
      CLOCK,
      RESET,
      new_score,
      BEST_YOU,
      SCORE_TEXT,
      milliemes,
      centaines,
      dizaines,
      unites
      );

  instance_mux_digit : mux_digit
    port map
    (milliemes,
     centaines,
     dizaines,
     unites,
     digit_actif,
     chiffre
     );
  instance_transcodeur_bcd_7seg : transcodeur_bcd_7seg
    port map
    (chiffre,
     DEF7_SEG
     );             

  instance_cadenceur200Hz : cadenceur200Hz
    port map
    (CLOCK,
     RESET,
     ce_100Hz
     );    

  instance_compteur_mux_digit : compteur_mux_digit
    port map
    (ce_100Hz,
     digit_actif
     );                      

  instance_allumage_digit : allumage_digit
    port map
    (digit_actif,
     ALLUM_MIL,
     ALLUM_CENT,
     ALLUM_DIZ,
     ALLUM_UNI
     );    
end Behavioral;

