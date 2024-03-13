module Comparator
  (input  logic [3:0] A, B,
   output logic       AeqB);

  assign AeqB = (A == B);

endmodule : Comparator

module Comparator_test();

  logic [3:0] A, B;
  logic       AeqB;

  Comparator dut(.*);

  initial begin
    $monitor("A(%h) B(%h) -> AeqB(%b)", A, B, AeqB);
       A = 4'h0; B = 4'h0;
    #5 A = 4'h1;
    #5 B = 4'h1;
    #5 B = 4'h2;
    #5 A = 4'hE;
    #5 B = 4'hD;
    #5 B = 4'hE;
    #5 B = 4'hF;
    #5 A = 4'hF;
    #5 A = 4'h0;
    #5 $finish;
  end

endmodule : Comparator_test




module MagComparator
(input logic [7:0] A,
input logic [7:0] B,
output logic AltB, AeqB, AgtB);
  //logic [7:0] diff;

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




module Adder
  (input  logic [7:0] A, B,
   input  logic       Cin,
   output logic [7:0] Sum,
   output logic       Cout);

  assign {Cout, Sum} = A + B + Cin;

endmodule : Adder

module Adder_test();

  logic [7:0] A, B, Sum;
  logic       Cin, Cout;

  Adder dut (.*);

  initial begin
    $monitor("%h + %h + %b = %b + %h", A, B, Cin, Cout, Sum);
       A = 8'h00; B = 8'h00; Cin = 1'B0;
    #5 A = 8'h01;
    #5 B = 8'h03;
    #5 Cin = 1'B1;
    #5 A = 8'hFB;
    #5 B = 8'hF4;
    #5 Cin = 1'B0;
    #5 B = 8'h5;
    #5 $finish;
  end

endmodule : Adder_test




module Subtracter
(input logic [7:0] A, input logic [7:0] B,
input logic bin, output logic bout, output logic [7:0] diff);
  assign {bout, diff} = A-B-bin;
endmodule: Subtracter


module Multiplexer
(input logic [7:0] I,
input logic [2:0] S,
output logic Y);
  always_comb begin
    unique case (S)
      3'b000: Y = I[0];
      3'b001: Y = I[1];
      3'b010: Y = I[2];
      3'b011: Y = I[3];
      3'b100: Y = I[4];
      3'b101: Y = I[5];
      3'b110: Y = I[6];
      3'b111: Y = I[7];
    endcase
  end
endmodule: Multiplexer



module Mux2to1
(input logic [7:0] I0,
input logic [7:0] I1,
input logic S,
output logic [7:0] Y);
  always_comb begin
    unique case (S)
      1'b1: Y = I1;
      1'b0: Y = I0;
    endcase

  end
endmodule: Mux2to1



module Decoder (
input logic [2:0] I,
input logic enable,
output logic [7:0] D);
  always_comb begin
    if (enable == 0) begin
        D = 8'b0000_0000;
    end
    else begin
        unique case(I)
          3'b000: D = 8'b0000_0001;
          3'b001: D = 8'b0000_0010;
          3'b010: D = 8'b0000_0100;
          3'b011: D = 8'b0000_1000;
          3'b100: D = 8'b0001_0000;
          3'b101: D = 8'b0010_0000;
          3'b110: D = 8'b0100_0000;
          3'b111: D = 8'b1000_0000;
        endcase
    end
  end
endmodule: Decoder
