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

entity fsm_cpu is
  port (
    clock         : in  std_logic;
    reset         : in  std_logic;      -- asynchronous reset (active low)
    -- Inputs
    op_in         : in  std_logic_vector(1 downto 0);
    carry_in      : in  std_logic;
    -- Operative unit control signals
    sel_ual_out   : out std_logic;      -- 0->NOR ; 1->ADD
    load_reg_out  : out std_logic;
    load_accu_out : out std_logic;
    init_ff_out   : out std_logic;
    load_ff_out   : out std_logic;
    -- Memory unit control signals
    r_w_out       : out std_logic;      -- 0->read ; 1->write
    enable_m_out  : out std_logic;
    -- Control unit control signals
    load_cpt_out  : out std_logic;
    incr_cpt_out  : out std_logic;
    init_cpt_out  : out std_logic;
    sel_mux_out   : out std_logic;      -- 0->val_cpt ; 1->val_ri
    load_inst_out : out std_logic;
    ce            : in  std_logic;
    INIT_IN          : in  std_logic
    );
end fsm_cpu;

architecture Behavioral of fsm_cpu is

  type fsm_state is (init, fetch_inst, decode, fetch_op, ex_nor, ex_add, ex_jcc, ex_sta);
  signal next_state, current_state : fsm_state;
  
begin

  process (clock, reset) is                 -- register
  begin  -- PROCESS
    if reset = '1' then                     -- asynchronous reset (active low)
      current_state <= init;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if ce = '1' then
        if INIT_IN = '1' then
          current_state <= init;
        else
          current_state <= next_state;
        end if;
      end if;
    end if;
  end process;

  process (current_state, op_in) is     -- ???
  begin  -- PROCESS
    case current_state is               -- next state function
      when init => next_state <= fetch_inst;

      when fetch_inst => next_state <= decode;

      when decode =>
        case op_in is
          when "10"   => next_state <= ex_sta;
          when "11"   => next_state <= ex_jcc;
          when others => next_state <= fetch_op;
        end case;


      when fetch_op =>
        case op_in is
          when "00"   => next_state <= ex_nor;
          when "01"   => next_state <= ex_add;
          when others => next_state <= current_state;
        end case;
        
      when ex_add => next_state <= fetch_inst;
      when ex_nor => next_state <= fetch_inst;
      when ex_jcc => next_state <= fetch_inst;
      when ex_sta => next_state <= fetch_inst;

    end case;
  end process;

  process (current_state, carry_in) is  -- output function
  begin  -- PROCESS
    case current_state is
      when init =>
        -- Operative unit control signals
        sel_ual_out   <= '0';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '0';           -- (C)
        load_accu_out <= '0';           -- (B)
        init_ff_out   <= '1';           -- (E)
        load_ff_out   <= '0';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '0';           -- (G) 0->read ; 1->write
        enable_m_out  <= '0';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= '0';           -- (H)
        incr_cpt_out  <= '0';           -- (I)
        init_cpt_out  <= '1';           -- (J)
        sel_mux_out   <= '0';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '0';           -- (L)

      when fetch_inst =>
        -- Operative unit control signals
        sel_ual_out   <= '0';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '0';           -- (C)
        load_accu_out <= '0';           -- (B)
        init_ff_out   <= '0';           -- (E)
        load_ff_out   <= '0';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '0';           -- (G) 0->read ; 1->write
        enable_m_out  <= '1';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= '0';           -- (H)
        incr_cpt_out  <= '1';           -- (I)
        init_cpt_out  <= '0';           -- (J)
        sel_mux_out   <= '0';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '1';  -- (L)

      when decode =>
        -- Operative unit control signals
        sel_ual_out   <= '0';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '0';           -- (C)
        load_accu_out <= '0';           -- (B)
        init_ff_out   <= '0';           -- (E)
        load_ff_out   <= '0';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '0';           -- (G) 0->read ; 1->write
        enable_m_out  <= '0';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= '0';           -- (H)
        incr_cpt_out  <= '0';           -- (I)
        init_cpt_out  <= '0';           -- (J)
        sel_mux_out   <= '1';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '0';           -- (L)

      when fetch_op =>
        -- Operative unit control signals
        sel_ual_out   <= '0';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '1';           -- (C)
        load_accu_out <= '0';           -- (B)
        init_ff_out   <= '0';           -- (E)
        load_ff_out   <= '0';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '0';           -- (G) 0->read ; 1->write
        enable_m_out  <= '1';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= '0';           -- (H)
        incr_cpt_out  <= '0';           -- (I)
        init_cpt_out  <= '0';           -- (J)
        sel_mux_out   <= '1';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '0';  -- (L)

      when ex_sta =>
        -- Operative unit control signals
        sel_ual_out   <= '0';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '0';           -- (C)
        load_accu_out <= '0';           -- (B)
        init_ff_out   <= '0';           -- (E)
        load_ff_out   <= '0';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '1';           -- (G) 0->read ; 1->write
        enable_m_out  <= '1';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= '0';           -- (H)
        incr_cpt_out  <= '0';  -- (I)
        init_cpt_out  <= '0';           -- (J)
        sel_mux_out   <= '1';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '0';           -- (L)

      when ex_jcc =>
        -- Operative unit control signals
        sel_ual_out   <= '0';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '0';           -- (C)
        load_accu_out <= '0';           -- (B)
        init_ff_out   <= carry_in;      -- (E)
        load_ff_out   <= '0';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '0';           -- (G) 0->read ; 1->write
        enable_m_out  <= '0';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= not carry_in;  -- (H)
        incr_cpt_out  <= '0';           -- (I)
        init_cpt_out  <= '0';           -- (J)
        sel_mux_out   <= '1';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '0';           -- (L)

      when ex_nor =>
        -- Operative unit control signals
        sel_ual_out   <= '0';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '0';           -- (C)
        load_accu_out <= '1';           -- (B)
        init_ff_out   <= '0';           -- (E)
        load_ff_out   <= '0';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '0';           -- (G) 0->read ; 1->write
        enable_m_out  <= '0';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= '0';           -- (H)
        incr_cpt_out  <= '0';  -- (I)
        init_cpt_out  <= '0';           -- (J)
        sel_mux_out   <= '1';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '0';           -- (L)

      when ex_add =>
        -- Operative unit control signals
        sel_ual_out   <= '1';           -- (A) 0->NOR ; 1->ADD
        load_reg_out  <= '0';           -- (C)
        load_accu_out <= '1';           -- (B)
        init_ff_out   <= '0';           -- (E)
        load_ff_out   <= '1';           -- (D)
        -- Memory unit control signals
        r_w_out       <= '0';           -- (G) 0->read ; 1->write
        enable_m_out  <= '0';           -- (F)
        -- Control unit control signals
        load_cpt_out  <= '0';           -- (H)
        incr_cpt_out  <= '0';           -- (I)
        init_cpt_out  <= '0';           -- (J)
        sel_mux_out   <= '1';           -- (K) 0->val_cpt ; 1->val_ri
        load_inst_out <= '0';           -- (L)
    end case;
  end process;
end Behavioral;

