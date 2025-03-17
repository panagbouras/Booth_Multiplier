library ieee;
use ieee.std_logic_1164.all;


entity CSA_for_Wallace8bits_3rdStage is
	port(	InputA: in std_logic_vector(15 downto 0);
			InputB: in std_logic_vector(15 downto 2);
			InputC: in std_logic_vector(15 downto 6);
			Sum: out std_logic_vector(15 downto 0);
			Carry: out std_logic_vector(16 downto 3));
end CSA_for_Wallace8bits_3rdStage;

architecture circuit of CSA_for_Wallace8bits_3rdStage is

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
	Sum(1)<=InputA(1);
	
	generate_label1:
		for i in 2 to 5 generate
			U1: entity work.Half_Adder(logic_gates) port map(InputA(i), InputB(i), Sum(i), Carry(i+1));
		end generate;
	generate_label2:	
		for i in 6 to 15 generate
			U2: entity work.Full_Adder(logic_gates) port map(InputA(i), InputB(i), InputC(i), Sum(i), Carry(i+1));
		end generate;
		
end circuit;
