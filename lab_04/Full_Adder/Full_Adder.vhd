library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder is port(x,y,z: in std_logic; sum,cout: out std_logic);
end;

architecture fa_arc of Full_Adder is
signal S1,S2,S3: std_logic;
begin
S1   <= x  xor y;
S2   <= x  and y;
S3   <= S1 and z;
sum  <= S1 xor z;
cout <= S3 or S2;
end;