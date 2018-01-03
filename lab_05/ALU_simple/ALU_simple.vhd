-- Package for ALU Simple Declaration
library ieee;
use ieee.std_logic_1164.all;

package alu_pack_simple is 
component mux_4_to_1_16_bits is
generic(N: integer := 16);
port(I0,I1,I2,I3  : in std_logic_vector(N-1 downto 0);
     sel          : in std_logic_vector(1 downto 0);
     Mux_out      : out std_logic_vector(N-1 downto 0));
end component;

component add_sub_simple is 
generic(N: integer := 16);
port( A, B    : in std_logic_vector(N-1 downto 0); 
	  Cin     : in std_logic; 
	  Sum     : out std_logic_vector(N-1 downto 0); 
	  Cout,ov : out std_logic);
end component;
end package alu_pack_simple;

-- ALU IMPLEMENTATION
library ieee;
use ieee.std_logic_1164.all;
use work.alu_pack_simple.all;

entity ALU_simple is 
generic(M: integer := 16);
port(A,B       : in std_logic_vector(M-1 downto 0);
     Sel       : in std_logic_vector(1 downto 0);
	 mode      : in std_logic; 
     COUT, OV  : out std_logic; 
     R         : out std_logic_vector(M-1 downto 0));
end ALU_simple;

architecture alu_arc_simple of ALU_simple is
signal S_AND, S_OR, S_XOR, S_ADD_SUB : std_logic_vector(M-1 downto 0);
begin
S_AND <= A and B;
S_OR  <= A or B;
S_XOR <= A xor B;

ADD_ACTION:    add_sub_simple   generic map(N=>M)
								port map(A,B,mode,S_ADD_SUB,COUT,OV);

ACTION_CHOICE: mux_4_to_1_16_bits generic map(N=>M)
                                  port map(I0=>S_AND, I1=>S_OR, I2=>S_XOR, I3=>S_ADD_SUB, sel=>Sel, Mux_out=>R);

end alu_arc_simple;