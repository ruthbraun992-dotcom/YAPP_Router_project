class apb_item extends uvm_sequence_item;

    rand logic [31:0] addr;
    rand logic [31:0] data;
    rand logic       write;
    
    `uvm_object_utils_begin(apb_item)
        `uvm_field_int(addr, UVM_ALL_ON)    
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(write, UVM_ALL_ON)
    `uvm_object_utils_end

    
    function new(string name = "apb_item");
        super.new(name);        
    endfunction

constraint c1 { addr < 256; }

endclass