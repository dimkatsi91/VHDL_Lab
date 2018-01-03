library ieee;
use ieee.std_logic_1164.all;

entity data_bus is	
	port( pc :in std_logic_vector(5 downto 0);
		  dr,mem :in std_logic_vector(7 downto 0);
		  PDM :in std_logic_vector(2 downto 0);		  
		  databus :out std_logic_vector(7 downto 0));
end entity data_bus;

architecture arc_bus of data_bus is
		 
		begin
			databus(7 downto 0) <= mem  when PDM(0)='1' else (others => 'Z'); --mem out
			databus(7 downto 0)<= dr when PDM(1)='1' else (others =>'Z');	--dr out
			databus(7 downto 0)<= "00" & pc when PDM(2)='1' else (others => 'Z');	--pc out
			
end architecture arc_bus;				
						