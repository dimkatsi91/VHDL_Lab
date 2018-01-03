-- Package declaration for Microprogrammed Control Unit Implementation
-- Contains Mux 2-to-1 & Microcode Memory
library ieee;
use ieee.std_logic_1164.all;

package mseq_pkg is
component mux2to_ena is
generic(W:integer:=8);
port(I0, I1  : in std_logic_vector(W-1 downto 0);
     sel     : in std_logic;
     Mux_out : out std_logic_vector(W-1 downto 0));
end component;

component microcode_memory IS
PORT(address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
	 clock	 : IN STD_LOGIC ;
	 q		 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END component;
end package mseq_pkg;

-- Microsequencer Implementation / Microprogrammed Control Unit
library ieee;
use ieee.std_logic_1164.all;
use work.mseq_pkg.all;

entity mseq is
port(IR    : in std_logic_vector(1 downto 0);
     CLOCK : in std_logic;
     MOP   : out std_logic_vector(10 downto 0 ));
end mseq;

architecture bhv of mseq is
signal IR_MAP, Mux_Out : std_logic_vector(3 downto 0);		-- Two cables needed after MAP_LOGIC & MUX
signal D: std_logic_vector(15 downto 0);
signal SEL :std_logic;
signal ADDR :std_logic_vector(3 downto 0);


begin
IR_MAP <= '1' & IR & '0';
MUX_4BIT: mux2to_ena generic map(W=>4)
					 port map(I1=>IR_MAP,I0=>ADDR,sel=>SEL,Mux_out=>Mux_Out);
MICROCODE_MEM: microcode_memory port map(address=>Mux_Out,clock=>CLOCK,q=>D);
SEL<=D(15);
MOP<=D(14 downto 4);
ADDR<=D(3 downto 0);
end bhv;