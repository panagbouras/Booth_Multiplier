vsim -gui work.booth_encoder(logic_gates)

force -freeze sim:/booth_encoder/Input(2) 0 0, 1 {200 ps} -r 400
force -freeze sim:/booth_encoder/Input(1) 0 0, 1 {100 ps} -r 200
force -freeze sim:/booth_encoder/Input(0) 0 0, 1 {50 ps} -r 100
add wave sim:/booth_encoder/*

run 400