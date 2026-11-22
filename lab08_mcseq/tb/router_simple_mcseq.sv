class router_simple_mcseq extends uvm_sequence;

`uvm_object_utils(router_simple_mcseq)
`uvm_declare_p_sequencer(router_mcsequencer)

    function new(string name = "router_simple_mcseq");
        super.new(name);        
    endfunction

    hbus_read_max_pkt_seq           hbus_read_max_pkt;
    hbus_small_packet_seq           hbus_small_packet;
    hbus_set_default_regs_seq   hbus_set_default_regs;
    yapp_012_seq                             yapp_012;
    yapp_5_packets                             yapp_5;
    task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this, get_type_name());
            `uvm_do_on(hbus_small_packet, p_sequencer.hbus_seqr)
            `uvm_do_on(hbus_read_max_pkt, p_sequencer.hbus_seqr)
            `uvm_do_on(yapp_012, p_sequencer.yapp_seqr)
            `uvm_do_on(yapp_012, p_sequencer.yapp_seqr)
            `uvm_do_on(hbus_set_default_regs, p_sequencer.hbus_seqr)
            `uvm_do_on(hbus_read_max_pkt, p_sequencer.hbus_seqr)
            //supposed to be 6 packet but there is seq of just 5 pkts
            `uvm_do_on(yapp_5, p_sequencer.yapp_seqr)
        if(starting_phase != null)
            starting_phase.drop_objection(this, get_type_name());
    endtask

endclass