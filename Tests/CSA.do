vsim work.CSA(rtl)
add wave In1
add wave In2
add wave In3
add wave Sums
add wave Carries

--1 
force In1 1100110000111001
force In2 0011110001110101
force In3 1001011111001100
run 100

--2 
force In1 1100110000111001
force In2 1100101011100010
force In3 0111111110001110
run 100

--3 
force In1 1100010100111111
force In2 1111100010001111
force In3 0101011100011100
run 100
