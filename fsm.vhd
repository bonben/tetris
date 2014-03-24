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

entity fsm is
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
    deb_nl      : out std_logic;
    fin_nl      : in  std_logic;
    deb_rot     : out std_logic;
    fin_rot     : in  std_logic;
    deb_refresh : out std_logic;
    fin_refresh : in  std_logic;
    mux_add     : out std_logic_vector(2 downto 0);
    ce          : in  std_logic
    );
end fsm;

architecture Behavioral of fsm is


begin

end Behavioral;

