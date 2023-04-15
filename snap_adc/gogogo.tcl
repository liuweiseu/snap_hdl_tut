set impl_dir "/data/Wei/casper_hdl/snap_tut/snap_adc/myproj/myproj.runs/impl_1"
set bin_file "/data/Wei/casper_hdl/snap_tut/snap_adc/myproj/myproj.runs/impl_1/top.bin"
set bit_file "/data/Wei/casper_hdl/snap_tut/snap_adc/myproj/myproj.runs/impl_1/top.bit"
set hex_file "/data/Wei/casper_hdl/snap_tut/snap_adc/myproj/myproj.runs/impl_1/top.hex"
set mcs_file "/data/Wei/casper_hdl/snap_tut/snap_adc/myproj/myproj.runs/impl_1/top.mcs"
set prm_file "/data/Wei/casper_hdl/snap_tut/snap_adc/myproj/myproj.runs/impl_1/top.prm"
set xsa_file "/data/Wei/casper_hdl/snap_tut/snap_adc/myproj/myproj.runs/impl_1/top.xsa"
set jbd_name "snap_bd"

proc check_timing {run} {
  if { [get_property STATS.WNS [get_runs $run] ] < 0 } {
    send_msg_id "CASPER-1" {CRITICAL WARNING} "ERROR: Found timing violations => Worst Negative Slack: [get_property STATS.WNS [get_runs $run]] ns"
  } else {
    puts "No timing violations => Worst Negative Slack: [get_property STATS.WNS [get_runs $run]] ns"
  }

  if { [get_property STATS.TNS [get_runs $run] ] < 0 } {
    send_msg_id "CASPER-1" {CRITICAL WARNING} "ERROR: Found timing violations => Total Negative Slack: [get_property STATS.TNS [get_runs $run]] ns"
  }

  if { [get_property STATS.WHS [get_runs $run] ] < 0 } {
    send_msg_id "CASPER-1" {CRITICAL WARNING} "ERROR: Found timing violations => Worst Hold Slack: [get_property STATS.WHS [get_runs $run]] ns"
  } else {
    puts "No timing violations => Worst Hold Slack: [get_property STATS.WHS [get_runs $run]] ns"
  }

  if { [get_property STATS.THS [get_runs $run] ] < 0 } {
    send_msg_id "CASPER-1" {CRITICAL WARNING} "ERROR: Found timing violations => Total Hold Slack: [get_property STATS.THS [get_runs $run]] ns"
  }
}


proc check_zero_critical {count mess} {
  if {$count > 0} {
    puts "************************************************"
    send_msg_id "CASPER-2" {CRITICAL WARNING} "$mess critical warning count: $count"
    puts "************************************************"
  }
}


proc puts_red {s} {
  puts -nonewline "\[1;31m"; #RED
  puts $s
  puts -nonewline "\[0m";# Reset
}

puts "Starting tcl script"
cd /data/Wei/casper_hdl/snap_tut/snap_adc
create_project -f myproj myproj -part xc7k160tffg676-2
create_bd_design $jbd_name
current_bd_design $jbd_name
set_property target_language VHDL [current_project]



import_files -force /data/Wei/casper_hdl/snap_tut/snap_adc/top.v
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/wb_bram
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/wb_register_ppc2simulink
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/wb_register_simulink2ppc
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/gpio_simulink2ext
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/adc16_interface
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/wb_adc16_controller
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/tx_packet_fifo.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/cpu_buffer.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/tb
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/rx_packet_fifo_dist.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/tx_fifo_ext.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/rx_packet_ctrl_fifo.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/arp_cache.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/wb_attach.v
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/rx_packet_fifo_bram.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/tx_packet_ctrl_fifo.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/tge_rx.v
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/ten_gig_eth_mac_UCB.vhd
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/kat_ten_gb_eth.v
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/kat_ten_gb_eth/tge_tx.v
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/tengbaser_phy/tengbaser_phy.v
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/tengbaser_phy/ten_gig_pcs_pma_5.xci
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/tengbaser_infrastructure
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/infrastructure
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/wbs_arbiter
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/lmx2581_controller
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/wb_register_ppc2simulink_sync
import_files -force /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/sys_block
set repos [get_property ip_repo_paths [current_project]]
set_property ip_repo_paths "$repos /data/Wei/casper_hdl/snap_tut/snap_adc/sysgen" [current_project]
update_ip_catalog
create_ip -name snap_adc -vendor User_Company -library SysGen -version 1.0 -module_name snap_adc_ip
set repos [get_property ip_repo_paths [current_project]]
set_property ip_repo_paths "$repos /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/axi_wb_bridge/ip_repo" [current_project]
update_ip_catalog
import_files -force -fileset constrs_1 /data/Wei/casper_hdl/snap_tut/snap_adc/user_const.xdc
set_property top top [current_fileset]
update_compile_order -fileset sources_1
if {[llength [glob -nocomplain [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe]] > 0} {
file copy -force {*}[glob [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe] [get_property directory [current_project]]/myproj.srcs/sources_1/ip/
}
upgrade_ip -quiet [get_ips *]
source /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/microblaze_wb/microblaze_wb.tcl
save_bd_design
validate_bd_design
generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/snap_bd/snap_bd.bd]
make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/snap_bd/snap_bd.bd] -top
add_files -norecurse [get_property directory [current_project]]/myproj.srcs/sources_1/bd/snap_bd/hdl/snap_bd_wrapper.vhd
update_compile_order -fileset sources_1
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
open_run synth_1
set synth_critical_count [get_msg_config -count -severity {CRITICAL WARNING}]
set_property STEPS.POST_PLACE_POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
launch_runs impl_1 -jobs 4
wait_on_run impl_1
open_run impl_1
set impl_critical_count [get_msg_config -count -severity {CRITICAL WARNING}]
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
cd [get_property DIRECTORY [current_project]]
exec cat /data/Wei/casper_hdl/dspdevel_designs/mlib_devel/jasper_library/hdl_sources/microblaze_wb/executable.mem ../core_info.jam.tab.mem > ../executable_core_info.mem
exec -ignorestderr updatemem -bit ./myproj.runs/impl_1/top.bit -meminfo ./myproj.runs/impl_1/top.mmi -data ../executable_core_info.mem  -proc snap_bd_inst/microblaze_0 -out ./myproj.runs/impl_1/top.bit -force
write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.mcs" -force
write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x0008000 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top_0x8000.mcs" -force
write_cfgmem  -format bin -size 32 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.bin" -force
check_timing impl_1
check_zero_critical $impl_critical_count implementation
check_zero_critical $synth_critical_count synthesis
