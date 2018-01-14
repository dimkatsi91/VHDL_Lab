-- Package my_pkg --
library ieee;
use ieee.std_logic_1164.all;

package my_pkg is 
component Full_Adder is port(
	x,y,z: in std_logic; 
	sum,cout: out std_logic);
end component Full_Adder;

component D_FF is port(
	Cl, E, L   : in std_logic;
	D, L_value : in std_logic;
	Q          : buffer std_logic);
end component D_FF;

component shift_reg_str is 
generic(N: integer := 4);
port(	CL, E, L, S_In      : in std_logic; 
		D_In				: in std_logic_vector(N-1 downto 0); 
		S_Out				: out std_logic; 
		d					: buffer std_logic_vector(N-1 downto 0));
end component shift_reg_str;
end package my_pkg;

-- Main Program serial_adder --
library ieee;
use ieee.std_logic_1164.all;
use work.my_pkg.all;

entity serial_adder is 
generic(N: integer := 4);
	port(
	dataA, dataB     : in std_logic_vector(N-1 downto 0);
	CLOCK, RESET     : in std_logic;
	mode             : in std_logic;
	DATA_Out_A       : out std_logic_vector(N-1 downto 0);
	DATA_Out_B       : out std_logic_vector(N-1 downto 0);
	SUM              : out std_logic_vector(N-1 downto 0));
end;

architecture struct of serial_adder is
signal S1 : std_logic;
signal init: std_logic_vector(N-1 downto 0);
signal QA,QB,QF,SS,CC : std_logic;
signal count: integer range 0 to N;
signal RUN: std_logic;
begin
--count <= N;
RUN <= '0' when count <= 0
else   '1';

FREEZE_CONTROL: process(CLOCK,RESET)
begin		
	if RESET = '1' then
		count <= N-1;
	elsif rising_edge(CLOCK) then
		if RUN = '1' then
			count <= count - 1;
		end if;
	end if;
end process;
		
S1 <= QB xor mode;
INITIALIZE: for j in N-1 downto 0 generate
				init(j) <= '0';
end generate;

REG_A: shift_reg_str port map(CLOCK,RUN,RESET,'0',dataA,QA,DATA_Out_A);

REG_B: shift_reg_str port map(CLOCK,RUN,RESET,'0',dataB,QB,DATA_Out_B);

F_A: Full_Adder port map(QA,S1,QF,SS,CC);

D_FLIP_FLOP: D_FF port map(CLOCK,RUN,RESET,CC,mode,QF);

REG_SUM: shift_reg_str port map(CLOCK,RUN,RESET,SS,init,open,SUM);
end struct;