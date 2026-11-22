package apb_pkg;
 import uvm_pkg::*;
 `include "uvm_macros.svh"

    typedef enum {APB_MASTER, APB_SLAVE} apb_role_e;
    `include "apb_item.sv"
    `include "apb_config.sv"
    `include "apb_base_seq.sv"
    `include "apb_sequencer.sv"
    `include "apb_monitor.sv"
    `include "apb_driver.sv"
    `include "apb_master_driver.sv"
    `include "apb_slave_driver.sv"
    `include "apb_agent.sv"
    `include "apb_basic_test.sv"
        
endpackage