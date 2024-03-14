onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SystemTestBench_load_store/Clock
add wave -noupdate /SystemTestBench_load_store/clear
add wave -noupdate /SystemTestBench_load_store/inport_data
add wave -noupdate /SystemTestBench_load_store/HIout
add wave -noupdate /SystemTestBench_load_store/LOout
add wave -noupdate /SystemTestBench_load_store/Zhi_out
add wave -noupdate /SystemTestBench_load_store/Zlo_out
add wave -noupdate /SystemTestBench_load_store/PCout
add wave -noupdate /SystemTestBench_load_store/MDRout
add wave -noupdate /SystemTestBench_load_store/Inport_out
add wave -noupdate /SystemTestBench_load_store/Cout
add wave -noupdate /SystemTestBench_load_store/MARin
add wave -noupdate /SystemTestBench_load_store/Zin
add wave -noupdate /SystemTestBench_load_store/PCin
add wave -noupdate /SystemTestBench_load_store/MDRin
add wave -noupdate /SystemTestBench_load_store/IRin
add wave -noupdate /SystemTestBench_load_store/Yin
add wave -noupdate /SystemTestBench_load_store/HIin
add wave -noupdate /SystemTestBench_load_store/LOin
add wave -noupdate /SystemTestBench_load_store/CONin
add wave -noupdate /SystemTestBench_load_store/outport_in
add wave -noupdate /SystemTestBench_load_store/inport_data_ready
add wave -noupdate /SystemTestBench_load_store/opcode
add wave -noupdate /SystemTestBench_load_store/IncPC
add wave -noupdate /SystemTestBench_load_store/Gra
add wave -noupdate /SystemTestBench_load_store/Grb
add wave -noupdate /SystemTestBench_load_store/Grc
add wave -noupdate /SystemTestBench_load_store/Rin
add wave -noupdate /SystemTestBench_load_store/Rout
add wave -noupdate /SystemTestBench_load_store/BAout
add wave -noupdate /SystemTestBench_load_store/Mem_Read
add wave -noupdate /SystemTestBench_load_store/Mem_Write
add wave -noupdate /SystemTestBench_load_store/Mem_enable512x32
add wave -noupdate /SystemTestBench_load_store/mem_overide
add wave -noupdate /SystemTestBench_load_store/overide_address
add wave -noupdate /SystemTestBench_load_store/overide_data_in
add wave -noupdate /SystemTestBench_load_store/outport_data
add wave -noupdate -radix hexadecimal /SystemTestBench_load_store/Mem_to_datapath
add wave -noupdate -radix hexadecimal /SystemTestBench_load_store/Mem_data_to_chip
add wave -noupdate -radix unsigned /SystemTestBench_load_store/MAR_address
add wave -noupdate /SystemTestBench_load_store/con_ff_bit
add wave -noupdate /SystemTestBench_load_store/memory_done
add wave -noupdate -radix unsigned /SystemTestBench_load_store/Present_state
add wave -noupdate -radix hexadecimal {/SystemTestBench_load_store/UUT/memory512x32/FullMemorySpace[149]}
add wave -noupdate -radix hexadecimal {/SystemTestBench_load_store/UUT/memory512x32/FullMemorySpace[135]}
add wave -noupdate -radix hexadecimal {/SystemTestBench_load_store/UUT/memory512x32/FullMemorySpace[75]}
add wave -noupdate -radix hexadecimal /SystemTestBench_load_store/UUT/datapath/R0/q
add wave -noupdate -radix hexadecimal /SystemTestBench_load_store/UUT/datapath/R2/q
add wave -noupdate /SystemTestBench_load_store/UUT/datapath/IR/q
add wave -noupdate /SystemTestBench_load_store/UUT/datapath/PC/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {208611 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 419
configure wave -valuecolwidth 92
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
WaveRestoreZoom {0 ps} {345884 ps}
