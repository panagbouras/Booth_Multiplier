vsim -gui work.booth_selector(logic_gates)

force -freeze sim:/booth_selector/NEG 0 0, 1 {100 ps} -r 200
force -freeze sim:/booth_selector/DOUBLE 0 0, 1 {200 ps} -r 400
force -freeze sim:/booth_selector/SINGLE 0 0, 1 {400 ps} -r 800
force -freeze sim:/booth_selector/InY 01110000 0
add wave sim:/booth_selector/*

run 700