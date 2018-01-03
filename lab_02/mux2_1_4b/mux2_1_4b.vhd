library ieee;
use ieee.std_logic_1164.all;

entity mux2_1_4b is
port( A,B : in std_logic_vector(3 downto 0);
      s, E: in std_logic;
         Y: out std_logic_vector(3 downto 0));
end;

architecture tot_arc of mux2_1_4b is
begin
process (E,s,A,B)
begin
if (E='0') then 
	Y <= "0000";
else
	if (s='0') then
		Y <= A;
	else
		Y <= B;
	end if;
end if;
end process;
end;