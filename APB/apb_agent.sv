class apb_agent extends uvm_agent;

    `uvm_component_utils(apb_agent)

    apb_config cfg;
    apb_sequencer sqr;
    apb_driver drv;
    apb_monitor mon;

    function new (string name = "apb_agent", uvm_component parent);
    super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(apb_config)::get(this, "", "cfg", cfg))
            `uvm_fatal("AGT", "no cfg")
        mon = apb_monitor::type_id::create("mon", this);
        if(cfg.is_active == UVM_ACTIVE) begin 
            sqr = apb_sequencer::type_id::create("sqr", this);
            if(cfg.role == APB_MASTER)
                drv = apb_master_driver::type_id::create("drv", this);
            else begin
                drv = apb_slave_driver::type_id::create("drv", this);
            end
        end
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        if(cfg.is_active == UVM_ACTIVE)
            drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction : connect_phase


endclass