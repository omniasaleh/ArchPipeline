vsim -gui work.decode
# vsim -gui work.decode 
# Start time: 15:13:48 on Apr 25,2018
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.decode(flowdecode)
# Loading work.control(flowcontrol)
# Loading work.registerfiledecoding(dataflow)
# Loading work.my_ndffrising(a_my_ndff)
add wave -position insertpoint  \
sim:/decode/Clk \
sim:/decode/Rst \
sim:/decode/flagC \
sim:/decode/flagN \
sim:/decode/flagZ \
sim:/decode/stall \
sim:/decode/wB1 \
sim:/decode/wb2 \
sim:/decode/FEDE \
sim:/decode/writeadd1 \
sim:/decode/writeadd2 \
sim:/decode/outSignal \
sim:/decode/aluoperation \
sim:/decode/data1 \
sim:/decode/data2 \
sim:/decode/outadd2 \
sim:/decode/outadd1 \
sim:/decode/inportdata \
sim:/decode/immforldm


add wave -position insertpoint sim:/decode/registerfile/r5/q
add wave -position insertpoint sim:/decode/registerfile/r4/q
add wave -position insertpoint sim:/decode/registerfile/r3/q
add wave -position insertpoint sim:/decode/registerfile/r2/q
add wave -position insertpoint sim:/decode/registerfile/r1/q
add wave -position insertpoint sim:/decode/registerfile/r0/q

force -freeze sim:/decode/Clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/decode/Rst 1 0
run
# mov
force -freeze sim:/decode/Rst 0 0
force -freeze sim:/decode/wb1 1 0
force -freeze sim:/decode/wb2 1 0
force -freeze sim:/decode/writeadd1 100 0
force -freeze sim:/decode/writeadd2 101 0
force -freeze sim:/decode/indata1 0100000000000000 0
force -freeze sim:/decode/indata2 0100100000110001 0
force -freeze sim:/decode/FEDE 001000000000010000110000000 0
force -freeze sim:/decode/stall 0 0
force -freeze sim:/decode/flagn 0 0
force -freeze sim:/decode/flagc 1 0
force -freeze sim:/decode/flagz 1 0
force -freeze sim:/decode/immforldm 0001100110010001 0
force -freeze sim:/decode/inportdata 0001100110010001 0
run
add wave -position insertpoint sim:/decode/controlunit/*
# nop
force -freeze sim:/decode/wb1 1 0
force -freeze sim:/decode/wb2 0 0
force -freeze sim:/decode/writeadd1 001 0
force -freeze sim:/decode/FEDE 001000000000011111101000000 0
run

#ldm
force -freeze sim:/decode/wb1 0 0
force -freeze sim:/decode/FEDE 001000000000011100000001000 0
run
# outport
force -freeze sim:/decode/FEDE 001000000000010011100010000 0
run
# inport r3
#add wave -position insertpoint sim:/decode/controlunit/*
force -freeze sim:/decode/inportdata 0100000000000000 0
force -freeze sim:/decode/FEDE 001000000000011101100100000 0 
run
# sub r0,r5
force -freeze sim:/decode/FEDE 001000000000100010101000000 0 
force -freeze sim:/decode/wb1 1 0
force -freeze sim:/decode/writeadd1 011 0
force -freeze sim:/decode/indata1 0100000000000000 0
run
# mul r0,r5
force -freeze sim:/decode/FEDE 001000000000100010100110000 0 
run
# setc
force -freeze sim:/decode/FEDE 001000000000111111111100000 0 
run
# clrc
force -freeze sim:/decode/FEDE 001000000000111111111110000 0 
run
# not r4
force -freeze sim:/decode/FEDE 001000000000111110010110000 0 
run
# or r2,r4
force -freeze sim:/decode/FEDE 001000000000101010001100000 0 
run
# shfl r2,r4 15
force -freeze sim:/decode/FEDE 001000000000101010010001111 0 
run
# shfr r2,r4 14
force -freeze sim:/decode/FEDE 001000000000101010010011110 0 
run

# load r2,14
force -freeze sim:/decode/FEDE 001000000001001000000011101 0 
run
# store r2,14
force -freeze sim:/decode/FEDE 001000000001001000000011100 0 
run

# ret
force -freeze sim:/decode/FEDE 001000000001111110000011000 0 
run
# retI
force -freeze sim:/decode/FEDE 001000000001111100000011100 0 
run
# jmp r3
force -freeze sim:/decode/FEDE 001000000001101101000011000 0 
run
# jc r5
force -freeze sim:/decode/FEDE 001000000001110101000010000 0 
run
# jz r5
force -freeze sim:/decode/FEDE 001000000001110101000000000 0 
run
# jn r5
force -freeze sim:/decode/FEDE 001000000001110101000001000 0 
run
# call r0
force -freeze sim:/decode/FEDE 001000000001100000100011000 0 
run
# pop r2
force -freeze sim:/decode/FEDE 001000000001101000010011000 0 
run
# push r2
force -freeze sim:/decode/FEDE 001000000001101000001011000 0 
run

# int
force -freeze sim:/decode/FEDE 101000000001111100000111000 0 
run