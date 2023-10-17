`include "uvm_macros.svh"
 import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
    oper_mode   oper;
    rand logic [16:0] baud;
    logic tx_clk;
    real period;
    
  constraint baud_c { baud inside {4800,9600,14400,19200,38400,57600}; }
  
 
  function new(string name = "transaction");
    super.new(name);
  endfunction
 
endclass 