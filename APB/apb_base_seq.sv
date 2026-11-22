class apb_base_seq extends uvm_sequence #(apb_item);

    `uvm_object_utils(apb_base_seq)
    
    rand int num_trans;
    
    function new(string name = "apb_base_seq");
        super.new(name);
    endfunction : new

    constraint c_num { num_trans inside {[1:10]}; }
    
    task body();
    bit [31:0] a, d;
    repeat (num_trans) begin
      req = apb_item::type_id::create("req");
      start_item(req);
      if (!req.randomize() with { write == 1; }) `uvm_error("SEQ", "randomize failed")
      finish_item(req);
      a = req.addr;  d = req.data;

      req = apb_item::type_id::create("req");
      start_item(req);
      if (!req.randomize() with { write == 0; addr == a; }) `uvm_error("SEQ", "randomize failed")
      finish_item(req);
      if (req.data !== d)
        `uvm_error("SEQ", $sformatf("addr %0h: wrote %0h, read %0h", a, d, req.data))
        end
    endtask : body
endclass : apb_base_seq 