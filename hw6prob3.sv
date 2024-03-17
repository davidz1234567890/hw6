`default_nettype none
module OnesCount
 #(parameter w = 30)
 (input  logic         d_in_ready, clock, reset,
  input  logic [w-1:0] d_in,
  output logic         dor,
  output logic [$clog2(w+1)-1:0] d_out);//added +1

  logic oclear, oinc;
  logic done;
  logic sel;
  logic load;
  logic [w-1:0] Q, D, q0;

  logic [w-1:0] var0, var1, diff;

  assign var0 = 0;
  assign var1 = 1;
  logic bout;
  logic [$clog2(w+1)-1:0] d_intermediate;
  fsm #(w) control (.*);
  Mux2to1 #(w) dut1(.I0(q0), .I1(d_in), .S(sel), .Y(D) );
  Register #(w) dut2(.en(load), .clear(1'b0), .D, .clock, .Q);
  
  Subtracter #(w) dut4(.A(Q), .B(var1), .bin(1'b0), .bout , 
                       .diff);    
  assign q0 = ((Q) & diff);
  Comparator #(w) dut3(.A(var0), .B(Q),.AeqB(done)); //B was q0 b4
  Counter #($clog2(w+1)) dut5(.en(oinc), .clear(oclear), .load(1'b0),
                        .up(1'b1),
                        .D(d_intermediate),
                        .clock(clock),
                        .Q(d_out));
    
endmodule: OnesCount

module fsm 
 #(parameter w = 30)
  (input  logic clock, reset, done,
   input  logic d_in_ready,
   output logic load, sel, dor, oclear, oinc);

  enum  logic [1:0] {A = 2'b00, B = 2'b01, C = 2'b10} cur_state, n_state;

  always_comb begin
    case (cur_state)
      A: begin  //State A
         n_state = d_in_ready ? B : A;
         load  = d_in_ready ? 1:0; //if d_in_ready, can load from D to Q in
                                   //register
         oclear  = d_in_ready ? 1 : 0; //if d_in_ready, clear the counter
         oinc = d_in_ready ? 1 : 0; //not ready to increment the counter yet
         sel = d_in_ready ? 1 : 1; //always select the 1st input (d_in)
         dor = 0; // D_out_ready
         end
      B: begin  //State B
         n_state  = (done)? C : B;
         dor      = (done)? 1 : 0;//if done, d_out_ready is true
         oclear = 0; //do not clear the counter when in state B
         oinc = (done) ? 0 : 1; //unconditional increment
         load  = 1;//(done) ? 0 : 1; //if done, deassert it
         sel = 0;//(done) ? 1 : 0;
         end
      C: begin
          n_state = A;
          dor = 1;
          oclear = 0; //shouldn't clear
          oinc = 0; //but shouldn't increment either
          load  = (done) ? 0 : 1;
          sel = (done) ? 1 : 0;
         end 
    endcase
  end

  always_ff @(posedge clock, posedge reset) 
    if (reset) 
      cur_state <= A;
    else 
      cur_state <= n_state;

endmodule: fsm
