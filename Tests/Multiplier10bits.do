vsim work.multiplier(booth_multiplier)
 add wave sim:/multiplier/InX
 add wave sim:/multiplier/InY
 add wave sim:/multiplier/Output


--11111111100000000001
 force -freeze sim:/multiplier/InX 1111111111 0
 force -freeze sim:/multiplier/InY 1111111111 0
 run 600
 
 --00000000000000000000
 force -freeze sim:/multiplier/InX 0000000000 0
 force -freeze sim:/multiplier/InY 0000000000 0
 run 600
 
  --00000000000000000000
 force -freeze sim:/multiplier/InX 0000000000 0
 force -freeze sim:/multiplier/InY 1111111110 0
 run 600
 
 --00101001111001011100
 force -freeze sim:/multiplier/InX 1010101001 0
 force -freeze sim:/multiplier/InY 0011111100 0
 run 600

 --11000101101110111111
 force -freeze sim:/multiplier/InX 1101111011 0
 force -freeze sim:/multiplier/InY 1110001101 0
 run 600

 --00001100111011100101
 force -freeze sim:/multiplier/InX 1111000011 0
 force -freeze sim:/multiplier/InY 0000110111 0
 run 600
