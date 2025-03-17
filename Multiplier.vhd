library IEEE;
use IEEE.std_logic_1164.all;

entity multiplier is
	generic (n: integer:=32);
	port( 	InX: in std_logic_vector(n-1 downto 0);
			InY: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(2*n-1 downto 0));
end multiplier;

architecture booth_multiplier of multiplier is

component booth_circuit
	port(InX: in std_logic_vector(n-1 downto 0);
	InY: in std_logic_vector(n-1 downto 0);
	Output: out std_logic_vector(((n+5)*(integer(((n-(n mod 2))+3)/2))-6) downto 0));
end component;

component wallace_tree
	port(Input: in std_logic_vector(((n+5)*(integer(((n-(n mod 2))+3)/2))-6) downto 0);
		Output: out std_logic_vector(2*n-1 downto 0));
end component;

	signal out1: std_logic_vector(((n+5)*(integer(((n-(n mod 2))+3)/2))-6) downto 0);

begin 
	BoothCircuit: entity work.booth_circuit(circuit) generic map(n) port map(InX, InY, out1);
	WallaceTreeCircuit:  entity work.wallace_tree(circuit) generic map(n) port map(out1, Output);
end booth_multiplier;