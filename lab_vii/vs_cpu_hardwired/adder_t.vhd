--Full Adder of 1-bit
library ieee;
use ieee.std_logic_1164.all;

entity fa_1bit is
generic(N:integer:=8);
port( a, b, c : in std_logic; sum, cout : out std_logic);
end;

architecture fa_arc of fa_1bit is
begin
 sum <= ((a xor b) xor c);
 cout <= ((a xor b) and c) or (a and b);
end;

--Adder entity & arc
library ieee;
use ieee.std_logic_1164.all;

entity adder_t is
generic(N:integer:=8);
port( A, B : in std_logic_vector(N-1 downto 0); 
	  Cin  : in std_logic; 
	  Sum  : out std_logic_vector(N-1 downto 0); 
	  Cout : out std_logic;
	  OV   : out std_logic);
end adder_t;

architecture arc of adder_t is
component fa_1bit is
 port( a,b,c : in std_logic; sum,cout : out std_logic );
end component;

Signal C: std_logic_vector(N downto 0);
begin
C(0)  <= Cin;
	G: for i in N-1 downto 0 generate
		FA: fa_1bit port map( a => A(i),b => B(i),c => C(i), sum => Sum(i), cout => C(i+1) );
	end generate;
Cout  <= C(N);
OV    <= C(N-1) xor C(N);
end arc;