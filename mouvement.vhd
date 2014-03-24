----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:10:12 02/19/2013 
-- Design Name: 
-- Module Name:    fsm - Behavioral 
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mouvement is
  port (
    clock     : in  std_logic;
    reset     : in  std_logic;
    fsm_ready : in  std_logic;
    haut      : in  std_logic;
    gauche    : in  std_logic;
    droite    : in  std_logic;
    chute     : out std_logic;
    rot       : out std_logic;
    decal     : out std_logic;
    sens      : out std_logic;
    ce        : in  std_logic
    );
end mouvement;

architecture Behavioral of mouvement is


begin

end Behavioral;

