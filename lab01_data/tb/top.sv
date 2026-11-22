module top;

import uvm_pkg::*;
`include "uvm_macros.svh"
import yapp_pkg::*;

yapp_packet y1;

initial begin
int ok;
for( int i = 0; i < 5; i++) 
begin
    y1 = new({"yapp_packet_", $sformatf("%0d", i)});
    ok = y1.randomize();
    if(ok)  
    y1.print(uvm_default_tree_printer);
    else
    `uvm_error("RANDOM", "=*30 \n \nERROR\n\n=*30 ")        
end
end
endmodule : top
