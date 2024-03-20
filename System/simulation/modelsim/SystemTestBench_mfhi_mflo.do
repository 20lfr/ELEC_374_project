onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench_mfhi_mflo/Clock
add wave -noupdate /SystemTestBench_mfhi_mflo/clear
add wave -noupdate /SystemTestBench_mfhi_mflo/inport_data
add wave -noupdate /SystemTestBench_mfhi_mflo/HIout
add wave -noupdate /SystemTestBench_mfhi_mflo/LOout
add wave -noupdate /SystemTestBench_mfhi_mflo/Zhi_out
add wave -noupdate /SystemTestBench_mfhi_mflo/Zlo_out
add wave -noupdate /SystemTestBench_mfhi_mflo/PCout
add wave -noupdate /SystemTestBench_mfhi_mflo/MDRout
add wave -noupdate /SystemTestBench_mfhi_mflo/Inport_out
add wave -noupdate /SystemTestBench_mfhi_mflo/Cout
add wave -noupdate /SystemTestBench_mfhi_mflo/MARin
add wave -noupdate /SystemTestBench_mfhi_mflo/Zin
add wave -noupdate /SystemTestBench_mfhi_mflo/PCin
add wave -noupdate /SystemTestBench_mfhi_mflo/MDRin
add wave -noupdate /SystemTestBench_mfhi_mflo/IRin
add wave -noupdate /SystemTestBench_mfhi_mflo/Yin
add wave -noupdate /SystemTestBench_mfhi_mflo/HIin
add wave -noupdate /SystemTestBench_mfhi_mflo/LOin
add wave -noupdate /SystemTestBench_mfhi_mflo/CONin
add wave -noupdate /SystemTestBench_mfhi_mflo/outport_in
add wave -noupdate /SystemTestBench_mfhi_mflo/inport_data_ready
add wave -noupdate /SystemTestBench_mfhi_mflo/opcode
add wave -noupdate /SystemTestBench_mfhi_mflo/IncPC
add wave -noupdate /SystemTestBench_mfhi_mflo/Gra
add wave -noupdate /SystemTestBench_mfhi_mflo/Grb
add wave -noupdate /SystemTestBench_mfhi_mflo/Grc
add wave -noupdate /SystemTestBench_mfhi_mflo/Rin
add wave -noupdate /SystemTestBench_mfhi_mflo/Rout
add wave -noupdate /SystemTestBench_mfhi_mflo/BAout
add wave -noupdate /SystemTestBench_mfhi_mflo/Mem_Read
add wave -noupdate /SystemTestBench_mfhi_mflo/Mem_Write
add wave -noupdate /SystemTestBench_mfhi_mflo/Mem_enable512x32
add wave -noupdate /SystemTestBench_mfhi_mflo/mem_overide
add wave -noupdate /SystemTestBench_mfhi_mflo/overide_address
add wave -noupdate /SystemTestBench_mfhi_mflo/overide_data_in
add wave -noupdate /SystemTestBench_mfhi_mflo/outport_data
add wave -noupdate /SystemTestBench_mfhi_mflo/Mem_to_datapath
add wave -noupdate /SystemTestBench_mfhi_mflo/Mem_data_to_chip
add wave -noupdate /SystemTestBench_mfhi_mflo/MAR_address
add wave -noupdate /SystemTestBench_mfhi_mflo/con_ff_bit
add wave -noupdate /SystemTestBench_mfhi_mflo/memory_done
add wave -noupdate -radix unsigned /SystemTestBench_mfhi_mflo/Present_state
add wave -noupdate /SystemTestBench_mfhi_mflo/UUT/datapath/R6/q
add wave -noupdate /SystemTestBench_mfhi_mflo/UUT/datapath/R7/q
add wave -noupdate /SystemTestBench_mfhi_mflo/UUT/datapath/HI/q
add wave -noupdate /SystemTestBench_mfhi_mflo/UUT/datapath/LO/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {999177 ps} 0}
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
