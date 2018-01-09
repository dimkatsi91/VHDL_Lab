-- T flip-flop block 
library ieee;
use ieee.std_logic_1164.all;

entity t_ff is port( 
	t     : in std_logic;
	clk   : in std_logic;
	rst   : in std_logic;
	q     : buffer std_logic);
end;

architecture arc of t_ff is
begin
process(clk,rst)
begin
if rst='1' then
	q <= '0';
elsif falling_edge(clk) then
	if t='0' then
		q <= q;
	else
		q <= not q;
	end if;
 end if;
 end process;
 end;
 
 -- Ripple counter
library ieee;
use ieee.std_logic_1164.all;

 entity counter_up is port(
	clock : in std_logic;
	reset : in std_logic;
	Q     : buffer std_logic_vector(3 downto 0));
end;

architecture arc of counter_up is 
component t_ff is port(t,clk,rst: in std_logic; q: buffer std_logic);
end component;
begin
TFF0: t_ff port map('1',clock,reset,Q(0));
TFF1: t_ff port map('1',Q(0),reset,Q(1));
TFF2: t_ff port map('1',Q(1),reset,Q(2));
TFF3: t_ff port map('1',Q(2),reset,Q(3));
end;