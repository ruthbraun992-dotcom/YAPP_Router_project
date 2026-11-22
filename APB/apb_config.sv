class apb_config extends uvm_object;

    `uvm_object_utils(apb_config)

    uvm_active_passive_enum is_active = UVM_ACTIVE;
    apb_role_e role = APB_MASTER;

    function new(string name = "apb_config");
        super.new(name);
    endfunction : new

endclass