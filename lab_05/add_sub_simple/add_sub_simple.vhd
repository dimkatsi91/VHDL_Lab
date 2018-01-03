library ieee;
use ieee.std_logic_1164.all;

--Full Adder of 1-bit
entity fa_1bit is
	port( a, b, c : in std_logic; sum, cout : out std_logic);
end;

architecture fa_arc of fa_1bit is
begin
 sum <= ((a xor b) xor c);
 cout <= ((a xor b) and c) or (a and b);
end;

--Adder/Subtractor entity & arc
library ieee;
use ieee.std_logic_1164.all;

entity add_sub_simple is
generic(N: integer := 16);
port( A, B    : in std_logic_vector(N-1 downto 0); 
	  Cin     : in std_logic; 
	  Sum     : out std_logic_vector(N-1 downto 0); 
	  Cout,ov : out std_logic);
end;

architecture arc of add_sub_simple is
component fa_1bit is
 port( a,b,c : in std_logic; sum,cout : out std_logic );
end component;

Signal C:   std_logic_vector(N downto 0);
Signal X:   std_logic_vector(N-1 downto 0);
begin
	process(X,B,Cin)
	begin
    X_Loop: for j in N-1 downto 0 loop
			X(j) <= B(j) xor Cin;
	end loop X_loop;
	end process;
C(0)  <= Cin;
	G: for i in N-1 downto 0 generate
		FA: fa_1bit port map( a => A(i),b => X(i),c => C(i), sum => Sum(i), cout => C(i+1) );
	end generate;
ov    <= C(N) xor C(N-1);
Cout  <= C(N);
end;