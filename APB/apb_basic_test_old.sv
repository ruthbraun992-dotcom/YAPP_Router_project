class apb_basic_test extends uvm_test;

    `uvm_component_utils(apb_basic_test)

    function new(string name = "apb_basic_test", uvm_component parent);
        super.new(name, parent);        
    endfunction

    apb_config cfg;
    apb_agent agent;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg = apb_config::type_id::create("cfg");
        cfg.is_active = UVM_ACTIVE;
        cfg.role = APB_MASTER;
        uvm_config_db#(apb_config)::set(this, "agent", "cfg", cfg);
        agent = apb_agent::type_id::create("agent", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_base_seq seq = apb_base_seq::type_id::create("seq");
        phase.raise_objection(this);
        if(!seq.randomize())
            `uvm_fatal("RAND", "seq randomize failed")
        seq.start(agent.sqr);
        phase.drop_objection(this);
    endtask

endclass