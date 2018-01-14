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

entity adder_subtractor is
port( A, B    : in std_logic_vector(0 to 3); 
	  Cin     : in std_logic; 
	  Sum     : out std_logic_vector(0 to 3); 
	  Cout,ov : out std_logic);
end;

architecture arc of adder_subtractor is
component fa_1bit is
 port( a,b,c : in std_logic; sum,cout : out std_logic );
end component;

Signal C:   std_logic_vector(0 to 4);
Signal X:   std_logic_vector(0 to 3);
begin
	process(X,B,Cin)
	begin
    X_Loop: for j in 0 to 3 loop
			X(j) <= B(j) xor Cin;
	end loop X_loop;
	end process;
C(0)  <= Cin;
	G: for i in 0 to 3 generate
		FA: fa_1bit port map( a => A(i),b => X(i),c => C(i), sum => Sum(i), cout => C(i+1) );
	end generate;
ov    <= C(4) xor C(3);
Cout  <= C(4);
end;