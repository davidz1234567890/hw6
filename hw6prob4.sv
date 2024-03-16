module hw6prob4(input logic A, clock, reset_L,
    output logic B);
    
    logic ns, cs;
    //nextstate
    assign ns = cs | A;
    

    //output
    assign B = cs ^ A;

    DFlipFlop dut(.D(ns), .clock(clock), .reset_L(reset_L), 
    .preset_L(1'b1), .Q(cs));



endmodule: hw6prob4



module hw6prob4_test;
  logic A, clock, reset_L, B;
  hw6prob4 DUT(.*);
  initial begin
    clock = 0;
    reset_L = 0;
    #1 reset_L <= 1;
    forever #5 clock = ~clock;
  end
  initial begin
    $monitor("A: %b B: %b reset: %b cs: %b ns:%b \n",
    A, B, reset_L, DUT.cs, DUT.ns );
 
    
    
    A <= 1'b0;
    @(posedge clock);
    A <= 1'b1;
    @(posedge clock);
    A <= 1'b0;
    @(posedge clock);
    A <= 1'b1;
    @(posedge clock);
    A <= 1'b0;
    @(posedge clock);
    A <= 1'b1;
    @(posedge clock);
    $finish;
  end
endmodule: hw6prob4_test
