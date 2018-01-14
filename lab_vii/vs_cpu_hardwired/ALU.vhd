-- Package with MUX 2-TO-1 & ADDER  for ALU
library ieee;
use ieee.std_logic_1164.all;

package alu_pack is
component mux2to_ena is
generic(W:integer:=8);
port(I0, I1  : in std_logic_vector(W-1 downto 0);
     sel     : in std_logic;
     Mux_out : out std_logic_vector(W-1 downto 0));
end component;
-- Adder for ALU's Parallel Adder Component 
component adder_t is
generic(N:integer:=8);
port( A, B : in std_logic_vector(N-1 downto 0); 
	  Cin  : in std_logic; 
	  Sum  : out std_logic_vector(N-1 downto 0); 
	  Cout : out std_logic;
	  OV   : out std_logic);
end component;
end package alu_pack;

-- ALU implementation
library ieee;
use ieee.std_logic_1164.all;
use work.alu_pack.all;

entity ALU is
generic(M:integer:=8);
port(DBUSout    : in std_logic_vector(M-1 downto 0);
     ACout      : in std_logic_vector(M-1 downto 0);
     ALUSEL     : in std_logic;
     ALUout     : out std_logic_vector(M-1 downto 0));
end ALU;

architecture rtl of ALU is
signal S_AND, S_ADD : std_logic_vector(M-1 downto 0);
begin

S_AND <= ACout and DBUSout;

ADD_ACTION: adder_t generic map(N=>M)
				  port map(A=>ACout,B=>DBUSout,Cin=>'0',Sum=>S_ADD,Cout=>open,OV=>open);	-- '0' => ADDITION ALWAYS
				
ACTION_CHOOSE: mux2to_ena generic map(W=>M)
						  port map(I0=>S_ADD,I1=>S_AND,sel=>ALUSEL,Mux_out=>ALUout);
end rtl;

