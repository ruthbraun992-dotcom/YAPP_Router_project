class yapp_env extends uvm_env;

`uvm_component_utils(yapp_env)

yapp_tx_agent  agent;

    function new(string name = "yapp_env", uvm_component parent);
        super.new(name, parent);        
    endfunction

 virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = new("yapp_tx_agent", this);
    endfunction

virtual function void start_of_simulation_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("%s\nstart_of_simulation_phase", {30{"*"}}), UVM_HIGH)
endfunction

endclass : yapp_env