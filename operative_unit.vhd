----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:03 03/12/2014 
-- Design Name: 
-- Module Name:    up - Behavioral 
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

entity operative_unit is
  port (sel_ual_in    : in  std_logic;
         load_accu_in : in  std_logic;
         load_reg_in  : in  std_logic;
         load_ff_in   : in  std_logic;
         init_ff_in   : in  std_logic;
         carry_out    : out std_logic;
         memory_in    : in  std_logic_vector(7 downto 0);
         memory_out   : out std_logic_vector(7 downto 0);
         ce           : in  std_logic;
         reset        : in  std_logic;
         clock        : in  std_logic);
end operative_unit;

architecture Behavioral of operative_unit is
-- components

  component ual is
    port (bus_reg_8b_ual_in     : in  std_logic_vector (7 downto 0);
           bus_reg_accu_ual_in  : in  std_logic_vector (7 downto 0);
           bus_ual_reg_accu_out : out std_logic_vector (7 downto 0);
           carry_out            : out std_logic;
           sel_ual              : in  std_logic);
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

  component ff is
    port (carry_in    : in  std_logic;
           carry_out  : out std_logic;
           load_ff_in : in  std_logic;
           init_ff_in : in  std_logic;
           ce         : in  std_logic;  -- clock enable
           clock      : in  std_logic;
           reset      : in  std_logic);
  end component;

-- signals
  signal bus_8b_reg_ual  : std_logic_vector (7 downto 0);
  signal bus_8b_accu_ual : std_logic_vector (7 downto 0);
  signal bus_8b_ual_accu : std_logic_vector (7 downto 0);
  signal carry           : std_logic;

begin


  instance_ff : ff
    port map(carry, carry_out, load_ff_in, init_ff_in, ce, clock, reset);
  
  instance_reg_8b : reg_8b
    port map(load_reg_in, bus_8b_reg_ual, memory_in, clock, reset, ce);
  
  instance_reg_accu : reg_8b
    port map(load_accu_in, bus_8b_accu_ual, bus_8b_ual_accu, clock, reset, ce);
  
  instance_ual : ual
    port map(bus_8b_reg_ual, bus_8b_accu_ual, bus_8b_ual_accu, carry, sel_ual_in);

  memory_out <= bus_8b_accu_ual;

end Behavioral;

