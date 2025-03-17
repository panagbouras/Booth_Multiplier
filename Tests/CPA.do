vsim -gui work.CPA(RCA)
add wave sim:/CPA/*

--1
force In1 11111111 0
force In2 11111111 0
run 100

--2
force In1 10000101 0
force In2 01010101 0
run 100

--3
force In1 00010011 0
force In2 11110000 0
run 100

--4
force In1 00000000 0
force In2 00000000 0
run 100

--5
force In1 11010111 0
force In2 01001111 0
run 100

