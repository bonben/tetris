----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:04:33 03/10/2014 
-- Design Name: 
-- Module Name:    ual - Behavioral 
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
use IEEE.NUMERIC_STD.all;

entity ual is
  port (bus_reg_8b_ual_in    : in  std_logic_vector (7 downto 0);
        bus_reg_accu_ual_in  : in  std_logic_vector (7 downto 0);
        bus_ual_reg_accu_out : out std_logic_vector (7 downto 0);
        carry_out            : out std_logic;
        sel_ual              : in  std_logic);
end ual;

architecture Behavioral of ual is



  --signal bus_ual_reg_accu_out_TEMP_signed : UNSIGNED (8 downto 0);
  --signal bus_reg_8b_ual_in_unsigned_9b : UNSIGNED (8 downto 0);
  --signal bus_reg_accu_ual_in_unsigned_9b : UNSIGNED (8 downto 0);

begin  -- Behavioral
  exec : process (bus_reg_8b_ual_in, bus_reg_accu_ual_in, sel_ual) is
    
  variable bus_ual_reg_accu_out_TEMP_std_logic_vector : std_logic_vector (8 downto 0) := "000000000";    
    variable bus_ual_reg_accu_out_TEMP_signed : unsigned (8 downto 0);
    variable bus_reg_8b_ual_in_unsigned_9b    : unsigned (8 downto 0);
    variable bus_reg_accu_ual_in_unsigned_9b  : unsigned (8 downto 0);
    
  begin  --PROCESS
    if sel_ual = '1' then               --ADD
      bus_reg_8b_ual_in_unsigned_9b   := resize(unsigned(bus_reg_8b_ual_in), 9);
      bus_reg_accu_ual_in_unsigned_9b := resize(unsigned(bus_reg_accu_ual_in), 9);

      bus_ual_reg_accu_out_TEMP_signed := bus_reg_8b_ual_in_unsigned_9b + bus_reg_accu_ual_in_unsigned_9b;


      bus_ual_reg_accu_out_TEMP_std_logic_vector := std_logic_vector(bus_ual_reg_accu_out_TEMP_signed);
      bus_ual_reg_accu_out                       <= bus_ual_reg_accu_out_TEMP_std_logic_vector(7 downto 0);
      carry_out                                  <= bus_ual_reg_accu_out_TEMP_std_logic_vector(8);
      
    else  -- sel_ual = '0' -- NOR 
      carry_out <= '0';
      bus_ual_reg_accu_out <= bus_reg_8b_ual_in nor bus_reg_accu_ual_in;
      
    end if;
  end process;
end Behavioral;
