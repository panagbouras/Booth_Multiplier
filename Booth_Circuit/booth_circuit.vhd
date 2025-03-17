library ieee;
use ieee.std_logic_1164.all;

entity booth_circuit is
	generic (n:integer:=12);
	port(	InX: in std_logic_vector(n-1 downto 0);
			InY: in std_logic_vector(n-1 downto 0);
			Output: out std_logic_vector(((n+5)*(integer((n+3)/2))-5-1) downto 0));
end booth_circuit;

architecture circuit of booth_circuit is

component booth_cell
	port(	triad: in std_logic_vector(2 downto 0);
			InY: in std_logic_vector(n-1 downto 0);
			s: out std_logic;
			Output: out std_logic_vector(n downto 0));
end component;


constant number_of_PPs: integer := integer(((n+3)/2));
signal InX_extension: std_logic_vector(n+2 downto 0);
signal s_table: std_logic_vector(number_of_PPs-1 downto 0);
signal PPs: std_logic_vector((n+1)*number_of_PPs-1 downto 0);
signal matrix: std_logic_vector(((n+5)*number_of_PPs-5) downto 0);
begin
	--Extension of the input
	InX_extension<="00"&InX&'0';
	
	--first booth_cell
	U1: entity work.booth_cell(cascade_components) generic map(n) port map(InX_extension(2 downto 0), InY, s_table(0), PPs(n downto 0));
	matrix(n+3 downto 0)<=not(s_table(0))&s_table(0)&s_table(0)&PPs(n downto 0);
	
	--booth cells created by a for loop
	generate_label:
		for i in 1 to (number_of_PPs-3) generate
			U2: entity work.booth_cell(cascade_components) generic map(n) port map(InX_extension((2*i+2) downto (2*i)), InY, s_table(i), PPs((n+(n+1)*i) downto ((n+1)*i)));
			matrix(((n+4)*(i+1)+(i-1)) downto ((n+4)*i+(i-1)))<= '1'&not(s_table(i))&PPs((n+(n+1)*i) downto ((n+1)*i))&'0'&s_table(i-1);
		end generate;
	--pre last booth_cell
	U3: entity work.booth_cell(cascade_components) generic map(n) port map(InX_extension(n downto n-2), InY, s_table(number_of_PPs-2), PPs(((n+1)*(number_of_PPs-1)-1) downto ((n+1)*(number_of_PPs-2))));
	matrix((((n+5)*number_of_PPs-5)-n-3) downto (((n+5)*number_of_PPs-5)-2*(n+3)))<= not(s_table(number_of_PPs-2))&PPs(((n+1)*(number_of_PPs-1)-1) downto ((n+1)*(number_of_PPs-2)))&'0'&s_table(number_of_PPs-3);
	
	--the last booth_cell
	U4: entity work.booth_cell(cascade_components) generic map(n) port map(InX_extension(n+2 downto n), InY, s_table(number_of_PPs-1), PPs(((n+1)*number_of_PPs-1) downto ((n+1)*(number_of_PPs-1))));
	matrix(((n+5)*number_of_PPs-5) downto (((n+5)*number_of_PPs-5)-n-2))<= PPs(((n+1)*number_of_PPs-1) downto ((n+1)*(number_of_PPs-1)))&'0'&s_table(number_of_PPs-2);
	
	Output(((n+5)*number_of_PPs-5-1) downto 0)<=matrix(((n+5)*number_of_PPs-5-1) downto 0);
end circuit;
