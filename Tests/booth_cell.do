vsim -gui work.booth_cell(cascade_components)

--12 bits example
force -freeze sim:/booth_cell/InY 111111111111 0

--7 bits example
--force -freeze sim:/booth_cell/InY 1111111 0

--6 bits example
--force -freeze sim:/booth_cell/InY 101001 0

--5 bits example
--force -freeze sim:/booth_cell/InY 10001 0

force -freeze sim:/booth_cell/triad(0) 0 0, 1 {50 ps} -r 100
force -freeze sim:/booth_cell/triad(1) 0 0, 1 {100 ps} -r 200
force -freeze sim:/booth_cell/triad(2) 0 0, 1 {200 ps} -r 400
add wave sim:/booth_cell/*
run 400