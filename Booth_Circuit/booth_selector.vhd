library ieee;
use ieee.std_logic_1164.all;

entity booth_selector is
	generic (n:integer:=8);
	port( 	InY: in std_logic_vector(n-1 downto 0);
			SINGLE: in std_logic;
			DOUBLE: in std_logic;
			NEG: in std_logic;
			OutPP: out std_logic_vector(n downto 0));
end booth_selector;

architecture logic_gates of booth_selector is

component AND_OneMany
	port(	InOne: in std_logic;
			InMany: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(n-1 downto 0));
end component;

component XOR_OneMany
	port(	InOne: in std_logic;
			InMany: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(n-1 downto 0));
end component;

signal inAND1, inAND2, outAND1, outAND2, outOR: std_logic_vector(n downto 0);
begin
	inAND1<=(InY&'0');
	inAND2<=('0'&InY);
	U1: entity work.AND_OneMany(for_generate) generic map(n+1) port map(SINGLE, inAND2, outAND2);
	U2: entity work.AND_OneMany(for_generate) generic map(n+1) port map(DOUBLE, inAND1, outAND1);
	outOR<=(outAND1 or outAND2);
	U3: entity work.XOR_OneMany(for_generate) generic map(n+1) port map(NEG, outOR, OutPP);
	
end logic_gates;