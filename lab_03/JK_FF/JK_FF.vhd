library ieee;
use ieee.std_logic_1164.all;

entity JK_FF is
port( J,K      : in std_logic;
      pre, clr : in std_logic;
           clk : in std_logic;
      Q        : buffer std_logic);
end;

architecture JK_arc of JK_FF is
begin
p1: process(pre,clr,clk)
    begin
		if clr='1' then
			Q <= '0';
		elsif pre='0' then 
			Q <= '1';
		elsif rising_edge(clk) then
			if (J='0' and K='0') then
				Q <= Q;
			elsif (J='0' and K='1') then
				Q <= '0';
			elsif (J='1' and K='0') then 
				Q <= '1';
			elsif (J='1' and K='1') then
				Q <= not Q;
			end if;
		end if;
end process;
end;    