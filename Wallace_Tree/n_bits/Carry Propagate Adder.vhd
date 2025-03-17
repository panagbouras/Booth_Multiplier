library ieee;
use ieee.std_logic_1164.all;

entity CPA is
	generic (n:integer:=8);
	port( 	In1: in std_logic_vector(n-1 downto 0);
			In2: in std_logic_vector(n-1 downto 0);
			Sum: out std_logic_vector(n-1 downto 0));
end CPA;

architecture RCA of CPA is

component Full_Adder
	port( A, B, Carry_in: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

component Half_Adder
	port( A, B: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

signal c: std_logic_vector(n-1 downto 0);
begin
	HA: entity work.Half_Adder(logic_gates) port map(In1(0),In2(0),Sum(0),c(0));
	generate_Full_Adders:
	for i in 1 to n-1 generate
		FA: entity work.Full_Adder(logic_gates) port map(In1(i), In2(i), c(i-1), Sum(i), c(i));
	end generate;

end RCA;

