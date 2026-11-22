class apb_slave_driver extends apb_driver;
    `uvm_component_utils(apb_slave_driver)
    bit [31:0] mem [int];

    function new(string name = "apb_slave_driver", uvm_component parent);
        super.new(name, parent);        
    endfunction : new
    
    task run_phase(uvm_phase phase);
        reset_signals();
        wait(vif.presetn === 1);
        forever drive_to_dut();
    endtask : run_phase

    task reset_signals();
        vif.pready <= 0;
        vif.prdata <= 0;
    endtask : reset_signals

    task drive_to_dut();
        bit [31:0] addr;
        bit wr;
        int waits = $urandom_range(0,3);

        vif.pready <= 0;
        do @(posedge vif.pclk); while(!(vif.psel && !vif.penable));
        addr = vif.paddr;
        wr = vif.pwrite;
        repeat(waits) @(posedge vif.pclk);
        vif.pready <= 1;
        if(wr) mem[addr] = vif.pwdata;
        else vif.prdata <= mem.exists(addr) ? mem[addr] : 32'h0;
        @(posedge vif.pclk);
        vif.pready <= 0;
        vif.prdata <= 0;
    endtask : drive_to_dut

endclass