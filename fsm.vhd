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
    deb_rot     : out std_logic;
    fin_rot     : in  std_logic;
    deb_refresh : out std_logic;
    fin_refresh : in  std_logic;
    mux_add     : out std_logic_vector(1 downto 0);
    ce          : in  std_logic
    );
end fsm;

architecture Behavioral of fsm is

  type fsm_state is (init, idle, decal_state, rot_state, chute_state, refresh_state);
  signal next_state, current_state : fsm_state;
  
begin

  process (clock, reset) is             -- register
  begin  -- PROCESS

    if clock'event and clock = '1' then  -- rising clock edge
      if reset = '1' then                -- asynchronous reset (active low)
        current_state <= init;
      else
        if ce = '1' then
          current_state <= next_state;
        end if;
      end if;
    end if;
  end process;

  process (current_state, chute, rot, decal, fin_refresh, fin_rot, fin_chute, fin_decal) is  -- ???
  begin  -- PROCESS
    case current_state is               -- next state function
      when init => next_state <= idle;

      when idle =>
        if chute = '1' then
          next_state <= chute_state;
        elsif rot = '1' then
          next_state <= rot_state;
        elsif decal = '1' then
          next_state <= decal_state;
        else
          next_state <= idle;
        end if;
        
      when chute_state =>
        if fin_chute = '1' then
          next_state <= refresh_state;
        else
          next_state <= chute_state;
        end if;
        
      when rot_state =>
        if fin_rot = '1' then
          next_state <= refresh_state;
        else
          next_state <= rot_state;
        end if;

      when decal_state =>
        if fin_decal = '1' then
          next_state <= refresh_state;
        else
          next_state <= decal_state;
        end if;

      when refresh_state =>
        if fin_refresh = '1' then
          next_state <= idle;
        else
          next_state <= refresh_state;
        end if;


    end case;
  end process;

  process (current_state) is            -- output function
  begin  -- PROCESS
    case current_state is
      when init =>
        fsm_ready   <= '0';
        deb_decal   <= '0';
        deb_chute   <= '0';
        deb_rot     <= '0';
        deb_refresh <= '0';
        mux_add     <= "00";

      when idle =>
        fsm_ready   <= '1';
        deb_decal   <= '0';
        deb_chute   <= '0';
        deb_rot     <= '0';
        deb_refresh <= '0';
        mux_add     <= "00";

      when decal_state =>
        fsm_ready   <= '0';
        deb_decal   <= '1';
        deb_chute   <= '0';
        deb_rot     <= '0';
        deb_refresh <= '0';
        mux_add     <= "00";

      when chute_state =>
        fsm_ready   <= '0';
        deb_decal   <= '0';
        deb_chute   <= '1';
        deb_rot     <= '0';
        deb_refresh <= '0';
        mux_add     <= "10";

      when rot_state =>
        fsm_ready   <= '0';
        deb_decal   <= '0';
        deb_chute   <= '0';
        deb_rot     <= '1';
        deb_refresh <= '0';
        mux_add     <= "01";

      when refresh_state =>
        fsm_ready   <= '0';
        deb_decal   <= '0';
        deb_chute   <= '0';
        deb_rot     <= '0';
        deb_refresh <= '1';
        mux_add     <= "11";



        
    end case;
  end process;
end Behavioral;
