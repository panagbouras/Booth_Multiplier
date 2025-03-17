library ieee;
use ieee.std_logic_1164.all;

entity booth_encoder is
	port( 	Input: in std_logic_vector(2 downto 0);
			SINGLE: out std_logic;
			DOUBLE: out std_logic;
			NEG: out std_logic);
end booth_encoder;

architecture logic_gates of booth_encoder is
signal outAND1, outAND2: std_logic;
begin
	SINGLE<= (Input(0) xor Input(1));
	outAND1<= (Input(0) and Input(1) and not(Input(2)));
	outAND2<= (not(Input(0)) and not(Input(1)) and Input(2));
	DOUBLE<= (outAND1 or outAND2);
	NEG<= Input(2);
end logic_gates;

