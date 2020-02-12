
//A few flavours of apb sequences

`ifndef APB_SEQUENCES_SV
`define APB_SEQUENCES_SV

//------------------------
//Base APB sequence derived from uvm_sequence and parameterized with sequence item of type apb_rw
//------------------------
class apb_base_seq extends uvm_sequence#(apb_rw);

  `uvm_object_utils(apb_base_seq)

  function new(string name ="");
    super.new(name);
  endfunction


  //Main Body method that gets executed once sequence is started
  //Remember Sequence always calls sequence item and should be parametrized as above 
  //For Eg: apb_rw is a sequence item and it has all the constraints needed for the test.
  task body();
    apb_rw rw_trans; //transaction apb_rw is the sequence item
    //Create 10 random APB read/write transactions and send to driver
    
    repeat(10) begin
      //Step -1 Create the object
      rw_trans = apb_rw::type_id::create(.name("rw_trans"),.contxt(get_full_name()));
      //Step -2 Start Item is a blocking call until sequencer grants access to sequence
      start_item(rw_trans);
      //Step -3 Setup sequence item properties or Randomize
      assert (rw_trans.randomize());
      //Step -4 Blocks until the driver completes its tranfer
      finish_item(rw_trans);
      //Step -5 (Optional) //Blocks until a response is received from the driver
      //get_response(); // (Optional as said above!)
    end 
    
  endtask
  
endclass



`endif
