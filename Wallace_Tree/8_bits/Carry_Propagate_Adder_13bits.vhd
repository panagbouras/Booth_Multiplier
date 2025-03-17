library ieee;
use ieee.std_logic_1164.all;


entity Carry_Propagate_Addeer_13bits is
	port(	InputA: in std_logic_vector(12 downto 0);
			InputB: in std_logic_vector(12 downto 0);
			Sum: out std_logic_vector(12 downto 0));
end Carry_Propagate_Addeer_13bits;

architecture circuit of Carry_Propagate_Addeer_13bits is

component Full_Adder
	port( A, B, Carry_in: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

component Half_Adder
	port( A, B: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

signal Carry: std_logic_vector(12 downto 0);
begin
	
	U1: entity work.Half_Adder(logic_gates) port map(InputA(0), InputB(0), Sum(0), Carry(0));
	
	generate_label:
		for i in 1 to 12 generate
			U1: entity work.Full_Adder(logic_gates) port map(InputA(i), InputB(i), Carry(i-1), Sum(i), Carry(i));
		end generate;
		
end circuit;


