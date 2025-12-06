.DEFAULT_GOAL = default
	
default: $(SRCS)
	iverilog -o dump *.v
	vvp dump;gtkwave dump.vcd
