# Clock pin
set_property PACKAGE_PIN W5 [get_ports {clock}]
set_property IOSTANDARD LVCMOS33 [get_ports {clock}]

# LEDs
set_property PACKAGE_PIN N1     [get_ports {io_MCLK_IN}]
set_property PACKAGE_PIN N2     [get_ports {io_BCLK_IN}]
set_property PACKAGE_PIN M1     [get_ports {io_LRCLK_IN}]
set_property PACKAGE_PIN M2     [get_ports {io_SDATA_IN}]
set_property PACKAGE_PIN J3     [get_ports {io_DATA_O}]

# Switches
set_property PACKAGE_PIN V17    [get_ports {io_sw[0]}]
set_property PACKAGE_PIN V16    [get_ports {io_sw[1]}]
set_property PACKAGE_PIN W16    [get_ports {io_sw[2]}]
set_property PACKAGE_PIN W17    [get_ports {io_sw[3]}]
set_property PACKAGE_PIN W15    [get_ports {io_sw[4]}]
set_property PACKAGE_PIN V15    [get_ports {io_sw[5]}]
set_property PACKAGE_PIN W14    [get_ports {io_sw[6]}]
set_property PACKAGE_PIN W13    [get_ports {io_sw[7]}]
set_property PACKAGE_PIN V2     [get_ports {io_sw[8]}]
set_property PACKAGE_PIN T3     [get_ports {io_sw[9]}]
set_property PACKAGE_PIN T2     [get_ports {io_sw[10]}]
set_property PACKAGE_PIN R3     [get_ports {io_sw[11]}]
set_property PACKAGE_PIN W2     [get_ports {io_sw[12]}]
set_property PACKAGE_PIN U1     [get_ports {io_sw[13]}]
set_property PACKAGE_PIN T1     [get_ports {io_sw[14]}]
set_property PACKAGE_PIN R2     [get_ports {io_sw[15]}]

set_property PACKAGE_PIN T17 [get_ports reset]

# Clock constraints
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]