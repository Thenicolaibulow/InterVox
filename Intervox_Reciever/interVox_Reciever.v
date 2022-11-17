module clock_Recovery(
  input   clock,
  input   reset,
  input   io_DATA_IN,
  output  io_CLK_OUT
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [8:0] _expected_cycles_syncword_T = 6'h20 * 3'h4; // @[intervox_receiver.scala 11:42]
  wire [8:0] expected_cycles_syncword = _expected_cycles_syncword_T - 9'h1; // @[intervox_receiver.scala 11:49]
  wire [6:0] expected_cycles_zero = 7'h40 - 7'h1; // @[intervox_receiver.scala 12:37]
  wire [5:0] expected_cycles_one = 6'h20 - 6'h1; // @[intervox_receiver.scala 13:36]
  reg [7:0] clkCntr; // @[intervox_receiver.scala 15:30]
  reg  outReg; // @[intervox_receiver.scala 18:30]
  wire [7:0] _clkCntr_T_1 = clkCntr + 8'h1; // @[intervox_receiver.scala 31:32]
  wire [7:0] _GEN_3 = io_DATA_IN ? _clkCntr_T_1 : clkCntr; // @[intervox_receiver.scala 25:23 37:21 15:30]
  wire [7:0] _GEN_5 = ~io_DATA_IN ? _clkCntr_T_1 : _GEN_3; // @[intervox_receiver.scala 25:23 31:21]
  wire [8:0] _T_5 = expected_cycles_syncword - 9'h10; // @[intervox_receiver.scala 42:47]
  wire [8:0] _GEN_19 = {{1'd0}, clkCntr}; // @[intervox_receiver.scala 42:18]
  wire [7:0] _GEN_7 = _GEN_19 >= expected_cycles_syncword ? 8'h0 : _GEN_5; // @[intervox_receiver.scala 48:52 50:21]
  wire [7:0] _GEN_9 = _GEN_19 >= _T_5 ? _GEN_7 : _GEN_5; // @[intervox_receiver.scala 42:55]
  wire [5:0] _T_9 = expected_cycles_one / 2'h2; // @[intervox_receiver.scala 54:42]
  wire [7:0] _GEN_21 = {{2'd0}, _T_9}; // @[intervox_receiver.scala 54:18]
  wire [7:0] _GEN_22 = {{2'd0}, expected_cycles_one}; // @[intervox_receiver.scala 58:22]
  wire [7:0] _GEN_11 = clkCntr >= _GEN_22 ? 8'h0 : _GEN_9; // @[intervox_receiver.scala 58:47 59:21]
  wire [7:0] _GEN_13 = clkCntr >= _GEN_21 ? _GEN_11 : _GEN_9; // @[intervox_receiver.scala 54:49]
  wire [6:0] _T_13 = expected_cycles_zero / 2'h2; // @[intervox_receiver.scala 63:43]
  wire [7:0] _GEN_23 = {{1'd0}, _T_13}; // @[intervox_receiver.scala 63:18]
  wire [7:0] _GEN_24 = {{1'd0}, expected_cycles_zero}; // @[intervox_receiver.scala 67:22]
  assign io_CLK_OUT = outReg; // @[intervox_receiver.scala 23:16]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 15:30]
      clkCntr <= 8'h0; // @[intervox_receiver.scala 15:30]
    end else if (clkCntr >= _GEN_23) begin // @[intervox_receiver.scala 63:50]
      if (clkCntr >= _GEN_24) begin // @[intervox_receiver.scala 67:48]
        clkCntr <= 8'h0; // @[intervox_receiver.scala 68:21]
      end else begin
        clkCntr <= _GEN_13;
      end
    end else begin
      clkCntr <= _GEN_13;
    end
    if (reset) begin // @[intervox_receiver.scala 18:30]
      outReg <= 1'h0; // @[intervox_receiver.scala 18:30]
    end else if (clkCntr == 8'h10) begin // @[intervox_receiver.scala 72:27]
      outReg <= ~outReg; // @[intervox_receiver.scala 73:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  clkCntr = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  outReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module interVox_Reciever(
  input   clock,
  input   reset,
  input   io_INTERVOX_IN,
  output  io_CLK_REC
);
  wire  clockRec_clock; // @[intervox_receiver.scala 84:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 84:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 84:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 84:26]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 84:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT)
  );
  assign io_CLK_REC = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 87:16]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 86:25]
endmodule
