-- MUX 2 TO 1 
library ieee;
use ieee.std_logic_1164.all;

entity mux2to_ena is
generic(W:integer:=8);
port(I0, I1  : in std_logic_vector(W-1 downto 0);
     sel     : in std_logic;
     Mux_out : out std_logic_vector(W-1 downto 0));
end mux2to_ena;

architecture arc of mux2to_ena is
signal hold : std_logic_vector(W-1 downto 0);
begin
process(sel,I0,I1)
begin
if sel='0' then
	hold <= I0;
else
	hold <= I1;
end if;
end process;
Mux_out <= hold;
end arc;
