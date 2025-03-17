vsim -gui work.xor_onemany(for_generate)

force -freeze sim:/xor_onemany/InOne 0 0, 1 {250 ps} -r 500
force -freeze sim:/xor_onemany/InMany 11110000 0
add wave sim:/xor_onemany/*

run 500