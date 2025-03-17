vsim -gui work.and_onemany(for_generate)

force -freeze sim:/and_onemany/InOne 0 0, 1 {250 ps} -r 500
force -freeze sim:/and_onemany/InMany 11110000 0
add wave sim:/and_onemany/*

run 500