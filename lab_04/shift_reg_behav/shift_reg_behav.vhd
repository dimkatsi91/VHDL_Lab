-- SHift Register Behavioral Implementation
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;

entity shift_reg_behav is
generic(N: integer := 4);
port(
	CL, E, L : in std_logic;
	S_In     : in std_logic;
	D_In     : in std_logic_vector(N-1 downto 0);
	S_Out    : out std_logic;
	d        : buffer std_logic_vector(N-1 downto 0));
end shift_reg_behav;

architecture behav of shift_reg_behav is
begin
process(CL,E,L)
begin
if rising_edge(CL) then 
	if E = '1' then
		if L = '1' then
			d      <= D_In;
			S_Out  <= d(0);
		else
			d      <= '0' & d(N-1 downto 1);
			--d      <= std_logic_vector((shr(unsigned(d),conv_unsigned(1,1))));
			d(N-1)   <= S_In;
			--S_Out  <= d(0);
		end if;
	end if;
end if;
end process;
end behav;