--VERY SIMPLE CPU HARDWIRED LOGIC PACKAGE

library ieee;
use ieee.std_logic_1164.all;

package hwr_cpu_pack is 


component hardwired_logic is
			port( clk :in std_logic;
				  InstrReg :in std_logic_vector(1 downto 0); --input of Instruction Register				  
				  moP :out std_logic_vector(10 downto 0));
end component hardwired_logic;


component data_bus is	
	port( pc :in std_logic_vector(5 downto 0);
		  dr,mem :in std_logic_vector(7 downto 0);
		  PDM :in std_logic_vector(2 downto 0);		  
		  databus :out std_logic_vector(7 downto 0));
end component data_bus;


component inc_reg is 
		generic(m :integer:=8);
		port ( load,clk,clr,inc :in std_logic;
				data :in std_logic_vector(m-1 downto 0);
				Q :buffer std_logic_vector(m-1 downto 0));
end component inc_reg;


component paral_reg is
	generic(m :integer:=8);
	port ( load,clk,clr :in std_logic;
		   data : in std_logic_vector(m-1 downto 0);
		   Q :buffer std_logic_vector(m-1 downto 0));

end component paral_reg ;


component ALU is
generic(M:integer:=8);
port(DBUSout    : in std_logic_vector(M-1 downto 0);
     ACout      : in std_logic_vector(M-1 downto 0);
     ALUSEL     : in std_logic;
     ALUout     : out std_logic_vector(M-1 downto 0));
end component ALU;


component memory IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component memory;


end package hwr_cpu_pack;



