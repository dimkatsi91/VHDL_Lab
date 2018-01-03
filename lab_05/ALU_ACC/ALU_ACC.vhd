-- PACKAGE with 3 components needed for ALU CLA with ACC
library ieee;
use ieee.std_logic_1164.all;

package cla_reg_mux is
component mux_4_to_1_16_bits is 
generic(N: integer := 16);
port(I0,I1,I2,I3  : in std_logic_vector(N-1 downto 0);
     sel          : in std_logic_vector(1 downto 0);
     Mux_out      : out std_logic_vector(N-1 downto 0));
end component;

component look_ahead_16bits is 
generic(M: integer := 16);
port( A,B     : in std_logic_vector(M-1 downto 0);
	  Cin     : in std_logic;
	  S       : out std_logic_vector(M-1 downto 0);
	  C, OV   : out std_logic);
end component;

component parallel_reg is 
generic ( N: integer := 16);
port(
data         : in std_logic_vector(N-1 downto 0);
clock,reset  : in std_logic;
Q            : out std_logic_vector(N-1 downto 0));
end component;
end package cla_reg_mux;

-- ALU WITH ACCCUMULATOR IMPLEMENTATION via simple cla 16-bits
library ieee;
use ieee.std_logic_1164.all;
use work.cla_reg_mux.all;

entity ALU_ACC is 
generic(M: integer := 16);
port( A         : in std_logic_vector(M-1 downto 0);
      sel_logic : in std_logic_vector(1 downto 0);
      mode      : in std_logic;
      rst,clk   : in std_logic;
      R         : buffer std_logic_vector(M-1 downto 0);
	  COUT,OV   : out std_logic);
end ALU_ACC;

architecture alu_1_arc of ALU_ACC is
signal S_AND, S_OR, S_XOR, S_ADD_SUB : std_logic_vector(M-1 downto 0);
signal Reg_in, Reg_out : std_logic_vector(M-1 downto 0);
begin
S_AND     <= A and Reg_out;
S_OR      <= A or Reg_out;
S_XOR     <= A xor Reg_out;
ADD_SUB_ACTION : look_ahead_16bits port map(A=>A, B=>Reg_out, Cin=>mode, S=>S_ADD_SUB, C=>COUT, OV=>OV);
MUXX: mux_4_to_1_16_bits port map(I0=>S_AND, I1=>S_OR, I2=>S_XOR, I3=>S_ADD_SUB, sel=>sel_logic, Mux_out=> Reg_in);
ACC: parallel_reg port map(data=>Reg_in, clock=>clk, reset=>rst, Q=>Reg_out);
	R <= Reg_out;
end alu_1_arc;
