module tb_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import apb_pkg::*;
    
    logic pclk = 0;
    logic presetn;
    always #5 pclk = ~pclk;

    initial begin
        presetn = 0;
        repeat (3) @(posedge pclk);
        presetn = 1;
    end

    apb_if vif(pclk, presetn);
    apb_slave dut(.pclk(pclk),.presetn(presetn),
                    .paddr(vif.paddr), .psel(vif.psel),
                    .penable(vif.penable), .pwrite(vif.pwrite),
                    .pwdata(vif.pwdata), .pready(vif.pready),
                    .prdata(vif.prdata));

    initial begin
        uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.*", "vif", vif);
        run_test("apb_basic_test");
    end

endmodule : tb_top