onerror {quit -f}
vlib work
vlog -work work CPU8.vo
vlog -work work CPU8.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.CPU8_vlg_vec_tst
vcd file -direction CPU8.msim.vcd
vcd add -internal CPU8_vlg_vec_tst/*
vcd add -internal CPU8_vlg_vec_tst/i1/*
add wave /*
run -all
