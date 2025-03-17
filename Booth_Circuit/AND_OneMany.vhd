library ieee;
use ieee.std_logic_1164.all;

entity AND_OneMany is
	generic (n:integer:=8);
	port(	InOne: in std_logic;
			InMany: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(n-1 downto 0));
end AND_OneMany;

architecture for_generate of AND_OneMany is
begin
	G1: for i in 0 to n-1 generate
		Output(i)<=(InOne and InMany(i));
	end generate;
end for_generate;
