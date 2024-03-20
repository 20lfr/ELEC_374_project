onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench_ALU/Clock
add wave -noupdate /SystemTestBench_ALU/clear
add wave -noupdate /SystemTestBench_ALU/inport_data
add wave -noupdate /SystemTestBench_ALU/HIout
add wave -noupdate /SystemTestBench_ALU/LOout
add wave -noupdate /SystemTestBench_ALU/Zhi_out
add wave -noupdate /SystemTestBench_ALU/Zlo_out
add wave -noupdate /SystemTestBench_ALU/PCout
add wave -noupdate /SystemTestBench_ALU/MDRout
add wave -noupdate /SystemTestBench_ALU/Inport_out
add wave -noupdate /SystemTestBench_ALU/Cout
add wave -noupdate /SystemTestBench_ALU/MARin
add wave -noupdate /SystemTestBench_ALU/Zin
add wave -noupdate /SystemTestBench_ALU/PCin
add wave -noupdate /SystemTestBench_ALU/MDRin
add wave -noupdate /SystemTestBench_ALU/IRin
add wave -noupdate /SystemTestBench_ALU/Yin
add wave -noupdate /SystemTestBench_ALU/HIin
add wave -noupdate /SystemTestBench_ALU/LOin
add wave -noupdate /SystemTestBench_ALU/CONin
add wave -noupdate /SystemTestBench_ALU/outport_in
add wave -noupdate /SystemTestBench_ALU/inport_data_ready
add wave -noupdate /SystemTestBench_ALU/opcode
add wave -noupdate /SystemTestBench_ALU/IncPC
add wave -noupdate /SystemTestBench_ALU/Gra
add wave -noupdate /SystemTestBench_ALU/Grb
add wave -noupdate /SystemTestBench_ALU/Grc
add wave -noupdate /SystemTestBench_ALU/Rin
add wave -noupdate /SystemTestBench_ALU/Rout
add wave -noupdate /SystemTestBench_ALU/BAout
add wave -noupdate /SystemTestBench_ALU/Mem_read
add wave -noupdate /SystemTestBench_ALU/Mem_Write
add wave -noupdate /SystemTestBench_ALU/Mem_enable512x32
add wave -noupdate /SystemTestBench_ALU/mem_overide
add wave -noupdate /SystemTestBench_ALU/overide_address
add wave -noupdate /SystemTestBench_ALU/overide_data_in
add wave -noupdate /SystemTestBench_ALU/outport_data
add wave -noupdate /SystemTestBench_ALU/Mem_to_datapath
add wave -noupdate /SystemTestBench_ALU/Mem_data_to_chip
add wave -noupdate /SystemTestBench_ALU/MAR_address
add wave -noupdate /SystemTestBench_ALU/con_ff_bit
add wave -noupdate /SystemTestBench_ALU/memory_done
add wave -noupdate /SystemTestBench_ALU/Present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1000014 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {999050 ps} {1000050 ps}
