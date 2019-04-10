onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib IMem_opt

do {wave.do}

view wave
view structure
view signals

do {IMem.udo}

run -all

quit -force
