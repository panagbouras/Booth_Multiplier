vsim work.multiplier(booth_multiplier)

--Example of 8 bits: 

--10001101 × 11110011= 1000010111010111
--141 × 243= 34263

force -freeze sim:/multiplier/InX 10001101 0
force -freeze sim:/multiplier/InY 11110011 0
add wave sim:/multiplier/*
run 100

--11111100 × 01101110= 110110001001000
--252 × 110=27720

force -freeze sim:/multiplier/InX 11111100 0
force -freeze sim:/multiplier/InY 01101110 0
run 100

--11111000 × 00011111= 1111000001000
--248 × 31= 7688


force -freeze sim:/multiplier/InX 11111000 0
force -freeze sim:/multiplier/InY 00011111 0
run 100


--11111111 × 11111111= 1111111000000001
--255 × 255= 65025

force -freeze sim:/multiplier/InX 11111111 0
force -freeze sim:/multiplier/InY 11111111 0
run 100


--11111111 × 00000000= 0
--255 × 0= 0


force -freeze sim:/multiplier/InX 11111111 0
force -freeze sim:/multiplier/InY 00000000 0
run 100
