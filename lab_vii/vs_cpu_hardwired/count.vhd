library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity counter_4bit is
	
	port(data :in std_logic_vector(3 downto 0);
		 clk,clr,load,inc :in std_logic;
		 I :buffer std_logic_vector(3 downto 0));
end entity counter_4bit;

architecture arc_count of counter_4bit is
	
	begin
		p:process(data,clk,clr,load,inc)
			begin
				if rising_edge(clk) then
					if clr = '1' then 
						I <= (others=>'0');
					elsif  load = '1' then
							I <= data;
					elsif inc = '1' then
						 I <= I + 1;		
					
					end if;	
				end if;
			end process p;
end architecture arc_count;
		