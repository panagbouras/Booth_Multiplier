vsim -gui work.booth_circuit(circuit)


--Example of 12 bits
force -freeze sim:/booth_circuit/InX 111111111111 0
force -freeze sim:/booth_circuit/InY 111111111111 0
add wave sim:/booth_circuit/*
run 600

--Example of 10 bits
--force -freeze sim:/booth_circuit/InX 0101010101 0
--force -freeze sim:/booth_circuit/InY 1100111100 0
--add wave sim:/booth_circuit/*
--run 600

--Example of 8 bits
--force -freeze sim:/booth_circuit/InX 10001111 0
--force -freeze sim:/booth_circuit/InY 01110000 0
--add wave sim:/booth_circuit/*
--run 600

--Example of 6 bits
--force -freeze sim:/booth_circuit/InX 111111 0
--force -freeze sim:/booth_circuit/InY 101001 0
--add wave sim:/booth_circuit/*
--run 600



