# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.cache/wt [current_project]
set_property parent.project_path D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths d:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs [current_project]
set_property ip_output_repo d:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem.xci
set_property used_in_implementation false [get_files -all d:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_ooc.xdc]
set_property is_locked true [get_files D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.runs/Instr_Mem_synth_1 -new_name Instr_Mem -ip [get_ips Instr_Mem]]

if { $cached_ip eq {} } {

synth_design -top Instr_Mem -part xc7a100tcsg324-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix Instr_Mem_ Instr_Mem.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Instr_Mem_stub.v
 lappend ipCachedFiles Instr_Mem_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Instr_Mem_stub.vhdl
 lappend ipCachedFiles Instr_Mem_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Instr_Mem_sim_netlist.v
 lappend ipCachedFiles Instr_Mem_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Instr_Mem_sim_netlist.vhdl
 lappend ipCachedFiles Instr_Mem_sim_netlist.vhdl

 config_ip_cache -add -dcp Instr_Mem.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips Instr_Mem]
}

rename_ref -prefix_all Instr_Mem_

write_checkpoint -force -noxdef Instr_Mem.dcp

catch { report_utilization -file Instr_Mem_utilization_synth.rpt -pb Instr_Mem_utilization_synth.pb }

if { [catch {
  file copy -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.runs/Instr_Mem_synth_1/Instr_Mem.dcp D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.runs/Instr_Mem_synth_1/Instr_Mem.dcp D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.runs/Instr_Mem_synth_1/Instr_Mem_stub.v D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.runs/Instr_Mem_synth_1/Instr_Mem_stub.vhdl D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.runs/Instr_Mem_synth_1/Instr_Mem_sim_netlist.v D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.runs/Instr_Mem_synth_1/Instr_Mem_sim_netlist.vhdl D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.ip_user_files/ip/Instr_Mem]} {
  catch { 
    file copy -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_stub.v D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.ip_user_files/ip/Instr_Mem
  }
}

if {[file isdir D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.ip_user_files/ip/Instr_Mem]} {
  catch { 
    file copy -force D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.srcs/sources_1/ip/Instr_Mem/Instr_Mem_stub.vhdl D:/tmp/CSExperiment_MIPS/Project_Singal_CPU/Project_Singal_CPU.ip_user_files/ip/Instr_Mem
  }
}
