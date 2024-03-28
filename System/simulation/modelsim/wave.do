onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench/Clock
add wave -noupdate /SystemTestBench/Interupts
add wave -noupdate /SystemTestBench/reset
add wave -noupdate /SystemTestBench/stop
add wave -noupdate /SystemTestBench/inport_data_ready
add wave -noupdate /SystemTestBench/inport_data
add wave -noupdate /SystemTestBench/outport_data
add wave -noupdate /SystemTestBench/Present_state
add wave -noupdate /SystemTestBench/uut/control/S2
add wave -noupdate -radix unsigned /SystemTestBench/uut/control/present_state
add wave -noupdate /SystemTestBench/uut/control/T0
add wave -noupdate /SystemTestBench/uut/control/T1
add wave -noupdate /SystemTestBench/uut/control/T2
add wave -noupdate /SystemTestBench/uut/control/T3
add wave -noupdate /SystemTestBench/uut/control/T4
add wave -noupdate /SystemTestBench/uut/control/T5
add wave -noupdate /SystemTestBench/uut/control/T6
add wave -noupdate /SystemTestBench/uut/control/T7
add wave -noupdate /SystemTestBench/uut/control/S2
add wave -noupdate /SystemTestBench/uut/control/HIout
add wave -noupdate /SystemTestBench/uut/control/LOout
add wave -noupdate /SystemTestBench/uut/control/Zhi_out
add wave -noupdate /SystemTestBench/uut/control/Zlo_out
add wave -noupdate /SystemTestBench/uut/control/PCout
add wave -noupdate /SystemTestBench/uut/control/MDRout
add wave -noupdate /SystemTestBench/uut/control/Inport_out
add wave -noupdate /SystemTestBench/uut/control/Cout
add wave -noupdate /SystemTestBench/uut/control/MARin
add wave -noupdate /SystemTestBench/uut/control/Zin
add wave -noupdate /SystemTestBench/uut/control/PCin
add wave -noupdate /SystemTestBench/uut/control/MDRin
add wave -noupdate /SystemTestBench/uut/control/IRin
add wave -noupdate /SystemTestBench/uut/control/Yin
add wave -noupdate /SystemTestBench/uut/control/HIin
add wave -noupdate /SystemTestBench/uut/control/LOin
add wave -noupdate /SystemTestBench/uut/control/CONin
add wave -noupdate /SystemTestBench/uut/control/outport_in
add wave -noupdate /SystemTestBench/uut/control/ALU_opcode
add wave -noupdate /SystemTestBench/uut/control/IncPC
add wave -noupdate /SystemTestBench/uut/control/Gra
add wave -noupdate /SystemTestBench/uut/control/Grb
add wave -noupdate /SystemTestBench/uut/control/Grc
add wave -noupdate /SystemTestBench/uut/control/Rin
add wave -noupdate /SystemTestBench/uut/control/Rout
add wave -noupdate /SystemTestBench/uut/control/BAout
add wave -noupdate /SystemTestBench/uut/control/Mem_Read
add wave -noupdate /SystemTestBench/uut/control/Mem_Write
add wave -noupdate /SystemTestBench/uut/control/Mem_enable512x32
add wave -noupdate -radix binary /SystemTestBench/uut/control/IR
add wave -noupdate /SystemTestBench/uut/control/S6
add wave -noupdate /SystemTestBench/uut/control/LOAD_s
add wave -noupdate /SystemTestBench/uut/control/LOADI_s
add wave -noupdate -radix unsigned /SystemTestBench/uut/datapath/PC_BusMuxIn
add wave -noupdate /SystemTestBench/uut/control/BRANCH_s
add wave -noupdate /SystemTestBench/uut/control/con_ff_bit
add wave -noupdate /SystemTestBench/uut/control/NOP_s
add wave -noupdate /SystemTestBench/uut/control/HALT_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1761603 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 297
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
WaveRestoreZoom {879917 ps} {2105635 ps}
