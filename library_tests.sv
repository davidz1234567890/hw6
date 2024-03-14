module Decoder_test;
    //logic enable;
    logic [3:0] in;
    logic [7:0] out;
    Decoder #(8) DUT(in[2:0], in[3], out);
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
    BarrelShifter #(4) DUT(v, by, result);
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
    Multiplexer #(8) DUT(I, S, Y);
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

    Mux2to1 #(8) DUT(I0, I1, S, out);
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
    MagComparator #(8) DUT(A, B, AltB, AeqB, AgtB);
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
    Comparator #(4) DUT(A, B, AeqB);
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
    Adder #(8) DUT(A, B, cin, cout, sum);
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
    Subtracter #(8) DUT(A, B, bin, bout, diff);
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



  module dff_test;
    logic D;
    logic Q;
    logic clock, reset_L, preset_L;
    
    DFlipFlop dut(.*);
    initial begin
      clock = 0;
      reset_L = 0;
      reset_L <= 1;
      forever #5 clock = ~clock;
    end
  
     initial begin
          $monitor($time,, "Q=%b, D=%d, reset_L=%b, preset_L=%b",
          Q, D, reset_L, preset_L);
          preset_L <= 1;
          D <= 0;
          @(posedge clock);
          D <= 1;
          @(posedge clock);
          D <= 1;
          @(posedge clock);
          D <= 1;
          @(posedge clock);
          reset_L = 0;
          #3 reset_L <= 1;
          @(posedge clock);
          D <= 1;
          @(posedge clock);
          D <= 0;
          @(posedge clock);
          $finish;
     end
  endmodule: dff_test



  module Register_test;
    logic [7:0] D;
    logic [7:0] Q;
    logic clock, en, clear;
    
    Register #(8) dut(.*);
    initial begin
      clock = 0;
      forever #5 clock = ~clock;
    end
  
     initial begin
          $monitor($time,, "Q=%d, D=%d, enable=%b, clear=%b",
          Q, D, en, clear);
          en <= 0;
          clear <= 0;
          D <= 8'b0110_0011;
          @(posedge clock);
          D <= 8'b1111_1111;
          @(posedge clock);
          en <= 1;
          @(posedge clock);
          D <= 8'b0110_0011;
          @(posedge clock);
          D <= 8'd8;
          en <= 0;
          @(posedge clock);
          clear <= 1;
          @(posedge clock);
          clear <= 0;
          en <= 1;
          @(posedge clock);
          D <= 8'd10;
          @(posedge clock);
          clear <= 1;
          D <= 8'd55;
          @(posedge clock);
          @(posedge clock);
          $finish;
     end
  endmodule: Register_test



  module Counter_test;
    logic en, clear, load, up;
    logic [7:0] D;
    logic clock;
    logic [7:0] Q;
    Counter #(8) dut(.*);
    initial begin
      clock = 0;
      forever #5 clock = ~clock;
    end

    initial begin
      $monitor($time,, "Q=%d, D=%d,  clear=%b, load=%b, enable=%b, up=%b",
      Q, D,  clear, load, en, up);
      en <= 0;
      clear <= 0;
      load <= 0;
      up <= 0;
      D <= 8'b0110_0011;
      @(posedge clock);
      clear <= 1;
      @(posedge clock);
      clear <= 0;
      en <= 1;
      @(posedge clock);
      en <= 0;
      up <= 1;
      @(posedge clock);
      up <= 0;
      @(posedge clock);
      load <= 1;
      @(posedge clock);
      clear <= 1;
      @(posedge clock);
      clear <= 0;
      en <= 1; up <= 1;
      @(posedge clock);
      load <= 0;
      @(posedge clock);
      @(posedge clock);
      @(posedge clock);
      up <= 0;
      @(posedge clock);
      @(posedge clock);
      $finish;
 end



  endmodule: Counter_test



  module Synchronizer_test;
    logic async, clock, sync;
    Synchronizer dut(.*);
    initial begin
      clock = 0;
      forever #5 clock = ~clock;
    end


    initial begin
      $monitor($time,, "sync=%d, async=%d",
       sync, async);

       async <= 0;
       @(posedge clock);
       async <= 1;
       @(posedge clock);
       async <= 0;
       @(posedge clock);
       async <= 1;
       @(posedge clock);
       async <= 0;
       @(posedge clock);
       async <= 1;
       @(posedge clock);
      $finish;
 end
  endmodule: Synchronizer_test


  module ShiftRegister_SIPO_test;
    logic en, left, serial,clock;
    logic [8-1:0] Q;
    ShiftRegister_SIPO #(8) dut(.*);
    initial begin
      clock = 0;
      forever #5 clock = ~clock;
    end


    initial begin
      $monitor($time,, "Q=%b, en = %d, left = %d, serial = %d",
       Q, en , left, serial);

       en <= 0;
       left <= 3;
       serial <= 0;
       
       @(posedge clock);
       
       @(posedge clock);
       en <= 1;
       @(posedge clock);
       left <= 1;
       @(posedge clock);
       left <= 0; 
       serial <= 1;
       @(posedge clock);
       serial <= 0;
       @(posedge clock);
       @(posedge clock);
       en <= 0; 
       @(posedge clock);
       serial <= 1;
       @(posedge clock);
       serial <= 0;
       @(posedge clock);
       @(posedge clock);
      #1 $finish;
 end
  endmodule: ShiftRegister_SIPO_test



  module ShiftRegister_PIPO_test;
    logic en, left, load, clock;
    logic [8-1:0] D, Q;
    ShiftRegister_PIPO #(8) dut(.*);
    initial begin
      clock = 0;
      forever #5 clock = ~clock;
    end


    initial begin
      $monitor($time,, "Q=%b, D = %b, en = %d, left = %d, load = %d",
       Q, D, en , left, load);

       en <= 0;
       left <= 0;
       load <= 0;
       D <= 8'b1101_0100;
       @(posedge clock);
       en <= 1;load <= 1;
       @(posedge clock);
       left <= 1; load <= 0;
       @(posedge clock);
       
       @(posedge clock);
       
       @(posedge clock);
       
       @(posedge clock);
       left <= 0;
       @(posedge clock);
       @(posedge clock);
       @(posedge clock);
       @(posedge clock);
      $finish;
 end
  endmodule: ShiftRegister_PIPO_test



  module BarrelShiftRegister_test;
    logic en, load;
    logic [1:0] by;
    logic [8-1:0] D;
    logic clock;
    logic [8-1:0] Q;
    BarrelShiftRegister #(8) dut(.*);
    initial begin
      clock = 0;
      forever #5 clock = ~clock;
    end


    initial begin
      $monitor($time,, "Q=%b, D = %b, load = %d, en = %d, by = %d",
       Q, D, load , en, by);

       en <= 0;
       load <= 0;
       D <= 8'b0000_0001;
       @(posedge clock);
       en <= 1;load <= 1;
       @(posedge clock);
       by <= 2'b01; load <= 0;
       @(posedge clock);
       
       @(posedge clock);
       by <= 2'd3;
       @(posedge clock);
       by <= 2'd0;
       @(posedge clock);
       @(posedge clock);
       D <= 8'b1111_1111;
       load <= 1;
       @(posedge clock);
       @(posedge clock);
       load <= 0; by <= 2'd2;
       @(posedge clock);
       @(posedge clock);
       @(posedge clock);
      $finish;
 end
  endmodule: BarrelShiftRegister_test

