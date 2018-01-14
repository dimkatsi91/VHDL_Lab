library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity inc_reg is 
		generic(m :integer:=8);
		port ( load,clk,clr,inc :in std_logic;
				data :in std_logic_vector(m-1 downto 0);
				Q :buffer std_logic_vector(m-1 downto 0));
end entity inc_reg;

architecture arc_inc_reg of inc_reg is
			
			begin
				
				p1 :process(load,clk,clr,inc,data)
						begin
							
							if clr = '0' then 
								Q <= (others => '0');
							elsif rising_edge(clk) then
									
								if load = '1' then
								   Q <= data;
								elsif load = '0' then
									case inc is
										when '1' =>  Q <= Q + 1 ;									
									    when '0' =>  Q <= Q ;
									end case;
								end if;
							end if;
					end process p1;
end architecture arc_inc_reg;
								
				
			   