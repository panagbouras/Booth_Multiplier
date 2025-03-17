vsim work.multiplier(booth_multiplier)
 add wave sim:/multiplier/InX
 add wave sim:/multiplier/InY
 add wave sim:/multiplier/Output


--111111111110000000000001
 force -freeze sim:/multiplier/InX 111111111111 0
 force -freeze sim:/multiplier/InY 111111111111 0
 run 600
 
 --000000000000000000000000
 force -freeze sim:/multiplier/InX 000000000000 0
 force -freeze sim:/multiplier/InY 000000000000 0
 run 600
 
  --000000000000000000000000
 force -freeze sim:/multiplier/InX 000000000000 0
 force -freeze sim:/multiplier/InY 111111100110 0
 run 600
 
 --100000111011011001011100
 force -freeze sim:/multiplier/InX 111010101001 0
 force -freeze sim:/multiplier/InY 100011111100 0
 run 600

 --110001101111100101101111
 force -freeze sim:/multiplier/InX 110111001011 0
 force -freeze sim:/multiplier/InY 111001101101 0
 run 600

 --0f01010010000011011100101
 force -freeze sim:/multiplier/InX 110011000011 0
 force -freeze sim:/multiplier/InY 001100110111 0
 run 600
