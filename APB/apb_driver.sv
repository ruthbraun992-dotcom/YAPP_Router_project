class apb_driver extends uvm_driver#(apb_item);
    
    `uvm_component_utils(apb_driver)
    virtual apb_if vif;

    function new(string name = "apb_driver", uvm_component parent);
        super.new(name, parent);        
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "no vif in config_db")
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        reset_signals();
        wait (vif.presetn === 1);
        forever begin
            seq_item_port.get_next_item(req);
            drive_to_dut();
            seq_item_port.item_done();
        end 
    endtask : run_phase
    virtual task reset_signals(); endtask
    virtual task drive_to_dut(); endtask
endclass : apb_driver