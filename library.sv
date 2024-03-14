`default_nettype none

module Decoder
    #(parameter WIDTH = 16)
    (
    input logic [$clog2(WIDTH)-1:0] I,
    input logic enable,
    output logic [WIDTH-1:0] D);
      always_comb begin
        if (enable == 0) begin
            D = '0;
        end
        else begin
            /*unique case(I)
              3'b000: D = 8'b0000_0001;
              3'b001: D = 8'b0000_0010;
              3'b010: D = 8'b0000_0100;
              3'b011: D = 8'b0000_1000;
              3'b100: D = 8'b0001_0000;
              3'b101: D = 8'b0010_0000;
              3'b110: D = 8'b0100_0000;
              3'b111: D = 8'b1000_0000;
            endcase*/
            D = '0;
            D[I] = 1;
        end
      end
    endmodule: Decoder

    module BarrelShifter
    #(parameter WIDTH = 8)
    (input logic [2**WIDTH-1:0] V,
    input logic [WIDTH-1:0] by,
    output logic [2**WIDTH-1:0] S);
      always_comb begin
        /*unique case (by)

        4'b0000: S = V;
          4'b0001: S = V << 1;
          4'b0010: S = V << 2;
          4'b0011: S = V << 3;
          4'b0100: S = V << 4;
          4'b0101: S = V << 5;
          4'b0110: S = V << 6;
          4'b0111: S = V << 7;
          4'b1000: S = V << 8;
          4'b1001: S = V << 9;
          4'b1010: S = V << 10;
          4'b1011: S = V << 11;
          4'b1100: S = V << 12;
          4'b1101: S = V << 13;
          4'b1110: S = V << 14;
          4'b1111: S = V << 15;
        endcase*/
        assign S = V << by;
      end
    endmodule: BarrelShifter

    module Multiplexer
    #(parameter WIDTH = 32)
    (input logic [WIDTH-1:0] I,
    input logic [$clog2(WIDTH)-1:0] S,
    output logic Y);
      always_comb begin
        /*unique case (S)
          3'b000: Y = I[0];
          3'b001: Y = I[1];
          3'b010: Y = I[2];
          3'b011: Y = I[3];
          3'b100: Y = I[4];
          3'b101: Y = I[5];
          3'b110: Y = I[6];
          3'b111: Y = I[7];
        endcase*/
        assign Y = '0;
        assign Y = I[S];
      end
    endmodule: Multiplexer

    module Mux2to1
        #(parameter WIDTH = 3)
    (input logic [WIDTH-1:0] I0,
    input logic [WIDTH-1:0] I1,
    input logic S,
    output logic [WIDTH-1:0] Y);
      always_comb begin
        unique case (S)
          1'b1: Y = I1;
          1'b0: Y = I0;
        endcase

      end
    endmodule: Mux2to1

    module MagComparator
    #(parameter WIDTH = 16)
    (input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,
    output logic AltB, AeqB, AgtB);
      //logic [WIDTH-1:0] diff;

      /*assign diff = (A - B);
      assign AeqB = (diff == 8'b0000_0000);
      assign AgtB = ((A[7] == 0 && B[7] == 1) ||
                    (A[7] == B[7] && diff[7] == 1'b0 && !AeqB));
      assign AltB = ((A[7] == 1 && B[7] == 0) ||
                    (A[7] == B[7] && diff[7] == 1'b1));*/

      assign AeqB = (A == B);
      assign AgtB = (A > B);
      assign AltB = (A < B);
    endmodule: MagComparator

    module Comparator
    #(parameter WIDTH = 8)
    (input logic [WIDTH-1:0] A,
    input logic [WIDTH-1:0] B,
    output logic AeqB);
      assign AeqB = (A == B);
    endmodule: Comparator


    module Adder
    #(parameter WIDTH = 16)
    (input logic [WIDTH-1:0] A, input logic [WIDTH-1:0] B,
    input logic cin, output logic cout, output logic [WIDTH-1:0] sum);
      assign {cout, sum} = A+B+cin;


    endmodule: Adder



    module Subtracter
    #(parameter WIDTH = 16)
    (input logic [WIDTH-1:0] A, input logic [WIDTH-1:0] B,
    input logic bin, output logic bout, output logic [WIDTH-1:0] diff);
      assign {bout, diff} = A-B-bin;
    endmodule: Subtracter





  module DFlipFlop
    (input logic D, clock, reset_L, preset_L,
      output logic Q);
    always_ff @(posedge clock, negedge reset_L, negedge preset_L)
    if (~reset_L & ~preset_L)
      Q <= 1'bX;
    
    else if (~reset_L & preset_L)
        Q <= 0;
    else if (reset_L & ~preset_L)
        Q <= 1;
    else
        Q <= D;
    endmodule: DFlipFlop

  //comment made here

    module Register
        #(parameter WIDTH=32)
        (input logic en, clear,
         input logic [WIDTH-1:0] D,
          input logic clock,
         output logic [WIDTH-1:0] Q);
         
        always_ff @(posedge clock)
          if (en)
            Q <= D;
          else if (clear)
            Q <= '0;
            
      endmodule : Register



      module Counter
        #(parameter WIDTH=32)
        (input logic en, clear, load, up,
         input logic [WIDTH-1:0] D,
         input  logic clock,
         output logic [WIDTH-1:0] Q);
         
        always_ff @(posedge clock)
          if (clear)
            Q <= '0;
          else if (load)
            Q <= D;
          else if (en & up)
            Q <= Q + 1;
        // Else if en & ~up, count down
          else if (en & ~up)
            Q <= Q - 1;
              
      endmodule : Counter



      module Synchronizer
        (input logic async, clock,
         output logic sync);
        logic preset_L, reset_L;
        logic ff_buf;
        // Synchronize the signal by running it through two flip-flops (buffering)
        
        assign preset_L = 1'b1; //not asserted
        assign reset_L = 1'b1; //not asserted
        DFlipFlop dut1(.D(async),.Q(ff_buf), .clock,.preset_L,.reset_L);
        DFlipFlop dut2(.D(ff_buf),.Q(sync),.clock,.preset_L, .reset_L);
    
    endmodule: Synchronizer



    module ShiftRegister_SIPO
        #(parameter WIDTH=32)
        (input  logic en, left, serial,clock,
         output logic [WIDTH-1:0] Q);
         
        always_ff @(posedge clock)
          if (en & left)
            Q <= {Q[WIDTH-2:0], serial};
          else if(en & ~left)
            Q <= {serial, Q[WIDTH-1:1]};
              
      endmodule : ShiftRegister_SIPO



      module ShiftRegister_PIPO
        #(parameter WIDTH=16)
        (input logic en, left, load, 
        input  logic [WIDTH-1:0] D,
        input logic clock,
         output logic [WIDTH-1:0] Q);
         
        always_ff @(posedge clock)
          if (load)
            Q <= D;
          else if (en & left)
            Q <= {Q[WIDTH-2:0], 1'b0};
          else if (en & ~left)
            Q <= {1'b0, Q[WIDTH-1:1]};
              
      endmodule : ShiftRegister_PIPO



      module BarrelShiftRegister
        #(parameter WIDTH=32)
        (input logic en, load,
        input logic [1:0] by,
         input logic [WIDTH-1:0] D,
         input  logic clock,
         output logic [WIDTH-1:0] Q);
         
        
        always_ff @(posedge clock)
          if (load)
              Q <= D;
          else if (en)
              Q <= (Q << by);
          
      endmodule : BarrelShiftRegister
      
