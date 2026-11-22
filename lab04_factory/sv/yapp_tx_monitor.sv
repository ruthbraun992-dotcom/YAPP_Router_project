class yapp_tx_monitor extends uvm_monitor;

    `uvm_component_utils(yapp_tx_monitor)

    function new(string name = "yapp_tx_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info("monitor", "Im in monitor", UVM_LOW)
    endtask   
virtual function void start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("%s\nstart_of_simulation_phase", {30{"*"}}), UVM_HIGH)
endfunction

endclass :yapp_tx_monitor