/*-----------------------------------------------------------------
File name     : run.f
Description   : lab01_data simulator run template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
              : Set $UVMHOME to install directory of UVM library
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/
// 64 bit option for AWS labs
-64
-timescale 1ns/1ns
 -uvmhome $UVMHOME
 -incdir ../../channel/sv
 -incdir ../../clock_and_reset/sv
 -incdir ../../hbus/sv
 -incdir ../../yapp/sv
../../channel/sv/channel_pkg.sv
../../channel/sv/channel_if.sv
../../clock_and_reset/sv/clock_and_reset_pkg.sv
../../clock_and_reset/sv/clock_and_reset_if.sv
../../hbus/sv/hbus_pkg.sv
../../hbus/sv/hbus_if.sv
../../yapp/sv/yapp_pkg.sv
../../yapp/sv/yapp_if.sv
 clkgen.sv
 hw_top.sv
 ../../router_rtl/yapp_router.sv
tb_top.sv

+UVM_TESTNAME=simple_mcseq_test
+UVM_VERBOSITY=UVM_HIGH
+SVSEED=random 

// include directories
//*** add incdir include directories here

// compile files
//*** add compile files here

