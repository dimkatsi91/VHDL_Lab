library ieee;
use ieee.std_logic_1164.all;

entity dec4_16 is
	port(I :in std_logic_vector(3 downto 0);
		 O :out std_logic_vector(15 downto 0));
end entity dec4_16;

architecture decd of dec4_16 is

		begin
			dec:process(I)
				begin
				
					O <="0000000000000000" ;  --default output value
					
					case I is 
						when "0000" => O(0)<='1';
						when "0001" => O(1)<='1';
						when "0010" => O(2)<='1';
						when "0011" => O(3)<='Z';
						when "0100" => O(4)<='Z';
						when "0101" => O(5)<='Z';
						when "0110" => O(6)<='Z';
						when "0111" => O(7)<='Z';
						when "1000" => O(8)<='1';
						when "1001" => O(9)<='1';
						when "1010" => O(10)<='1';
						when "1011" => O(11)<='1';
						when "1100" => O(12)<='1';
						when "1101" => O(13)<='Z';
						when "1110" => O(14)<='1';
						when "1111" => O(15)<='Z';
					end case;
				end process dec;			
			
end architecture decd;