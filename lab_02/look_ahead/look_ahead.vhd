library ieee;
use ieee.std_logic_1164.all;

entity look_ahead is
generic(N: natural:=4);
port( A,B         : in std_logic_vector(N-1 downto 0);
      Cin         : in std_logic;
      Sum         : out std_logic_vector(N-1 downto 0);
      Cout        : out std_logic);
end;

architecture arc of look_ahead is
signal C,B_xor: std_logic_vector(N downto 0);
signal P,G : std_logic_vector(N-1 downto 0);
begin 
	process(A,B,C)
	begin
	XY_loop: for j in 0 to 3 loop
				--Adder and Subtractor
				B_xor(j)  <= B(j) xor Cin;
				P(j)      <= A(j) xor B_xor(j);
				G(j)      <= A(j) and B_xor(j);
				Sum(j)    <= (A(j) xor B_xor(j)) xor C(j);
	end loop XY_loop;
	end process;
C(0) <= Cin;
C(1) <= G(0) or (P(0) and Cin);
C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Cin);
C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Cin);
Cout <= C(4);
end;