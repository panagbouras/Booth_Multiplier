vsim work.multiplier(booth_multiplier)
 add wave sim:/multiplier/InX
 add wave sim:/multiplier/InY
 add wave sim:/multiplier/Output


 --11111111111111100000000000000001
 force -freeze sim:/multiplier/InX 1111111111111111 0
 force -freeze sim:/multiplier/InY 1111111111111111 0
 run 600
 
 --00000000000000000000000000000000
 force -freeze sim:/multiplier/InX 0000000000000000 0
 force -freeze sim:/multiplier/InY 0000000000000000 0
 run 600
 
  --00000000000000000000000000000000
 force -freeze sim:/multiplier/InX 0000000000000000 0
 force -freeze sim:/multiplier/InY 1111001111100110 0
 run 600
 
 --10100001110101001011100111111100
 force -freeze sim:/multiplier/InX 1110011010101001 0
 force -freeze sim:/multiplier/InY 1011001110011100 0
 run 600

 --110001101111100101101111
 force -freeze sim:/multiplier/InX 0000110111001011 0
 force -freeze sim:/multiplier/InY 0000111001101101 0
 run 600

 --11110000001000110110011011100101
 force -freeze sim:/multiplier/InX 1111110011000011 0
 force -freeze sim:/multiplier/InY 1111001100110111 0
 run 600
