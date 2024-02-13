transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Multiply {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Multiply/booth_mul_combinational.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/Bus_files {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/Bus_files/Bus_MUX.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/Bus_files {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/Bus_files/Bus_Encoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/shra.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/shr.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/shl.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/ror.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/rol.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/not_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/neg.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Logical_Operations/and_or.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Division {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Division/div_combinational.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction/CLA_b_cell.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction/CLA_32bit_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction/CLA_16bit_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction/CLA_4bit_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/Addition_and_Subtraction/add_sub.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/ALU_files/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/MDR.v}
vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/DataPath.v}

vlog -vlog01compat -work work +incdir+C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system {C:/Users/20lfr/Desktop/ELEC_374_project-luka-changes/374_LAB_system/tb_phase1.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_phase1

add wave *
view structure
view signals
run -all