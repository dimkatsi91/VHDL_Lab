library ieee;
use ieee.std_logic_1164.all;

entity D_FF is port(
	Cl, E, L   : in std_logic;
	D, L_value : in std_logic;
	Q          : buffer std_logic);
end D_FF;

architecture arc of D_FF is 
begin
process(Cl,L,E)
begin
if (Cl'event and Cl='1') then
	case E is
		when '0' => Q <= Q;
		when '1' => 
			case L is
				when '0' => Q <= D;
				when '1' => Q <= L_value;
			end case;
	end case;
end if;
end process;
end arc;

-- Shift Register --
library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_str is 
generic(N: integer := 4);
port(	CL, E, L, S_In      : in std_logic; 
		D_In				: in std_logic_vector(N-1 downto 0); 
		S_Out				: out std_logic; 
		d					: buffer std_logic_vector(N-1 downto 0));
end;

architecture struct of shift_reg_str is 
component D_FF is port(Cl, E, L, D, L_value: in std_logic; Q: buffer std_logic);
end component;
signal tmp: std_logic_vector(N downto 0);
begin
tmp(N) <= S_In;
X: for j in N-1 downto 0 generate 
	DFF: D_FF port map(CL, E, L, tmp(j+1), D_In(j), tmp(j));
end generate;
S_Out <= tmp(0); 
d <= tmp(N-1 downto 0);
end;