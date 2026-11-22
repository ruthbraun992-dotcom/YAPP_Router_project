class apb_basic_test extends uvm_test;

    `uvm_component_utils(apb_basic_test)

    function new(string name = "apb_basic_test", uvm_component parent);
        super.new(name, parent);        
    endfunction

    apb_config m_cfg;
    apb_config s_cfg;
    apb_agent m_agent;
    apb_agent s_agent;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_cfg = apb_config::type_id::create("m_cfg");
        m_cfg.is_active = UVM_ACTIVE;
        m_cfg.role = APB_MASTER;

        s_cfg = apb_config::type_id::create("cfg");
        s_cfg.is_active = UVM_PASSIVE;
        s_cfg.role = APB_SLAVE;

        uvm_config_db#(apb_config)::set(this, "m_agent", "cfg", m_cfg);
        uvm_config_db#(apb_config)::set(this, "s_agent", "cfg", s_cfg);
        
        m_agent = apb_agent::type_id::create("m_agent", this);
        s_agent = apb_agent::type_id::create("s_agent", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_base_seq seq = apb_base_seq::type_id::create("seq");
        phase.raise_objection(this);
        if(!seq.randomize())
            `uvm_fatal("RAND", "seq randomize failed")
        seq.start(m_agent.sqr);
        phase.drop_objection(this);
    endtask

endclass