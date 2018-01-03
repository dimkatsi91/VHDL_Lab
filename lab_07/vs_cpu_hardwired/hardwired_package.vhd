library ieee;
use ieee.std_logic_1164.all;

package hardwired is 

component counter_4bit is
	
	port(data :in std_logic_vector(3 downto 0);
		 clk,clr,load,inc :in std_logic;
		 I :out std_logic_vector(3 downto 0));
end component counter_4bit;

component dec4_16 is
	port(I :in std_logic_vector(3 downto 0);
		 O :out std_logic_vector(15 downto 0));
end component dec4_16;


end package;

