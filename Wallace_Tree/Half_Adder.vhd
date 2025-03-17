library ieee;
	use ieee.std_logic_1164.all;


entity Half_Adder is
	port( A, B: in std_logic;
		  Sum, Carry_out: out std_logic);
			
end Half_Adder;


architecture logic_gates of Half_Adder is 
	begin
	Sum <= A xor B;
	Carry_out <= A and B;

end logic_gates;
