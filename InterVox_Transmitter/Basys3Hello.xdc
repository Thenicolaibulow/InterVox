# Clock pin
set_property PACKAGE_PIN N1 [get_ports {clock}]
set_property IOSTANDARD LVCMOS33 [get_ports {clock}]
set_property PACKAGE_PIN T17 [get_ports reset]


# I2S Pins: 
#set_property PACKAGE_PIN N1     [get_ports {io_MCLK_IN}]
set_property PACKAGE_PIN N2     [get_ports {io_BCLK_IN}]
set_property PACKAGE_PIN M1     [get_ports {io_LRCLK_IN}]
set_property PACKAGE_PIN M2     [get_ports {io_SDATA_IN}]
set_property PACKAGE_PIN P17    [get_ports {io_SDATA_O}]
set_property PACKAGE_PIN N17    [get_ports {io_LRCLK_O}]
set_property PACKAGE_PIN P18    [get_ports {io_BCLK_O}]
set_property PACKAGE_PIN R18    [get_ports {io_MCLK_O}]

# Intervox Pins:
set_property PACKAGE_PIN K3      [get_ports {io_NXT_FRAME}]
set_property PACKAGE_PIN J3      [get_ports {io_DATA_O}]

# Clock constraints
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]