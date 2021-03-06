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

entity gestion_decal is
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
end gestion_decal;

architecture Behavioral of gestion_decal is

begin

end Behavioral;

