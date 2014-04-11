---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:40:13 02/21/2013 
-- Design Name: 
-- Module Name:    FullDesign - Behavioral 
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

entity control_unit is
  port (clock         : in  std_logic;
        reset         : in  std_logic;
        enable_m_out  : out std_logic;
        -- Memory control signals
        r_w_out       : out std_logic;
        address_out   : out std_logic_vector(5 downto 0);
        -- Memory bus
        bus_mem_cu_in : in  std_logic_vector(7 downto 0);
        -- Operative unit control signals
        sel_ual_out   : out std_logic;
        load_reg_out  : out std_logic;
        load_accu_out : out std_logic;
        init_ff_out   : out std_logic;
        load_ff_out   : out std_logic;
        -- Carry in
        carry_in      : in  std_logic;
        ce            : in  std_logic;
        INIT          : in  std_logic
        );
end control_unit;

architecture Behavioral of control_unit is

  signal load_inst   : std_logic;
  signal load_cpt    : std_logic;
  signal incr_cpt    : std_logic;
  signal init_cpt    : std_logic;
  signal sel_mux     : std_logic;
  signal bus_cpt_mux : std_logic_vector(5 downto 0);
  signal bus_out_reg : std_logic_vector(7 downto 0);  -- bus out of reg inst,
                                                      -- connected to cpt in and
                                                      -- mux in


  component fsm_cpu is
    port (
      clock         : in  std_logic;
      reset         : in  std_logic;    -- asynchronous reset (active low)
      -- Inputs
      op_in         : in  std_logic_vector(1 downto 0);
      carry_in      : in  std_logic;
      -- Operative unit control signals
      sel_ual_out   : out std_logic;    -- 0->NOR ; 1->ADD
      load_reg_out  : out std_logic;
      load_accu_out : out std_logic;
      init_ff_out   : out std_logic;
      load_ff_out   : out std_logic;
      -- Memory unit control signals
      r_w_out       : out std_logic;    -- 0->read ; 1->write
      enable_m_out  : out std_logic;
      -- Control unit control signals
      load_cpt_out  : out std_logic;
      incr_cpt_out  : out std_logic;
      init_cpt_out  : out std_logic;
      sel_mux_out   : out std_logic;    -- 0->val_cpt ; 1->val_ri
      load_inst_out : out std_logic;
      ce            : in  std_logic;
      INIT_IN          : in  std_logic
      );
  end component fsm_cpu;

  component cpt is
    port(
      clock       : in  std_logic;
      reset       : in  std_logic;      -- asynchronous reset (active low)
      load_cpt    : in  std_logic;
      incr_cpt    : in  std_logic;
      init_cpt    : in  std_logic;
      bus_cpt_in  : in  std_logic_vector(5 downto 0);
      bus_cpt_out : out std_logic_vector(5 downto 0);
      ce          : in  std_logic
      );
  end component cpt;

  component mux is
    port(
      sel_mux     : in  std_logic;
      bus_cpt_mux : in  std_logic_vector(5 downto 0);
      bus_reg_mux : in  std_logic_vector(5 downto 0);
      bus_mux_out : out std_logic_vector(5 downto 0)
      );
  end component mux;

  component reg_8b

    port (load_in    : in  std_logic;
          bus_8b_out : out std_logic_vector (7 downto 0);
          bus_8b_in  : in  std_logic_vector (7 downto 0);
          clock      : in  std_logic;
          reset      : in  std_logic;
          ce         : in  std_logic
          );
  end component reg_8b;

begin

  instance_fsm : fsm_cpu
    port map(clock, reset, bus_out_reg(7 downto 6), carry_in, sel_ual_out, load_reg_out, load_accu_out, init_ff_out, load_ff_out, r_w_out, enable_m_out, load_cpt, incr_cpt, init_cpt, sel_mux, load_inst, ce, INIT);

  instance_reg_inst : reg_8b
    port map(load_inst, bus_out_reg, bus_mem_cu_in, clock, reset, ce);

  instance_mux : mux
    port map(sel_mux, bus_cpt_mux, bus_out_reg(5 downto 0), address_out);

  instance_cpt : cpt
    port map(clock, reset, load_cpt, incr_cpt, init_cpt, bus_out_reg(5 downto 0), bus_cpt_mux, ce);
  

  
end Behavioral;

