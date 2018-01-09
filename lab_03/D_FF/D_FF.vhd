library ieee;
use ieee.std_logic_1164.all;

entity D_FF is port(
d : in std_logic;
clk, clr, pre : in std_logic;
q : out std_logic);
end;

architecture dff_arc of D_FF is
begin
p1: process(pre,clr,clk)
begin
  if clr='1' then
	q <= '0';
  elsif pre='1' then
    q <= '1';
  elsif falling_edge(clk) then
    q <= d;
  end if;
end process;
end;