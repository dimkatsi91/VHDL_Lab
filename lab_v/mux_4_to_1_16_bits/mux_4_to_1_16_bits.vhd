library ieee;
use ieee.std_logic_1164.all;

entity mux_4_to_1_16_bits is
generic(N: integer := 16);
port(I0,I1,I2,I3  : in std_logic_vector(N-1 downto 0);
     sel          : in std_logic_vector(1 downto 0);
     Mux_out      : out std_logic_vector(N-1 downto 0));
end mux_4_to_1_16_bits;

architecture arc of mux_4_to_1_16_bits is
begin
process(I0,I1,I2,I3,sel)
begin
case sel is
	when "00" => Mux_out <= I0;
	when "01" => Mux_out <= I1;
	when "10" => Mux_out <= I2;
	when "11" => Mux_out <= I3;
end case;
end process;
end arc;