----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:03 03/18/2014 
-- Design Name: 
-- Module Name:    gestion_affichage - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_affichage is
    Port ( CENTAINE : in  STD_LOGIC_VECTOR (3 downto 0);
           DIZAINE : in  STD_LOGIC_VECTOR (3 downto 0);
           UNITE : in  STD_LOGIC_VECTOR (3 downto 0);
			  CENT_CLI : in  STD_LOGIC;
			  DIZ_CLI : in  STD_LOGIC;
			  UNI_CLI : in  STD_LOGIC;
           H : in  STD_LOGIC;
           CLIEN : in  STD_LOGIC;
           ALLUM_MIL : out  STD_LOGIC;
           ALLUM_CENT : out  STD_LOGIC;
           ALLUM_DIZ : out  STD_LOGIC;
           ALLUM_UNI : out  STD_LOGIC;
           DEF_7SEG : out  STD_LOGIC_VECTOR (7 downto 0));
end gestion_affichage;

architecture Behavioral of gestion_affichage is

COMPONENT mux_digit
    PORT(
         CENT : IN  std_logic_vector(3 downto 0);
         DIZ : IN  std_logic_vector(3 downto 0);
         UNI : IN  std_logic_vector(3 downto 0);
         DIGIT_ACTIF : IN  std_logic_vector(3 downto 0);
         CHIFFRE : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;

COMPONENT compteur_mux_digit
    PORT(
         H_MUX_ACTIF : IN  std_logic;
         DIGIT_ACTIF : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;

    COMPONENT allumage_digit
    PORT(
         DIGIT_ACTIF : IN  std_logic_vector(3 downto 0);
		   CENT_CLI : in STD_LOGIC;
		   DIZ_CLI : in STD_LOGIC;
		   UNI_CLI : in STD_LOGIC;
         H_CLI : IN  std_logic;
			ALLUM_MIL : out  STD_LOGIC;
         ALLUM_CENT : OUT  std_logic;
         ALLUM_DIZ : OUT  std_logic;
         ALUM_UNI : OUT  std_logic
        );
    END COMPONENT;
	 
COMPONENT transcodeur_bcd_7seg
    PORT(
         CHIFFRE : in  STD_LOGIC_VECTOR (3 downto 0);
         DEF_7SEG : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;

signal digit_actif_sig : std_logic_vector(3 downto 0);
signal chiffre_sig : std_logic_vector(3 downto 0);


begin -- Architecture

inst_mux_digit : mux_digit 			 				 port map( CENTAINE,
																			  DIZAINE,
																			  UNITE,
																			  digit_actif_sig,
																			  chiffre_sig);

inst_compteur_mux_digit : compteur_mux_digit		 port map( H,
																			  digit_actif_sig);

inst_allumage_digit : allumage_digit				 port map(  digit_actif_sig,
																				CENT_CLI,
																				DIZ_CLI,
																				UNI_CLI,
																				CLIEN,
																				ALLUM_MIL,
																				ALLUM_CENT,
																				ALLUM_DIZ,
																			   ALLUM_UNI);
																			  
inst_transcodeur_bcd_7seg : transcodeur_bcd_7seg port map(	chiffre_sig,
																				DEF_7SEG);


end Behavioral;

