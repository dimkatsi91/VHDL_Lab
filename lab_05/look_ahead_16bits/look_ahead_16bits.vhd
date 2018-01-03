-- Package for CLA of 4-bits
library ieee;
use ieee.std_logic_1164.all;

package cla_4bits is
component carry_look_ahead is
generic(N: natural:=4);
port( A,B         : in std_logic_vector(N-1 downto 0);
      Cin         : in std_logic;
      Sum         : out std_logic_vector(N-1 downto 0);
      Cout,ov     : out std_logic);
end component;
end package cla_4bits;

-- Look ahead for 16-bits Ripple simple method
library ieee;
use ieee.std_logic_1164.all;
use work.cla_4bits.all;

entity look_ahead_16bits is
generic(M: integer := 16);
port( A,B     : in std_logic_vector(M-1 downto 0);
	  Cin     : in std_logic;
	  S       : out std_logic_vector(M-1 downto 0);
	  C, OV   : out std_logic);
end look_ahead_16bits;

architecture cla_16bits_arc of look_ahead_16bits is
signal C4, C8, C12 : std_logic;
signal B_xor, Mode : std_logic_vector(M-1 downto 0);
begin
Mode  <= (others => Cin);
B_xor <= B xor Mode;

CLA0: carry_look_ahead port map(A=>A(3 downto 0), B=>B_xor(3 downto 0), Cin=>Cin, Sum=>S(3 downto 0), Cout=>C4);
CLA1: carry_look_ahead port map(A=>A(7 downto 4), B=>B_xor(7 downto 4), Cin=>C4, Sum=>S(7 downto 4), Cout=>C8);
CLA2: carry_look_ahead port map(A=>A(11 downto 8), B=>B_xor(11 downto 8), Cin=>C8, Sum=>S(11 downto 8), Cout=>C12);
CLA3: carry_look_ahead port map(A=>A(15 downto 12), B=>B_xor(15 downto 12), Cin=>C12, Sum=>S(15 downto 12), Cout=>C, ov=>OV);
end cla_16bits_arc;