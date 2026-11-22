class apb_slave_seq extends uvm_sequence #(apb_item);
  `uvm_object_utils(apb_slave_seq)
  function new(string name = "apb_slave_seq"); 
    super.new(name); 
  endfunction
  task body();
    forever begin
      req = apb_item::type_id::create("req");
      start_item(req);
      finish_item(req);
    end
  endtask
endclass