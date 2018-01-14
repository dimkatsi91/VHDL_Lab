-- D-FF Declaration
library ieee;
use ieee.std_logic_1164.all;

entity D_FF is port(
d : in std_logic;
clk, rst : in std_logic;
q : out std_logic);
end;

architecture dff_arc of D_FF is
begin
p1: process(clk,rst)
begin
  if rst='1' then
	q <= '0';
  elsif falling_edge(clk) then
    q <= d;
  end if;
end process;
end;

-- N bit register declaration
library ieee;
use ieee.std_logic_1164.all;

entity N_bit_reg is 
generic ( N: integer := 8);
port(
data         : in std_logic_vector(N-1 downto 0);
clock,reset  : in std_logic;
Q            : out std_logic_vector(N-1 downto 0));
end;

architecture struct of N_bit_reg is
component D_FF is port(d,clk,rst:in std_logic; q:out std_logic);
end component;

begin
F: for j in 0 to N-1 generate
	DFF: D_FF port map(data(j), clock, reset, Q(j));
end generate;
end;