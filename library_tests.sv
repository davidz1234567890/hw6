module Decoder_test;
  //logic enable;
  logic [3:0] in;
  logic [7:0] out;
  Decoder DUT(in[2:0], in[3], out);
  initial begin

    $monitor ($time,
    " input=%b, enable=%b, output = %b",
    in[2:0], in[3], out);
    for (in=4'b0; in < 4'b1111;
    in++)

      #10;

    //#10 $finish;
  end






endmodule: Decoder_test




module BarrelShifter_test;
  logic [3:0] by;
  logic [15:0] v;
  logic [15:0] result;
  BarrelShifter DUT(v, by, result);
  initial begin
    $monitor ($time, "v = %b, by = %b, result = %b", v, by, result);
    v = 16'd15;
    by = 4'd4;
    #10 v = 16'd130;
        by = 4'd15;
    #10 v = 16'd78;
        by = 4'd9;
    #10 v = 16'b1111_1111_1111_1111;
        by = 4'd7;
    //#10 $finish;
    #10 v = 16'b1101_1011_0111_1110;
        by = 4'd0;
    #10 by = 4'd1;
    #10 by = 4'd2;
    #10 by = 4'd3;
    #10 by = 4'd5;
    #10 by = 4'd7;
    #10 by = 4'd9;
    #10 by = 4'd11;
    #10 by = 4'd14;
    #10 by = 4'd15;

  end
endmodule: BarrelShifter_test





module Multiplexer_test;
  logic [7:0] I;
  logic [2:0] S;
  logic Y;
  Multiplexer DUT(I, S, Y);
  initial begin
    $monitor ($time, "I = %b, S = %b, Y = %b", I, S, Y);
    I = 8'd15;
    S = 3'd4;
    #10 I = 8'd27;
        S = 3'd3;
    #10 I = 8'd62;
        S = 3'd0;
    #10 I = 8'b1001_0111;
        S = 3'd7;
    //#10 $finish;
    #10 I = 8'h00;
        S = 3'h0;
    #10 S = 3'h1;
    #10 S = 3'h2;
    #10 S = 3'h6;
    #10 S = 3'h7;

    #10 I = 8'hDF;
        S = 3'h0;
    #10 S = 3'h1;
    #10 S = 3'h2;
    #10 S = 3'h6;
    #10 S = 3'h7;

    #10 I = 8'hF4;
        S = 3'h0;
    #10 S = 3'h1;
    #10 S = 3'h3;
    #10 S = 3'h4;
    #10 S = 3'h7;

  end





endmodule: Multiplexer_test



module Mux2to1_test;
  logic [7:0] I0;
  logic [7:0] I1;
  logic S;
  logic [7:0] out;

  Mux2to1 DUT(I0, I1, S, out);
  initial begin
    $monitor ($time, "I0 = %b, I1 = %b, S = %b, out = %b", I0, I1, S, out);
    I0 = 8'b1010_1010;
    I1 = 8'b1111_0000;
    S = 1;
    #10 S = 0;
    #10 I0 = 8'b0000_1111;
        I1 = 8'b0000_0000;
    #10 S = 1;
    #10 I0 = 8'hDF;
        I1 = 8'hF0;
        S = 1;
    #10 S = 0;
    #10 I0 = 8'hD1;
    #10 S = 1;
    #10 S = 0;

  end
endmodule: Mux2to1_test


module MagComparator_test;
  logic [7:0] A;
  logic [7:0] B;
  logic AltB, AeqB, AgtB;
  MagComparator DUT(A, B, AltB, AeqB, AgtB);
  initial begin
    $monitor($time, "A = %b, B = %b, AltB = %b, AeqB = %b, AgtB = %b",
             A, B, AltB, AeqB, AgtB);
    A = 8'd16;
    B = 8'd15;
    #10 B = 8'd100;
    #10 A = 8'd100;
    #10 A = 8'b0111_1111;
    #10 B = 8'b1111_1111;
    #10 A = 8'b1000_0000;
    #10 B = 8'b0111_1111;
    #10 B = 8'd1;
  end
endmodule:MagComparator_test

module Comparator_test;
  logic [3:0] A;
  logic [3:0] B;
  logic AeqB;
  Comparator DUT(A, B, AeqB);
  initial begin
    $monitor($time, "A = %b, B = %b, AeqB = %b", A, B, AeqB);
    A = 4'd14;
    B = 4'd13;
    #10 B = 4'd14;
    #10 A = 4'd0;
    #10 A = 4'd15;
    #10 A = 4'd14;
    #10 B = 4'd1;
    #10 B = 4'd14;
  end
endmodule: Comparator_test



module Adder_test;
  logic [7:0] A;
  logic [7:0] B;
  logic cin;
  logic cout;
  logic [7:0] sum;
  Adder DUT(A, B, cin, cout, sum);
  initial begin
    $monitor($time, "cin = %b, A = %b , B = %b, cout = %b, sum = %b\n",
    cin, A, B, cout, sum);
    A = 8'b0101_0101;
    B = 8'b0000_1111;
    cin = 1;
    #10 cin = 0;
    #10 A = 8'b1111_0000;
    #10 B = 8'b0001_1111;
    #10 A = 8'd0;
    #10 B = 8'hFF;
    #10 cin = 1;
    #10 A = 8'd2;
    #10 B = 8'd3;
    #10 A = 8'b1111_1100;
    #10 cin = 1;
  end


endmodule: Adder_test

module Subtracter_test;
  logic [7:0] A;
  logic [7:0] B;
  logic bin, bout;
  logic [7:0] diff;
  Subtracter DUT(A, B, bin, bout, diff);
  initial begin
    $monitor($time, "bin = %b, A = %b, B = %b, bout = %b, diff = %b\n",
    bin, A, B, bout, diff);
    A = 8'b1111_1111;
    B = 8'd5;
    bin = 1;
    #10 bin = 0;
    #10 A= 8'd1;
    #10 B = 8'd3;
    #10 bin = 1;
    #10 A = 8'd10;
    #10 B = 8'd10;
    #10 bin = 0;
    #10 A = 8'd15;
    #10 A = 8'b1111_0000;
  end
endmodule: Subtracter_test
