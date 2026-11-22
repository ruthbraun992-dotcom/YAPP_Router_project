class base_test extends uvm_test;

`uvm_component_utils(base_test)

router_tb my_tb;

function new(string name, uvm_component parent);
  super.new(name, parent);      
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     uvm_config_wrapper::set(this, "my_tb.yapp_env.yapp_tx_agent.yapp_tx_sequencer.run_phase",
                                  "default_sequence",
                                  yapp_5_packets::get_type());
    my_tb=new("my_tb", this);
    `uvm_info("base_test", $sformatf("now the build phase of the test is being executed at %s", my_tb.sprint()), UVM_HIGH)
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction

endclass

 class test2 extends base_test;

`uvm_component_utils(test2)
function new(string name, uvm_component parent);
  super.new(name, parent);      
endfunction
virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
endclass