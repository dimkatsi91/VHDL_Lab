library ieee;
use ieee.std_logic_1164.all;

entity D_FF is port(
	Clock, Enable, Load   : in std_logic;
	D, L_value : in std_logic;
	Q          : buffer std_logic);
end D_FF;

architecture arc of D_FF is 
begin
process(Clock,Load,Enable)
begin
if (Clock'event and Clock='1') then
	case Enable is
		when '0' => Q <= Q;
		when '1' => 
			case Load is
				when '0' => Q <= D;
				when '1' => Q <= L_value;
			end case;
	end case;
end if;
end process;
end arc;