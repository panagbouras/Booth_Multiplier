vsim -gui work.wallace_8bits

add wave InputX
add wave InputY
add wave Output

--Output: 0100000101011011
force -freeze sim:/wallace_8bits/InputX 10001111 0
force -freeze sim:/wallace_8bits/InputY 01110101 0
run 500

--Output: 1111111000000001
force -freeze sim:/wallace_8bits/InputX 11111111 0
force -freeze sim:/wallace_8bits/InputY 11111111 0
run 500

--Output: 1000010001011100
force -freeze sim:/wallace_8bits/InputX 11000101 0
force -freeze sim:/wallace_8bits/InputY 10101100 0
run 500

--Output: 
force -freeze sim:/wallace_8bits/InputX 10011101 0
force -freeze sim:/wallace_8bits/InputY 10101110 0
run 500

--Output: 0110101010110110
force -freeze sim:/wallace_8bits/InputX 10101010 0
force -freeze sim:/wallace_8bits/InputY 10101010 0
run 500

--Output: 0101110101110
force -freeze sim:/wallace_8bits/InputX 00101110 0
force -freeze sim:/wallace_8bits/InputY 01000001 0
run 500

--Output: 
force -freeze sim:/wallace_8bits/InputX 10000001 0
force -freeze sim:/wallace_8bits/InputY 00001111 0
run 500

--Output: 
force -freeze sim:/wallace_8bits/InputX 01010101 0
force -freeze sim:/wallace_8bits/InputY 10101010 0
run 500

--Output: 
force -freeze sim:/wallace_8bits/InputX 11110000 0
force -freeze sim:/wallace_8bits/InputY 00101000 0
run 500

--Output: 
force -freeze sim:/wallace_8bits/InputX 00000010 0
force -freeze sim:/wallace_8bits/InputY 00100001 0
run 500

