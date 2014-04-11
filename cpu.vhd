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

entity cpu is
  port (
    clock      : in  std_logic;
    reset      : in  std_logic;
    ce         : in  std_logic;
    bus_out    : out std_logic_vector(7 downto 0);
    BUS_IN     : in  std_logic_vector(7 downto 0);
    ADDRESS    : in  std_logic_vector(5 downto 0);
    INIT       : in  std_logic;
    MUX_MEM_IN : in  std_logic;
    R_W_IN     : in  std_logic;
    EN_MEM_IN  : in  std_logic
    );
end;



architecture Behavioral of cpu is

  signal enable_m         : std_logic;
  signal en_mem_uc        : std_logic;
  signal r_w              : std_logic;
  signal r_w_uc           : std_logic;
  signal sel_ual          : std_logic;
  signal load_reg         : std_logic;
  signal load_accu        : std_logic;
  signal init_ff          : std_logic;
  signal load_ff          : std_logic;
  signal carry            : std_logic;
  signal address_internal : std_logic_vector(5 downto 0);
  signal address_uc       : std_logic_vector(5 downto 0);
  signal bus_mem_out      : std_logic_vector(7 downto 0);
  signal bus_mem_in       : std_logic_vector(7 downto 0);
  signal bus_opu_mem      : std_logic_vector(7 downto 0);

  component mux_2_6b is
    port (
      SEL_MUX : in  std_logic;
      BUS_0   : in  std_logic_vector(5 downto 0);
      BUS_1   : in  std_logic_vector(5 downto 0);
      BUS_OUT : out std_logic_vector(5 downto 0)
      );
  end component;

  component mux_2_8b is
    port (
      SEL_MUX : in  std_logic;
      BUS_0   : in  std_logic_vector(7 downto 0);
      BUS_1   : in  std_logic_vector(7 downto 0);
      BUS_OUT : out std_logic_vector(7 downto 0)
      );
  end component;

  component mux_2_1b is
    port (
      SEL_MUX : in  std_logic;
      BUS_0   : in  std_logic;
      BUS_1   : in  std_logic;
      BUS_OUT : out std_logic
      );
  end component;


  component control_unit is
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
  end component control_unit;

  component operative_unit is
    port (sel_ual_in   : in  std_logic;
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
  end component operative_unit;


  component memory_cpu

    port (
      enable_m_in : in  std_logic;
      r_w_in      : in  std_logic;
      address_in  : in  std_logic_vector (5 downto 0);
      memory_out  : out std_logic_vector (7 downto 0);
      memory_in   : in  std_logic_vector (7 downto 0);
      clock       : in  std_logic;
      reset       : in  std_logic;
      ce          : in  std_logic);
  end component memory_cpu;

begin

  instance_control_unit : control_unit
    port map(clock, reset, en_mem_uc, r_w_uc, address_internal, bus_mem_out, sel_ual, load_reg, load_accu, init_ff, load_ff, carry, ce, INIT);

  instance_memory : memory_cpu
    port map(enable_m, r_w, address_internal, bus_mem_out, bus_mem_in, clock, reset, ce);

  instanve_operative_unit : operative_unit
    port map(sel_ual, load_accu, load_reg, load_ff, init_ff, carry, bus_mem_out, bus_opu_mem, ce, reset, clock);

  mux_address : mux_2_6b
    port map(MUX_MEM_IN, ADDRESS, address_uc, address_internal);

  mux_r_w : mux_2_1b
    port map(MUX_MEM_IN, R_W_IN, r_w_uc, r_w);

  mux_en_mem : mux_2_1b
    port map(MUX_MEM_IN, EN_MEM_IN, en_mem_uc, enable_m);

  mux_data_w : mux_2_8b
    port map(MUX_MEM_IN, BUS_IN, bus_opu_mem, bus_mem_in);

  bus_out <= bus_mem_out;
  
end Behavioral;

