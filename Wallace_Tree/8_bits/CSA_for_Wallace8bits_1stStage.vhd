library ieee;
use ieee.std_logic_1164.all;


entity CSA_for_Wallace8bits_1stStage is
	port(	InputA: in std_logic_vector(11 downto 0);
			InputB: in std_logic_vector(12 downto 0);
			InputC: in std_logic_vector(14 downto 2);
			Sum: out std_logic_vector(14 downto 0);
			Carry: out std_logic_vector(13 downto 1));
end CSA_for_Wallace8bits_1stStage;

architecture circuit of CSA_for_Wallace8bits_1stStage is

component Full_Adder
	port( A, B, Carry_in: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

component Half_Adder
	port( A, B: in std_logic;
		  Sum, Carry_out: out std_logic);
end component;

begin
	generate_label1:
		for i in 0 to 1 generate
			U1: entity work.Half_Adder(logic_gates) port map(InputA(i), InputB(i), Sum(i), Carry(i+1));
		end generate;
	generate_label2:	
		for i in 2 to 11 generate
			U2: entity work.Full_Adder(logic_gates) port map(InputA(i), InputB(i), InputC(i), Sum(i), Carry(i+1));
		end generate;
		
	U3: entity work.Half_Adder(logic_gates) port map(InputB(12), InputC(12), Sum(12), Carry(13));
		
	Sum(13)<=InputC(13);
	Sum(14)<=InputC(14);
end circuit;

