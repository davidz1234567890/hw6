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

module BarrelShifter
(input logic [15:0] V,
input logic [3:0] by,
output logic [15:0] S);
  always_comb begin
    unique case (by)
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
    endcase
  end
endmodule: BarrelShifter

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

module Comparator
(input logic [3:0] A,
input logic [3:0] B,
output logic AeqB);
  assign AeqB = (A == B);
endmodule: Comparator


module Adder
(input logic [7:0] A, input logic [7:0] B,
input logic cin, output logic cout, output logic [7:0] sum);
  assign {cout, sum} = A+B+cin;


endmodule: Adder



module Subtracter
(input logic [7:0] A, input logic [7:0] B,
input logic bin, output logic bout, output logic [7:0] diff);
  assign {bout, diff} = A-B-bin;
endmodule: Subtracter
