
module hw6prob5
(input logic start,
input logic [7:0] inputA,
input logic inputB, inputC,
output logic done,
output logic [7:0] value,
input logic clock, reset_L);

logic i_eq0, load, clear, cout, sel;
logic [8-1:0] sum, D;
fsm control (.*);
Register #(8) dut2(.en(load), .clear, .D, .clock, .Q(value));
Comparator #(1) dut3(.A(inputC), .B(1'b1),.AeqB(i_eq0));
assign done = ~i_eq0;
Adder #(8) dut4(.A(value), .B(inputA), .cin(1'b0), .cout , 
                       .sum); 
Comparator #(1) dut5(.A(inputB), .B(1'b1),.AeqB(sel));
Mux2to1 #(8) dut6 (.I0(value), .I1(sum), .S(sel), .Y(D));



endmodule: hw6prob5



module fsm 
  (input  logic clock, reset_L, i_eq0,
   input  logic start,
   output logic load, clear);

  enum  logic [1:0] {nothing = 2'b00, A = 2'b01, B = 2'b10, C = 2'b11} 
                    cur_state, n_state;

  always_comb begin
    case (cur_state)
      nothing: begin
        n_state = (start) ? A : nothing;
        clear = (start) ? 1 : 0;
        load = 0;//start ? 1 : 0;
      end
      A: begin  //State A
         n_state = i_eq0 ? B : C;
         clear = 0; //don't clear
         load = i_eq0 ? 1 : 0;
         end
      B: begin  //State B
         n_state = i_eq0 ? B : C;
         clear = 0; //don't clear
         load = i_eq0 ? 1 : 0;
         end
      C: begin
          n_state = nothing;
          clear = 0;
          load = 0;
         end 
    endcase
  end

  always_ff @(posedge clock, negedge reset_L) 
    if (~reset_L) 
      cur_state <= nothing;
    else 
      cur_state <= n_state;

endmodule: fsm
