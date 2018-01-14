--VERY SIMPLE CPU IMPLEMENTATION

library ieee;
use ieee.std_logic_1164.all;
use work.micro_cpu.all;


entity micropr_cpu is
	port(clock,reset :in std_logic;
	     ARout,PCout :buffer std_logic_vector(5 downto 0);
		 DRout,ACout :buffer std_logic_vector(7 downto 0);
		 IRout :buffer std_logic_vector(1 downto 0);
		 dataBus :buffer std_logic_vector(7 downto 0);
		 moP :buffer std_logic_vector(10 downto 0));
end entity micropr_cpu;


architecture arc_micro_cpu of micropr_cpu is
		
		signal ACin :std_logic_vector(7 downto 0);
		signal MemOut :std_logic_vector(7 downto 0);
		
		begin
			
			

			microsequencer: mseq port map(IR=>dataBus(7 downto 6), CLOCK=>clock, MOP=>moP);
			
			Dbus: data_bus port map( pc=>PCout, dr=>DRout, mem=>MemOut, PDM(2)=>moP(2),PDM(1)=>moP(1),PDM(0)=>mop(0), databus=>dataBus);  
		  	  		
			
			
			AR: paral_reg generic map(m=>6)
						  port map(load=>moP(10), clk=>clock, clr=>reset, data=>dataBus(5 downto 0), Q=>ARout);
						
						
			PC: inc_reg generic map(m=>6)
						port map(load=>moP(9), clk=>clock, clr=>reset, inc=>moP(8), data=>dataBus(5 downto 0),Q=>PCout);
						
			DR: paral_reg generic map(m=>8)
						  port map(load=>moP(7), clk=>clock, clr=>reset, data=>dataBus(7 downto 0), Q=>DRout);
						
			AC: inc_reg generic map(m=>8)
						port map(load=>moP(6), clk=>clock, clr=>reset, inc=>moP(5), data=>ACin, Q=>ACout);
						
			IR: paral_reg generic map(m=>2)
						  port map(load=>moP(4), clk=>clock, clr=>reset, data=>dataBus(7 downto 6), Q=>IRout);
						
			ALU_box: ALU generic map(M=>8)
						 port map(DBUSout=>dataBus(7 downto 0),ACout=>ACout,ALUSEL=>moP(3),ALUout=>ACin);
						
			external_mem: memory port map(address=>dataBus(5 downto 0),clock=>clock,q=>MemOut);
			
end architecture arc_micro_cpu;
									     
									     
									
				





		