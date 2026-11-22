class router_tb extends uvm_env;

`uvm_component_utils(router_tb)
channel_env chan0;
channel_env chan1;
channel_env chan2;
hbus_env bus_env;
clock_and_reset_env clkrst;
yapp_env env; 
router_mcsequencer mcseqr;
router_sb scoreboard;

function new (string name, uvm_component parent);
    super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("router_tb",$sformatf("now build phase occur at %s", this.sprint()), UVM_HIGH)
    env = yapp_env::type_id::create("env", this);
    uvm_config_int::set(this, "chan0", "channel_id", 0);
    uvm_config_int::set(this, "chan1", "channel_id", 1);
    uvm_config_int::set(this, "chan2", "channel_id", 2);    
    chan0 = channel_env::type_id::create("chan0", this);
    chan1 = channel_env::type_id::create("chan1", this);
    chan2 = channel_env::type_id::create("chan2", this);
    uvm_config_int::set(this, "bus_env", "num_masters", 1);
    uvm_config_int::set(this, "bus_env", "num_slaves", 0);
    bus_env = hbus_env::type_id::create("bus_env", this);
    clkrst = clock_and_reset_env::type_id::create("clkrst", this);
    mcseqr = router_mcsequencer::type_id::create("mcseqr", this);
    scoreboard = router_sb::type_id::create("scoreboard", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mcseqr.hbus_seqr = bus_env.masters[0].sequencer;
    mcseqr.yapp_seqr = env.agent.sequencer;
    env.agent.monitor.yapp_out.connect(scoreboard.yapp_in);
    chan0.rx_agent.monitor.item_collected_port.connect(scoreboard.chan0_in);
    chan1.rx_agent.monitor.item_collected_port.connect(scoreboard.chan1_in);
    chan2.rx_agent.monitor.item_collected_port.connect(scoreboard.chan2_in);
endfunction

endclass