library ieee;
use ieee.std_logic_1164.all;

entity booth_cell is
	generic (n:integer:=12);
	port(	triad: in std_logic_vector(2 downto 0);
			InY: in std_logic_vector(n-1 downto 0);
			s: out std_logic;
			Output: out std_logic_vector(n downto 0));
end booth_cell;

architecture cascade_components of booth_cell is

component booth_selector
	port( 	InY: in std_logic_vector(n-1 downto 0);
			SINGLE: in std_logic;
			DOUBLE: in std_logic;
			NEG: in std_logic;
			OutPP: out std_logic_vector(n downto 0));
end component;

component booth_encoder
	port( 	Input: in std_logic_vector(2 downto 0);
			SINGLE: out std_logic;
			DOUBLE: out std_logic;
			NEG: out std_logic);
end component;

signal single, double, neg: std_logic;
begin
	U1: entity work.booth_encoder(logic_gates) port map(triad, single, double, neg);
	U2: entity work.booth_selector(logic_gates) generic map(n) port map(InY, single, double, neg, Output);
	s<=triad(2);
end cascade_components;
