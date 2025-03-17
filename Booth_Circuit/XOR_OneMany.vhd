library ieee;
use ieee.std_logic_1164.all;

entity XOR_OneMany is
	generic (n:integer:=8);
	port(	InOne: in std_logic;
			InMany: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(n-1 downto 0));
end XOR_OneMany;

architecture for_generate of XOR_OneMany is
begin
	G1: for i in 0 to n-1 generate
		Output(i)<=(InOne xor InMany(i));
	end generate;
end for_generate;