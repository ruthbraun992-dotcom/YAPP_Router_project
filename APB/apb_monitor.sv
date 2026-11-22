class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)
    virtual apb_if vif;
    uvm_analysis_port#(apb_item) ap;

    function new(string name = "apb_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if(!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("MON", "no vif in config_db")
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        apb_item item;
        forever begin
            @(posedge vif.pclk);
            if(vif.presetn && vif.psel && vif.penable && vif.pready) begin
                item = apb_item::type_id::create("item");
                item.addr = vif.paddr;
                item.write = vif.pwrite;
                item.data = vif.pwrite ? vif.pwdata : vif.prdata;
                `uvm_info("MON", item.sprint(), UVM_MEDIUM)
                ap.write(item);
            end
        end

    endtask : run_phase

endclass : apb_monitor