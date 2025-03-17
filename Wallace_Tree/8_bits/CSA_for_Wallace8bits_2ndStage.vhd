library ieee;
use ieee.std_logic_1164.all;


entity CSA_for_Wallace8bits_2ndStage is
	port(	InputA: in std_logic_vector(14 downto 0);
			InputB: in std_logic_vector(13 downto 1);
			InputC: in std_logic_vector(15 downto 4);
			Sum: out std_logic_vector(15 downto 0);
			Carry: out std_logic_vector(15 downto 2));
end CSA_for_Wallace8bits_2ndStage;

architecture circuit of CSA_for_Wallace8bits_2ndStage is

component Full_Adder
	port( A, B, Carry_in: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

component Half_Adder
	port( A, B: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

begin
	Sum(0)<=InputA(0);
	
	generate_label1:
		for i in 1 to 3 generate
			U1: entity work.Half_Adder(logic_gates) port map(InputA(i), InputB(i), Sum(i), Carry(i+1));
		end generate;
	generate_label2:	
		for i in 4 to 13 generate
			U2: entity work.Full_Adder(logic_gates) port map(InputA(i), InputB(i), InputC(i), Sum(i), Carry(i+1));
		end generate;
	--14
	U3: entity work.Half_Adder(logic_gates) port map(InputA(14), InputC(14), Sum(14), Carry(15));
		
	Sum(15)<=InputC(15);
end circuit;


