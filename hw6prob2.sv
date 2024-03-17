`default_nettype none

module top
 #(parameter W = 16)
  (input logic [W-1:0] inputA,
   input logic         clock, rst_L);

  logic         cl_L, ld_L;
  logic [W-1:0] sum, addOut;

  Adder #(W)   a1 (inputA, sum, 1'b0, , addOut);

  //Adder #(W)   a1 (inputA, sum, 0, addOut, );

  regLoad #(W) r1 (addOut, cl_L, ld_L, clock,
                   rst_L, sum);

  fsm          c1 (.clock, .rst_L, .ld_L, .cl_L);

endmodule: top

module fsm
  (input  logic clock, rst_L,
   output logic ld_L, cl_L);

  enum logic [2:0] {A=3'b100, B=3'b010, C=3'b001} ns, cs;
  logic [2:0] cs_out;
  /*always_comb
    unique case (cs)
      A: begin //load zero
           ns = B;
           cl_L = 0;  ld_L = 1;
         end
      B: begin 	//add input
           ns = C;
           cl_L = 1;  ld_L = 0;
         end
      C: begin 	//add input
           ns = A;
           cl_L = 1;  ld_L = 0;
         end
    endcase*/
  assign #1 ns = (cs_out == A) ? B : (cs_out == B) ? C : A;
  assign #1 cl_L = (cs_out == A) ? 0 : 1;
  assign #1 ld_L = (cs_out == A) ? 1 : 0;

  always_ff @(posedge clock, negedge rst_L) begin
    if (~rst_L) cs <= A;
    else cs <= ns;
  end
  assign #1 cs_out = cs; // new delay added here

endmodule: fsm

module regLoad
  #(parameter W = 3)
  (input  logic [W-1:0]  D,
   input  logic          ld_L, cl_L,
   input  logic          clock, reset_L,
   output logic [W-1:0]  Q);
  
  logic [W-1:0] Q_intermediate;

  always_ff @(posedge clock,
              negedge reset_L) begin
    if (~reset_L)
      Q_intermediate <= 0;
    else  if (~cl_L)
      Q_intermediate <= 0;
    else if (~ld_L)
      Q_intermediate <= D;
              end
  assign #1  Q = Q_intermediate ;

endmodule: regLoad

module Adder
  #(parameter WIDTH = 16)
  (input logic [WIDTH-1:0] A, input logic [WIDTH-1:0] B,
  input logic cin, output logic cout, output logic [WIDTH-1:0] sum);
    assign #1 {cout, sum} = A+B+cin; //added delay of #1 here


  endmodule: Adder



module top_test();

  logic [15:0] inputA;
  logic        clock, rst_L;

  top dut(.*);

  initial begin
    clock = 0;
    rst_L = 0;
    rst_L <= 1;
    forever #5 clock = ~clock;
  end

  initial begin
    $monitor("Input(%h) Sum(%h) AdderOut(%h) CS(%s)",
             inputA, dut.sum, dut.addOut, dut.c1.cs.name);
    inputA <= 16'hF0F0;
    @(posedge clock);
    inputA <= 16'hF001;
    @(posedge clock);
    inputA <= 16'h00FF;
    @(posedge clock);
    inputA <= 16'h4321;
    @(posedge clock);
    #1 $finish;
  end
endmodule : top_test

