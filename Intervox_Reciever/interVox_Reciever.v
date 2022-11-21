module clock_Recovery(
  input   clock,
  input   reset,
  input   io_DATA_IN,
  output  io_CLK_OUT,
  output  io_DATA_OUT,
  output  io_NEXT_FRAME
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] clkCntr; // @[intervox_receiver.scala 26:30]
  reg [7:0] clkCntr1; // @[intervox_receiver.scala 27:30]
  reg [7:0] clkDelta; // @[intervox_receiver.scala 28:30]
  reg [7:0] pllCntr; // @[intervox_receiver.scala 29:30]
  reg [1:0] inBufr; // @[intervox_receiver.scala 30:30]
  reg  outReg; // @[intervox_receiver.scala 32:30]
  reg  change; // @[intervox_receiver.scala 33:30]
  reg  nextFrame; // @[intervox_receiver.scala 34:30]
  wire [7:0] _pllCntr_T_1 = pllCntr + 8'h1; // @[intervox_receiver.scala 41:24]
  wire [1:0] _clkCntr_T_1 = clkCntr + 2'h1; // @[intervox_receiver.scala 54:28]
  wire [7:0] _clkCntr1_T_1 = clkCntr1 + 8'h1; // @[intervox_receiver.scala 56:29]
  wire  _GEN_3 = clkCntr == 2'h1 ? 1'h0 : change; // @[intervox_receiver.scala 58:26 60:16 33:30]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_receiver.scala 65:30]
  wire [1:0] _GEN_4 = inBufr < 2'h3 ? _inBufr_T_1 : inBufr; // @[intervox_receiver.scala 64:27 65:20 30:30]
  wire [1:0] _GEN_5 = io_DATA_IN ? _GEN_4 : inBufr; // @[intervox_receiver.scala 63:29 30:30]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_receiver.scala 70:30]
  wire  _GEN_8 = clkCntr1 > 8'h20 ? 1'h0 : nextFrame; // @[intervox_receiver.scala 75:28 34:30 75:39]
  wire  _GEN_9 = inBufr[0] != inBufr[1] | _GEN_3; // @[intervox_receiver.scala 79:38 80:20]
  wire  _GEN_15 = clkDelta > 8'h0 & clkDelta < 8'ha | _GEN_8; // @[intervox_receiver.scala 91:{47,58}]
  assign io_CLK_OUT = outReg; // @[intervox_receiver.scala 36:21]
  assign io_DATA_OUT = change; // @[intervox_receiver.scala 37:21]
  assign io_NEXT_FRAME = nextFrame; // @[intervox_receiver.scala 38:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 26:30]
      clkCntr <= 2'h0; // @[intervox_receiver.scala 26:30]
    end else if (clkCntr == 2'h1) begin // @[intervox_receiver.scala 58:26]
      clkCntr <= 2'h0; // @[intervox_receiver.scala 59:17]
    end else begin
      clkCntr <= _clkCntr_T_1; // @[intervox_receiver.scala 54:17]
    end
    if (reset) begin // @[intervox_receiver.scala 27:30]
      clkCntr1 <= 8'h0; // @[intervox_receiver.scala 27:30]
    end else if (~change) begin // @[intervox_receiver.scala 77:25]
      if (inBufr[0] != inBufr[1]) begin // @[intervox_receiver.scala 79:38]
        clkCntr1 <= 8'h0; // @[intervox_receiver.scala 81:22]
      end else begin
        clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 56:17]
      end
    end else begin
      clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 56:17]
    end
    if (reset) begin // @[intervox_receiver.scala 28:30]
      clkDelta <= 8'h0; // @[intervox_receiver.scala 28:30]
    end else if (~change) begin // @[intervox_receiver.scala 77:25]
      if (inBufr[0] != inBufr[1]) begin // @[intervox_receiver.scala 79:38]
        clkDelta <= clkCntr1; // @[intervox_receiver.scala 82:22]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 29:30]
      pllCntr <= 8'h0; // @[intervox_receiver.scala 29:30]
    end else if (pllCntr == 8'h7) begin // @[intervox_receiver.scala 42:26]
      pllCntr <= 8'h0; // @[intervox_receiver.scala 46:17]
    end else begin
      pllCntr <= _pllCntr_T_1; // @[intervox_receiver.scala 41:13]
    end
    if (reset) begin // @[intervox_receiver.scala 30:30]
      inBufr <= 2'h0; // @[intervox_receiver.scala 30:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 68:29]
      if (inBufr > 2'h0) begin // @[intervox_receiver.scala 69:27]
        inBufr <= _inBufr_T_3; // @[intervox_receiver.scala 70:20]
      end else begin
        inBufr <= _GEN_5;
      end
    end else begin
      inBufr <= _GEN_5;
    end
    if (reset) begin // @[intervox_receiver.scala 32:30]
      outReg <= 1'h0; // @[intervox_receiver.scala 32:30]
    end else if (pllCntr == 8'h7) begin // @[intervox_receiver.scala 42:26]
      outReg <= ~outReg; // @[intervox_receiver.scala 45:16]
    end
    if (reset) begin // @[intervox_receiver.scala 33:30]
      change <= 1'h0; // @[intervox_receiver.scala 33:30]
    end else if (~change) begin // @[intervox_receiver.scala 77:25]
      change <= _GEN_9;
    end else if (clkCntr == 2'h1) begin // @[intervox_receiver.scala 58:26]
      change <= 1'h0; // @[intervox_receiver.scala 60:16]
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      nextFrame <= 1'h0; // @[intervox_receiver.scala 34:30]
    end else if (clkDelta > 8'ha & clkDelta < 8'h20) begin // @[intervox_receiver.scala 93:48]
      nextFrame <= 1'h0; // @[intervox_receiver.scala 93:59]
    end else begin
      nextFrame <= _GEN_15;
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
  clkCntr = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  clkCntr1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  clkDelta = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  pllCntr = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  inBufr = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  outReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  change = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  nextFrame = _RAND_7[0:0];
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
  output  io_CLK_REC,
  output  io_DATA_OUT,
  output  io_NEXT_FRAME,
  output  io_DBUG,
  output  io_DBUG1
);
  wire  clockRec_clock; // @[intervox_receiver.scala 108:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 108:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 108:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 108:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 108:26]
  wire  clockRec_io_NEXT_FRAME; // @[intervox_receiver.scala 108:26]
  wire  pll_PLL_MCLK; // @[intervox_receiver.scala 116:21]
  wire  pll_locked; // @[intervox_receiver.scala 116:21]
  wire  pll_PLL_IN; // @[intervox_receiver.scala 116:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 108:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_NEXT_FRAME(clockRec_io_NEXT_FRAME)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 116:21]
    .PLL_MCLK(pll_PLL_MCLK),
    .locked(pll_locked),
    .PLL_IN(pll_PLL_IN)
  );
  assign io_CLK_REC = pll_locked & pll_PLL_MCLK; // @[intervox_receiver.scala 122:32 123:20 127:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 111:25]
  assign io_NEXT_FRAME = clockRec_io_NEXT_FRAME; // @[intervox_receiver.scala 112:25]
  assign io_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 113:25]
  assign io_DBUG1 = pll_locked; // @[intervox_receiver.scala 122:24]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 110:25]
  assign pll_PLL_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 119:19]
endmodule
