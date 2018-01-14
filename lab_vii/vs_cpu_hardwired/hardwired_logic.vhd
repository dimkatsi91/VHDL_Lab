library ieee;
use ieee.std_logic_1164.all;
use work.hardwired.all;


entity hardwired_logic is
			port( clk :in std_logic;
				  InstrReg :in std_logic_vector(1 downto 0); --input of Instruction Register				  
				  moP :out std_logic_vector(10 downto 0));
end entity hardwired_logic;

architecture hardwr of hardwired_logic is
		
		signal ir : std_logic_vector(3 downto 0); --IR mapping logic
		signal fetch1,fetch2,fetch3,add1,add2,and1,and2,jmp1,inc1,clear,load,inc : std_logic;
		signal Count :std_logic_vector(3 downto 0); --counters output/decoders input
		signal decode :std_logic_vector(15 downto 0); --decoders outputs
		
		begin			
			
			ir <= '1' & InstrReg & '0';
			
			counter: counter_4bit port map (data => ir, clk=>clk, clr=>clear, load =>load, inc =>inc, I => Count);
		
			decoder: dec4_16 port map(I => Count, O => decode);
			
			
			
			fetch1 <= decode(0);
			fetch2 <= decode(1);
			fetch3 <= decode(2);			
			add1 <= decode(8);
			add2 <= decode(9);
			and1 <= decode(10);
			and2 <= decode(11);
			jmp1 <= decode(12);
			inc1 <= decode(14);			
			
				
			moP(0) <= fetch2 or add1 or and1;
			moP(1) <= fetch3 or add2 or and2 or jmp1;
			moP(2) <= fetch1;
			moP(3) <= and2;
			moP(4) <= fetch3;
			moP(5) <= inc1;
			moP(6) <= add2 or and2;
			moP(7) <= fetch2 or add1 or and1;
			moP(8) <=fetch2;
			moP(9) <= jmp1;			
			moP(10) <= fetch1 or fetch3;		
		
			clear <= add2 or and2 or jmp1 or inc1;
			load <= fetch3;
			inc <=  fetch1 or fetch2 or add1 or and1;

end architecture hardwr;			
			
		   
