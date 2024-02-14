
class sr_coverage extends uvm_subscriber #(sr_sequence_item);

  `uvm_component_utils(sr_coverage)
 
  sr_sequence_item txn;
   
  covergroup cg;
    option.per_instance= 1;
    option.comment     = "SR ff coverage";
    option.name        = "functional cov";
    option.auto_bin_max= 4;
    
    S:coverpoint txn.s;
    R:coverpoint txn.r;

    SxR:cross S,R;
  endgroup



function new(string name="sr_coverage",uvm_component parent);
    super.new(name,parent);
    cg=new();
  endfunction

  
  function void write(sr_sequence_item t);
    txn=t;
    cg.sample();
  endfunction
  


  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cg.get_coverage),UVM_MEDIUM)
  endfunction
  
endclass
