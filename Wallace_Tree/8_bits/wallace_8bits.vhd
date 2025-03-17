library ieee;
use ieee.std_logic_1164.all;


entity wallace_8bits is
	generic (n:integer:=8);
	port(	InputX: in std_logic_vector(n-1 downto 0);
			InputY: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(2*n-1 downto 0));
end wallace_8bits;

architecture circuit of wallace_8bits is

component booth_circuit 
	port(	InX: in std_logic_vector(n-1 downto 0);
			InY: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(((n+5)*(integer((n+3)/2))-5-1) downto 0));
end component;

component CSA_for_Wallace8bits_1stStage 
	port(	InputA: in std_logic_vector(11 downto 0);
			InputB: in std_logic_vector(12 downto 0);
			InputC: in std_logic_vector(14 downto 2);
			Sum: out std_logic_vector(14 downto 0);
			Carry: out std_logic_vector(13 downto 1));
end component;

component CSA_for_Wallace8bits_2ndStage 
	port(	InputA: in std_logic_vector(14 downto 0);
			InputB: in std_logic_vector(13 downto 1);
			InputC: in std_logic_vector(15 downto 4);
			Sum: out std_logic_vector(15 downto 0);
			Carry: out std_logic_vector(15 downto 2));
end component;

component CSA_for_Wallace8bits_3rdStage 
	port(	InputA: in std_logic_vector(15 downto 0);
			InputB: in std_logic_vector(15 downto 2);
			InputC: in std_logic_vector(15 downto 6);
			Sum: out std_logic_vector(15 downto 0);
			Carry: out std_logic_vector(16 downto 3));
end component;

component Carry_Propagate_Addeer_13bits 
	port(	InputA: in std_logic_vector(12 downto 0);
			InputB: in std_logic_vector(12 downto 0);
			Sum: out std_logic_vector(12 downto 0));
end component;

signal PP1: std_logic_vector(11 downto 0);
signal PP2: std_logic_vector(12 downto 0);
signal PP3: std_logic_vector(12 downto 0);
signal PP4: std_logic_vector(11 downto 0);
signal PP5: std_logic_vector(9 downto 0);

signal SS1: std_logic_vector(14 downto 0);
signal CC1: std_logic_vector(12 downto 0);
signal SS2, SS3: std_logic_vector(15 downto 0);
signal CC2, CC3: std_logic_vector(13 downto 0);

signal outBooth:std_logic_vector(59 downto 0);

begin
U0: entity work.booth_circuit(circuit) generic map(n) port map(InputX, InputY, outBooth);
PP1<=outBooth(11 downto 0);
PP2<=outBooth(24 downto 12);
PP3<=outBooth(37 downto 25);
PP4<=outBooth(49 downto 38);
PP5<=outBooth(59 downto 50);

U1: entity work.CSA_for_Wallace8bits_1stStage(circuit) port map(PP1, PP2, PP3, SS1, CC1);
U2: entity work.CSA_for_Wallace8bits_2ndStage(circuit) port map(SS1, CC1, PP4, SS2, CC2);
U3: entity work.CSA_for_Wallace8bits_3rdStage(circuit) port map(SS2, CC2, PP5, SS3, CC3);
U4: entity work.Carry_Propagate_Addeer_13bits(circuit) port map(CC3(12 downto 0), SS3(15 downto 3),Output(15 downto 3) );

Output(2 downto 0)<=SS3(2 downto 0);

end circuit;

