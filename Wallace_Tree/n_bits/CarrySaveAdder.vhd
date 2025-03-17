library ieee;
use ieee.std_logic_1164.all;

entity CSA is
	generic (n: integer:=16);
	port( 	In1: in std_logic_vector(n-1 downto 0);
			In2: in std_logic_vector(n-1 downto 0);
			In3: in std_logic_vector(n-1 downto 0);
			Sums: out std_logic_vector(n-1 downto 0);
			Carries: out std_logic_vector(n-1 downto 0));
end CSA;

architecture rtl of CSA is

component Full_Adder
	port( A, B, Carry_in: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

signal temp: std_logic_vector(n-1 downto 0);
begin
	--Full Adders
	generate_Adders:
	for i in 0 to n-1 generate
		FA: entity work.Full_Adder(logic_gates) port map(In1(i), In2(i), In3(i), Sums(i), temp(i));
	end generate generate_Adders;
	Carries(0)<='0';
	ShiftLeft:
	for j in 0 to n-2 generate		
		Carries(j+1)<=temp(j);
	end generate;
end rtl;
