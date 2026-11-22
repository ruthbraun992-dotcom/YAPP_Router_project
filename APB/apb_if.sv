interface apb_if (input logic pclk, input logic presetn);

logic [31:0] paddr;
logic [31:0] pwdata;
logic [31:0] prdata;
logic       psel;
logic       penable;
logic       pwrite;
logic       pready;

modport master_mp(input pclk, presetn, pready, prdata,
                    output paddr, pwdata, psel, penable, pwrite);
modport slave_mp(input pclk, presetn, paddr, pwdata, psel, penable, pwrite,
                output pready, prdata);
modport monitor_mp(input pclk, presetn, paddr, pwdata, prdata, psel, penable, pwrite, pready);

property sel_after_enbl;
    (@(posedge pclk) (psel && !penable) |=> penable);
endproperty

property enbl_with_sel;
    (@(posedge pclk) penable |->psel);
endproperty

property data_stay_on_bus;
    (@(posedge pclk) (psel && penable && !pready) |=> $stable(paddr) && $stable(pwrite) && $stable(pwdata));
endproperty
    
A1: assert property (@(posedge pclk) disable iff(!presetn) (sel_after_enbl));
A2: assert property (@(posedge pclk) disable iff(!presetn)(enbl_with_sel));
A3: assert property (@(posedge pclk) disable iff(!presetn) (data_stay_on_bus));


endinterface