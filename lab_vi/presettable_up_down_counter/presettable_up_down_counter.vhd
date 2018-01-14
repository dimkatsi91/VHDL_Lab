library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity presettable_up_down_counter is
generic(N: integer:= 16);
port( CLK, CLEAR, LOAD  : in std_logic; 
	  EN_COUNT, UP_DOWN : in std_logic;
      D                 : in std_logic_vector(N-1 downto 0);
      Q                 : buffer std_logic_vector(N-1 downto 0));
end presettable_up_down_counter;

architecture up_down of presettable_up_down_counter is
begin
PROCESS(CLK,CLEAR,LOAD,EN_COUNT,UP_DOWN,D)
begin
if CLEAR='1' then
	Q <= (others=>'0');
elsif LOAD='1' then
	Q <= D;
elsif falling_edge(CLK) then
	if (EN_COUNT='1' and UP_DOWN='1') then
		Q <= Q+1;
	elsif (EN_COUNT='1' and UP_DOWN='0') then
		Q <= Q-1;
	end if;
end if;
end process;
end up_down;