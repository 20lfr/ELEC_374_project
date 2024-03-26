onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Testbench_CONTROL/clk
add wave -noupdate /Testbench_CONTROL/reset
add wave -noupdate /Testbench_CONTROL/stop
add wave -noupdate /Testbench_CONTROL/Interupts
add wave -noupdate /Testbench_CONTROL/IR
add wave -noupdate /Testbench_CONTROL/con_ff_bit
add wave -noupdate /Testbench_CONTROL/run
add wave -noupdate /Testbench_CONTROL/clear
add wave -noupdate /Testbench_CONTROL/ALU_opcode
add wave -noupdate /Testbench_CONTROL/IncPC
add wave -noupdate /Testbench_CONTROL/HIout
add wave -noupdate /Testbench_CONTROL/LOout
add wave -noupdate /Testbench_CONTROL/Zhi_out
add wave -noupdate /Testbench_CONTROL/Zlo_out
add wave -noupdate /Testbench_CONTROL/PCout
add wave -noupdate /Testbench_CONTROL/MDRout
add wave -noupdate /Testbench_CONTROL/Inport_out
add wave -noupdate /Testbench_CONTROL/Cout
add wave -noupdate /Testbench_CONTROL/MARin
add wave -noupdate /Testbench_CONTROL/Zin
add wave -noupdate /Testbench_CONTROL/PCin
add wave -noupdate /Testbench_CONTROL/MDRin
add wave -noupdate /Testbench_CONTROL/IRin
add wave -noupdate /Testbench_CONTROL/Yin
add wave -noupdate /Testbench_CONTROL/HIin
add wave -noupdate /Testbench_CONTROL/LOin
add wave -noupdate /Testbench_CONTROL/CONin
add wave -noupdate /Testbench_CONTROL/outport_in
add wave -noupdate /Testbench_CONTROL/Mem_Read
add wave -noupdate /Testbench_CONTROL/Mem_Write
add wave -noupdate /Testbench_CONTROL/Mem_enable512x32
add wave -noupdate /Testbench_CONTROL/Gra
add wave -noupdate /Testbench_CONTROL/Grb
add wave -noupdate /Testbench_CONTROL/Grc
add wave -noupdate /Testbench_CONTROL/Rin
add wave -noupdate /Testbench_CONTROL/Rout
add wave -noupdate /Testbench_CONTROL/BAout
add wave -noupdate -radix unsigned /Testbench_CONTROL/Present_state
add wave -noupdate -radix unsigned /Testbench_CONTROL/uut/present_state
add wave -noupdate /Testbench_CONTROL/uut/T0
add wave -noupdate /Testbench_CONTROL/uut/T1
add wave -noupdate /Testbench_CONTROL/uut/T2
add wave -noupdate /Testbench_CONTROL/uut/T3
add wave -noupdate /Testbench_CONTROL/uut/T4
add wave -noupdate /Testbench_CONTROL/uut/T5
add wave -noupdate /Testbench_CONTROL/uut/T6
add wave -noupdate /Testbench_CONTROL/uut/T7
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {290000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 258
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {980086 ps}
