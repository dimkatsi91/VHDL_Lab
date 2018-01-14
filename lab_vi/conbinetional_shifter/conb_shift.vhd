library ieee;
use ieee.std_logic_1164.all;

entity conb_shift is
		port(B :in std_logic_vector(7 downto 0);
			 t :in std_logic_vector(1 downto 0);
			 c :in std_logic_vector(2 downto 0);
			 R :buffer std_logic_vector(7 downto 0));				
			
end entity conb_shift;

architecture arc_conb of conb_shift is

	signal o,p : std_logic_vector(7 downto 0);
	
	begin
		p1:process(B,t,c,o,p,R)
				begin
					
					if c(0) = '0' then
						o <= B;
					elsif c(0) = '1' then
						case t is 
							when "00" => 						--circural shift right 
										o(7)<=B(0);
										 for i in 0 to 6 loop
											o(i)<=B(i+1);
										end loop;
										
							when "01" =>						--logical shift left
										o(0)<= '0';
										for j in 1 to 7 loop
											o(j)<=B(j-1);
										end loop;
										
							when "10" =>						--logical shift right
										o(7)<= '0';
										for k in 0 to 6 loop
											o(k)<=B(k+1);
										end loop;
								
							when "11" =>						--arithmetic shift right
										o(7)<=B(7);
										for f in 0 to 6  loop
											o(f)<= B(f+1);
										end loop;
						end case;
					end if;
			end process p1;
			
			p2: process(o,c,t,p)								
					begin						
					if c(1) = '0' then
						p <= o;
					elsif c(1) = '1' then
						case t is 
							when "00" => 						--right circural shift 
										p(6)<=o(0);
										p(7)<=o(1);
										
										 for i in 0 to 5 loop
											p(i)<=o(i+2);
											
										end loop;
										
							when "01" =>						--left logical shift
										p(1)<= '0';
										p(0)<= '0';
										for j in 2 to 7 loop
											p(j)<=o(j-2);
										end loop;
										
							when "10" =>						--right logical shift
										p(6)<= '0';
										p(7)<= '0';
										for k in 0 to 5 loop
											p(k)<=o(k+2);
										end loop;
								
							when "11" =>						--right arithmetic shift
										p(6)<=o(7);				--to 1o la8os htan edw
										p(7)<=o(7);
										for f in 0 to 5  loop
											p(f)<=o(f+2);
										end loop;
						end case;
					end if;
											
				end process p2;
				
				
				p3:process(p,c,t,R)
					begin						
					if c(2) = '0' then
						R <= p;
					elsif c(2) = '1' then
						case t is 
							when "00" => 						--right circural shift 
										 for i in 0 to 3 loop
											R(i)<=p(i+4);
											R(7-i)<=p(3-i);
										end loop;
										
										
							when "01" =>						--left logical shift
											for j in 0 to 3 loop
												R(j)<= '0';
												R(7-j)<=p(3-j);
											end loop;
																		
										
										
							when "10" =>						--right logical shift
										for k in 0 to 3 loop
											R(7-k) <= '0';
											R(k)<=p(k+4);
										end loop;
										
								
							when "11" =>						--right arithmetic shift
										
										for f in 0 to 3  loop
											R(f) <= p(f+4);
											--R(7-f) <= p(7-f);		--2nd mistake was here
										end loop;
										for m in 4 to 7 loop
											R(m) <= p(7);
										end loop;
						end case;
					end if;
											
				end process p3;

end architecture arc_conb;				