transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project/System/Control_unit_partition {C:/Users/20lfr/Desktop/ELEC_374_project/System/Control_unit_partition/Control.v}

vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project/System {C:/Users/20lfr/Desktop/ELEC_374_project/System/Testbench_CONTROL.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Testbench_CONTROL

add wave *
view structure
view signals
run 2000 ns
