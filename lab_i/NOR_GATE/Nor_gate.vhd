library ieee;
use ieee.std_logic_1164.all;
entity Nor_gate is
port(
	A,B : in std_logic;
	Nor_out : out std_logic
);
end entity Nor_gate;

architecture simple of Nor_gate is
begin
	Nor_out <= not (A or B);
end architecture simple;