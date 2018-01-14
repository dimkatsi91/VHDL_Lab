library ieee;
use ieee.std_logic_1164.all;

entity paral_reg is
	generic(m :integer:=8);
	port ( load,clk,clr :in std_logic;
		   data : in std_logic_vector(m-1 downto 0);
		   Q :buffer std_logic_vector(m-1 downto 0));

end entity paral_reg ;


architecture arc_reg of paral_reg is 

		begin
			p1:process(clr,clk,load,data)
				begin
					if clr = '0' then 
						Q <= (others => '0');
					elsif rising_edge(clk) then
						if load = '1' then 
							Q <= data;
						elsif load = '0' then
							Q <= Q;
						end if;
					end if;
				end process p1;
end architecture arc_reg;
				
		