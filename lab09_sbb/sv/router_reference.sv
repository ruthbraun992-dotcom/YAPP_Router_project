class router_reference extends uvm_component;

    `uvm_component_utils(router_reference)
    int length_invalid = 0, addr_invalid = 0, disabled_router = 0;
    bit [5:0] maxpktsize = 8'h3f;
    bit router_en = 1;
    uvm_analysis_port #(yapp_packet) yapp_out;
    
    `uvm_analysis_imp_decl(_yapp_ref)
    uvm_analysis_imp_yapp_ref #(yapp_packet, router_reference) yapp_ref_in;
    function void write_yapp_ref(input yapp_packet packet);
        if(!router_en) disabled_router++;
        else if(packet.addr == 3) addr_invalid++;
        else if(packet.length > maxpktsize || packet.length < 1) length_invalid++;
        else yapp_out.write(packet);
    endfunction


    `uvm_analysis_imp_decl(_hbus_ref)
    uvm_analysis_imp_hbus_ref #(hbus_transaction, router_reference) hbus_in;
    function void write_hbus_ref(input hbus_transaction transaction);
        if(transaction.hwr_rd != HBUS_WRITE)
            return;
        if(transaction.haddr == 0)
        maxpktsize = transaction.hdata[5:0];
        else if(transaction .haddr== 1 )
        router_en = transaction.hdata[0];        
    endfunction
    function new(string name = "router_reference", uvm_component parent);
        super.new(name, parent);  
        yapp_ref_in = new("yapp_ref_in", this);
        hbus_in = new("hbus_in", this); 
        yapp_out = new("yapp_out", this);     
    endfunction

    function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("FROM REFERENCE MODEL",  $sformatf("The number of packets that send in disable router: %0d", disabled_router), UVM_LOW)
    `uvm_info("FROM REFERENCE MODEL",  $sformatf("The number of packets that dropped because address is invalid: %0d", addr_invalid), UVM_LOW)
    `uvm_info("FROM REFERENCE MODEL",  $sformatf("The number of packets that dropped from length is invalid: %0d", length_invalid), UVM_LOW)
    endfunction

endclass