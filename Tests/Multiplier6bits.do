vsim work.multiplier(booth_multiplier)
 add wave sim:/multiplier/InX
 add wave sim:/multiplier/InY
 add wave sim:/multiplier/Output


--111110000001
 force -freeze sim:/multiplier/InX 111111 0
 force -freeze sim:/multiplier/InY 111111 0
 run 600
 
 --00000000000
 force -freeze sim:/multiplier/InX 000000 0
 force -freeze sim:/multiplier/InY 000000 0
 run 600
 
  --00000000000
 force -freeze sim:/multiplier/InX 000000 0
 force -freeze sim:/multiplier/InY 111111 0
 run 600
 
 --001011111101
 force -freeze sim:/multiplier/InX 110011 0
 force -freeze sim:/multiplier/InY 001111 0
 run 600

 --110010001101
 force -freeze sim:/multiplier/InX 110011 0
 force -freeze sim:/multiplier/InY 111111 0
 run 600

 --000010100101
 force -freeze sim:/multiplier/InX 000011 0
 force -freeze sim:/multiplier/InY 110111 0
 run 600
