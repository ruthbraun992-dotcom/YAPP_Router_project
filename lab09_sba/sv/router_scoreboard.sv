class router_sb extends uvm_scoreboard;
    
    `uvm_component_utils(router_sb)
    yapp_packet chan1_in_queue [$];
    yapp_packet chan0_in_queue [$];
    yapp_packet chan2_in_queue [$];
    int recieve_packets = 0, correct_packets = 0, incorrect_packets = 0;
    
    `uvm_analysis_imp_decl(_yapp)
    uvm_analysis_imp_yapp #(yapp_packet, router_sb) yapp_in;
    function void write_yapp(input yapp_packet packet);
        yapp_packet pkt;
        $cast(pkt, packet.clone());
        case (pkt.addr)
        2'b00: chan0_in_queue.push_back(pkt);
        2'b01: chan1_in_queue.push_back(pkt);
        2'b10: chan2_in_queue.push_back(pkt);
        default: begin `uvm_info("SCOREBOARD", "packet invalid", UVM_LOW) end
        endcase
    endfunction

    `uvm_analysis_imp_decl(_chan0)
    uvm_analysis_imp_chan0 #(channel_packet, router_sb) chan0_in;
    function void write_chan0 (input channel_packet can_packet);
        yapp_packet yapp_pkt;
        recieve_packets++;
        if(chan0_in_queue.size() > 0) begin
            yapp_pkt = chan0_in_queue.pop_front();
        if(comp_equal(yapp_pkt, can_packet)) begin correct_packets++; end
        else begin incorrect_packets++; end
        end
    endfunction

    `uvm_analysis_imp_decl(_chan1)
    uvm_analysis_imp_chan1 #(channel_packet, router_sb) chan1_in;
    function void write_chan1(input channel_packet chan_packet);
        yapp_packet yapp_pkt;
        recieve_packets++;
        if(chan1_in_queue.size() > 0) begin
            yapp_pkt = chan1_in_queue.pop_front();
        if (comp_equal(yapp_pkt, chan_packet)) begin correct_packets++; end
        else begin incorrect_packets++; end
        end
    endfunction

    `uvm_analysis_imp_decl(_chan2)
    uvm_analysis_imp_chan2 #(channel_packet, router_sb) chan2_in;
    function void write_chan2 (input channel_packet chan_packet);
        yapp_packet yapp_pkt;
        recieve_packets++;
        if(chan2_in_queue.size() > 0) begin
            yapp_pkt = chan2_in_queue.pop_front();
            if(comp_equal(yapp_pkt, chan_packet)) begin  correct_packets++; end
            else begin incorrect_packets++; end
        end
    endfunction

    function new(string name = "router_sb", uvm_component parent);
        super.new(name, parent);
        yapp_in = new("yapp_in", this);
        chan0_in = new("chan0_in", this);
        chan1_in = new("chan1_in", this);
        chan2_in = new ("chan2_in", this);
    endfunction

    function bit comp_equal (input yapp_packet yp, input channel_packet cp);
      // returns first mismatch only
      if (yp.addr != cp.addr) begin
        `uvm_error("PKT_COMPARE",$sformatf("Address mismatch YAPP %0d Chan %0d",yp.addr,cp.addr))
        return(0);
      end
      if (yp.length != cp.length) begin
        `uvm_error("PKT_COMPARE",$sformatf("Length mismatch YAPP %0d Chan %0d",yp.length,cp.length))
        return(0);
      end
      foreach (yp.payload [i])
        if (yp.payload[i] != cp.payload[i]) begin
          `uvm_error("PKT_COMPARE",$sformatf("Payload[%0d] mismatch YAPP %0d Chan %0d",i,yp.payload[i],cp.payload[i]))
          return(0);
        end
      if (yp.parity != cp.parity) begin
        `uvm_error("PKT_COMPARE",$sformatf("Parity mismatch YAPP %0d Chan %0d",yp.parity,cp.parity))
        return(0);
      end
      return(1);
   endfunction

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("ROPERT_SCOREBPARD", $sformatf("The number of packet that recieved: %0d", recieve_packets), UVM_LOW)
        `uvm_info("ROPERT_SCOREBPARD", $sformatf("The number of packet that are correct: %0d", correct_packets), UVM_LOW)
        `uvm_info("ROPERT_SCOREBPARD", $sformatf("The number of packet that are incorrect: %0d", incorrect_packets), UVM_LOW)
        `uvm_info("ROPERT_SCOREBPARD", $sformatf("The number of packet that are srill in queue from channel 0: %0d", chan0_in_queue.size()), UVM_LOW)
        `uvm_info("ROPERT_SCOREBPARD", $sformatf("The number of packet that are srill in queue from channel 1: %0d", chan1_in_queue.size()), UVM_LOW)
        `uvm_info("ROPERT_SCOREBPARD", $sformatf("The number of packet that are srill in queue from channel 2: %0d", chan2_in_queue.size()), UVM_LOW)
    endfunction

endclass