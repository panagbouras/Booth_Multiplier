library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
use IEEE.numeric_std.all;

entity wallace_tree is
	generic (n:integer:=8);
	port(Input: in std_logic_vector(((n+5)*(integer(((n-(n mod 2))+3)/2))-6) downto 0);
		Output: out std_logic_vector(2*n-1 downto 0));
end wallace_tree;


architecture circuit of wallace_tree is 

component CSA is
	generic (n: integer);
	port( 	In1: in std_logic_vector(n-1 downto 0);
			In2: in std_logic_vector(n-1 downto 0);
			In3: in std_logic_vector(n-1 downto 0);
			Sums: out std_logic_vector(n-1 downto 0);
			Carries: out std_logic_vector(n-1 downto 0));
end component;

component CPA is
	generic (n:integer);
	port( 	In1: in std_logic_vector(n-1 downto 0);
			In2: in std_logic_vector(n-1 downto 0);
			Sum: out std_logic_vector(n-1 downto 0));
end component;

constant number_of_PPs: integer := (integer(((n-(n mod 2))+3)/2));
constant wallace_tree_levels: integer:= (integer(ceil((log2(Real(number_of_PPs))-real(1))/(log2(real(3))-real(1)))));

type rows_array is array (0 to (wallace_tree_levels),0 to (number_of_PPs-1)) of std_logic_vector(2*n-1 downto 0);
signal rows: rows_array;

--create a constant array of How many Variables per level
type Var_levels is array (0 to (wallace_tree_levels-1)) of integer;

--Find how many Partial Products are in every level:
function Genetate_Var_per_level return Var_levels is
	variable temp:Var_levels;
	begin
	temp(0):=number_of_PPs;
		forLoop: for i in 0 to wallace_tree_levels-1-1 loop
				temp(i+1):=2*Integer(temp(i)/3)+(temp(i) mod 3);
		end loop forLoop;
		return temp;
	end function Genetate_Var_per_level;
constant Var_per_level: Var_levels:=Genetate_Var_per_level;

begin

	-- Create All Partial Products:
	rows(0,0)(n+3 downto 0)<=Input(n+3 downto 0);
	rows(0,0)(2*n-1 downto n+4)<=(others=>'0');
	
	rows(0,1)(n+4 downto 0)<=Input(2*n+8 downto n+4);
	rows(0,1)(2*n-1 downto n+5)<=(others=>'0');

	Generate_rows:
 	 for i in 2 to (number_of_PPs-3) generate
		 rows(0,i)((2*i+n+2) downto (2*(i-1)))<= Input(((n+4)*(i+1)+(i-1)) downto ((n+4)*i+(i-1)));
		rows(0,i)(2*n-1 downto (2*i+n+3))<=(others=>'0');
		rows(0,i)((2*(i-1)-1) downto 0)<=(others=>'0');
	 end generate;
	
	rows(0,number_of_PPs-2)(2*n-1 downto n-4)<=Input((((n+5)*number_of_PPs-5)-n-3) downto (((n+5)*number_of_PPs-5)-2*(n+3)));
	rows(0,number_of_PPs-2)(n-5 downto 0)<=(others=>'0');
	rows(0,number_of_PPs-1)(2*n-1 downto n-2)<=Input(((n+5)*number_of_PPs-6) downto (((n+5)*number_of_PPs-5)-n-2));
	rows(0,number_of_PPs-1)(n-3 downto 0)<=(others=>'0');

	--Create First Level
	GenerateFirstLevel:
	for i in 0 to integer(ceil(real(number_of_PPs)/real(3)))-2 generate
		--First Level of Partial Producys
		CSA: entity work.CSA(rtl) generic map(2*n) port map(rows(0,i*3),rows(0,i*3+1),rows(0,i*3+2),rows(1,i*2),rows(1,i*2+1));
		
		--This loop is used when there are no more 3 combination
		EndLoop:
		if(i=(integer(ceil(real(number_of_PPs)/real(3)))-2)) generate
			--Loop if 3^n values: 3,6,9,12 
			Mod3: 
			if((number_of_PPs mod 3)=0) generate
				CSA_1: entity work.CSA(rtl) generic map(2*n) port map(rows(0,(i+1)*3),rows(0,(i+1)*3+1),rows(0,(i+1)*3+2),rows(1,i*2+2),rows(1,2*i+3));
			end generate Mod3;
			
			--Loop for 1 extra unused Partial Product
			Extra1Values: if((number_of_PPs mod 3)=1) generate
				rows(1,i*2+2)<=rows(0,number_of_PPs-1);
			end generate Extra1Values;

			--Loop for 2 extra unused Partial Products
			Extra2Values: if((number_of_PPs mod 3)=2) generate
				rows(1,i*2+2)<=rows(0,number_of_PPs-2);
				rows(1,i*2+3)<=rows(0,number_of_PPs-1);
			end generate Extra2Values;
		end generate EndLoop;
	end generate GenerateFirstLevel;

	--Create All Levels
	GenerateWallaceTree:
	for k in 1 to wallace_tree_levels-1 generate
			GenerateLevel:
			for i in 0 to integer(ceil(real(Var_per_level(k))/real(3)))-2 generate
				CSA: entity work.CSA(rtl) generic map(2*n) port map(rows(k,i*3),rows(k,i*3+1),rows(k,i*3+2),rows(k+1,i*2),rows(k+1,i*2+1));
				
				--This loop is used when there are no more 3 combination
				EndLoop:
				if(i=(integer(ceil(real(Var_per_level(k))/real(3)))-2)) generate

					--Loop if 3^n values: 3,6,9,12 
					Mod3: 
					if((Var_per_level(k) mod 3)=0) generate
						CSA_1: entity work.CSA(rtl) generic map(2*n) port map(rows(k,(i+1)*3),rows(k,(i+1)*3+1),rows(k,(i+1)*3+2),rows(k+1,2*(i+1)),rows(k+1,(i+1)*2+1));
					end generate Mod3;

					--Loop for 1 extra unused Partial Product
					Extra1Values: if((Var_per_level(k) mod 3)=1) generate
						rows(k+1,2*i+2)<=rows(k,Var_per_level(k)-1);
					end generate Extra1Values;

					--Loop for 2 extra unused Partial Products
					Extra2Values: if((Var_per_level(k) mod 3)=2) generate
						rows(k+1,2*i+2)<=rows(k,Var_per_level(k)-2);
						rows(k+1,2*i+3)<=rows(k,Var_per_level(k)-1);
					end generate Extra2Values;
			end generate EndLoop;
		end generate GenerateLevel;
	end generate GenerateWallaceTree;
	
	---Calculate last Level:
	CSA_1: entity work.CSA(rtl) generic map(2*n) port map(rows(wallace_tree_levels-1,0),rows(wallace_tree_levels-1,1),rows(wallace_tree_levels-1,2),rows(wallace_tree_levels,0),rows(wallace_tree_levels,1));
	
	RCA: entity work.CPA(RCA) generic map (2*n) port map(rows((wallace_tree_levels),0),rows((wallace_tree_levels),1),Output);

end circuit;
