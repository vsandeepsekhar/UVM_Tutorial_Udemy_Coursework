//------------------------------------
//APB (Advanced peripheral Bus) Interface 
//
//------------------------------------
`ifndef APB_IF_SV
`define APB_IF_SV

interface apb_if(input bit pclk);
   wire [31:0] paddr;
   wire        psel;
   wire        penable;
   wire        pwrite;
   wire [31:0] prdata;
   wire [31:0] pwdata;


   //Master Clocking block - used for Drivers
   clocking master_cb @(posedge pclk);
     //Outputs
     output paddr;
     output psel;
     output penable;
     output pwrite;
     output pwdata;
     
     //Inputs
     input prdata;
   endclocking: master_cb

   //Slave Clocking Block - used for any Slave BFMs
   clocking slave_cb @(posedge pclk);
     //inputs
     input paddr;
     input psel;
     input penable;
     input pwrite;
     input pwdata;
     
     //outputs
     output prdata;
   endclocking: slave_cb

   //Monitor Clocking block - For sampling by monitor components
   clocking monitor_cb @(posedge pclk);    
     input paddr;
     input psel;
     input penable;
     input pwrite;
     input pwdata;
     input prdata;
   endclocking: monitor_cb

  modport master(clocking master_cb);
  modport slave(clocking slave_cb);
  modport passive(clocking monitor_cb);

endinterface: apb_if

`endif
