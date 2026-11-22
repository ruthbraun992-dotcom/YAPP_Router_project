class base_test extends uvm_test;

`uvm_component_utils(base_test)

router_tb tb;

function new(string name, uvm_component parent);
  super.new(name, parent);      
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",
                               "default_sequence",
                                yapp_5_packets::get_type());
    tb= router_tb::type_id::create("tb", this);
    uvm_config_int::set(this, "*", "recording_detail", 1);
    `uvm_info("base_test", $sformatf("now the build phase of the test is being executed at %s", tb.sprint()), UVM_HIGH)
endfunction

virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction

virtual function void check_phase(uvm_phase phase);
  check_config_usage();
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

class short_packet_test extends base_test;
`uvm_component_utils(short_packet_test)

function new (string name = "short_packet_test", uvm_component parent);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
endfunction
endclass

class set_config_test extends base_test;
`uvm_component_utils(set_config_test)

function new(string name = "set_config_test", uvm_component parent);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
uvm_config_int::set(this, "tb.env.agent", "is_active", UVM_PASSIVE);

endfunction
endclass

class incr_payload_test extends base_test;
`uvm_component_utils(incr_payload_test)

function new(string name = "incr_payload_test", uvm_component parent);
super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
uvm_config_wrapper::set(this, 
"tb.env.agent.sequencer.run_phase", "default_sequence",
 yapp_incr_payload_seq::get_type());
 set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
endfunction

endclass : incr_payload_test

class exhaustive_seq_test extends base_test;
  `uvm_component_utils(exhaustive_seq_test)

  function new(string name = "exhaustive_seq_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase", 
                          "default_sequence",yapp_exhaustive_seq::get_type());
    set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
  endfunction



endclass