class apb_master_driver extends apb_driver;
    `uvm_component_utils(apb_master_driver)
    function new(string name = "apb_master_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    task reset_signals();
        vif.psel <= 0;
        vif.penable <= 0;
        vif.paddr <= 0;
        vif.pwrite <= 0;
        vif.pwdata <= 0;
    endtask : reset_signals

    task drive_to_dut();
        @(posedge vif.pclk);
        vif.psel <= 1;
        vif.penable <= 0;
        vif.paddr <= req.addr;
        vif.pwrite <= req.write;
        vif.pwdata <= req.data;
        @(posedge vif.pclk)
        vif.penable <= 1;
        do @(posedge vif.pclk); while (!vif.pready);
        if(!req.write) req.data = vif.prdata;
        vif.psel <= 0;
        vif.penable <= 0;
    endtask : drive_to_dut


endclass