module tb_top;

import uvm_pkg::*;
`include "uvm_macros.svh"
import yapp_pkg::*;
import hbus_pkg::*;
import channel_pkg::*;
import clock_and_reset_pkg::*;
`include "router_mcsequencer.sv"
`include "router_simple_mcseq.sv"
import router_module_pkg::*;
`include "router_tb.sv"
`include "router_test_lib.sv"

initial begin
    hbus_vif_config::set(null, "uvm_test_top.tb.bus_env.*", "vif", hw_top.hif);
    channel_vif_config::set(null, "uvm_test_top.tb.chan0.*", "vif", hw_top.ch0);
    channel_vif_config::set(null, "uvm_test_top.tb.chan1.*", "vif", hw_top.ch1);
    channel_vif_config::set(null, "uvm_test_top.tb.chan2.*", "vif", hw_top.ch2);
    clock_and_reset_vif_config::set(null, "uvm_test_top.tb.clkrst.*", "vif", hw_top.clk_rst_if);
    yapp_if_cfg::set(null, "uvm_test_top.tb.env.agent.*", "vif", hw_top.in0);
    run_test();
end

endmodule : tb_top
