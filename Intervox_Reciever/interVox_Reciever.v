module clock_Recovery(
  input   clock,
  input   reset,
  input   io_DATA_IN,
  output  io_CLK_OUT,
  output  io_DATA_OUT
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
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] _expected_cycles_syncword_T = 5'h10 * 3'h4; // @[intervox_receiver.scala 25:42]
  wire [7:0] expected_cycles_syncword = _expected_cycles_syncword_T - 8'h1; // @[intervox_receiver.scala 25:49]
  wire [4:0] expected_cycles_one = 5'h10 - 5'h1; // @[intervox_receiver.scala 27:36]
  reg [7:0] clkCntr1; // @[intervox_receiver.scala 32:30]
  reg [7:0] pllCntr; // @[intervox_receiver.scala 33:30]
  reg [7:0] bufCntr; // @[intervox_receiver.scala 34:30]
  reg [15:0] bitIn; // @[intervox_receiver.scala 35:30]
  reg [15:0] bitInBuf; // @[intervox_receiver.scala 36:30]
  reg  outReg; // @[intervox_receiver.scala 39:30]
  reg  sync_lo; // @[intervox_receiver.scala 41:30]
  reg  sync_hi; // @[intervox_receiver.scala 42:30]
  reg  change; // @[intervox_receiver.scala 44:30]
  reg  enaBuf; // @[intervox_receiver.scala 45:30]
  wire [7:0] _pllCntr_T_1 = pllCntr + 8'h1; // @[intervox_receiver.scala 53:24]
  wire  _outReg_T = ~outReg; // @[intervox_receiver.scala 55:19]
  wire  _GEN_0 = pllCntr == 8'h9 ? ~outReg : outReg; // @[intervox_receiver.scala 54:26 55:16 39:30]
  wire [7:0] _clkCntr1_T_1 = clkCntr1 + 8'h1; // @[intervox_receiver.scala 68:34]
  wire [6:0] _T_4 = expected_cycles_one * 2'h3; // @[intervox_receiver.scala 70:52]
  wire [7:0] _GEN_2 = {{1'd0}, _T_4}; // @[intervox_receiver.scala 70:27]
  wire  _GEN_3 = clkCntr1 == _GEN_2 | sync_lo; // @[intervox_receiver.scala 70:59 71:25 41:30]
  wire  _GEN_6 = clkCntr1 == expected_cycles_syncword | sync_hi; // @[intervox_receiver.scala 77:56 78:25 42:30]
  wire [255:0] _bitIn_T = 256'h1 << clkCntr1; // @[intervox_receiver.scala 96:35]
  wire [255:0] _GEN_35 = {{240'd0}, bitIn}; // @[intervox_receiver.scala 96:28]
  wire [255:0] _bitIn_T_1 = _GEN_35 | _bitIn_T; // @[intervox_receiver.scala 96:28]
  wire [255:0] _GEN_14 = io_DATA_IN ? _bitIn_T_1 : {{240'd0}, bitIn}; // @[intervox_receiver.scala 95:33 96:19 35:30]
  wire [7:0] _GEN_36 = {{3'd0}, expected_cycles_one}; // @[intervox_receiver.scala 100:23]
  wire  _GEN_16 = clkCntr1 == _GEN_36 | enaBuf; // @[intervox_receiver.scala 100:47 101:25 45:30]
  wire [255:0] _GEN_19 = clkCntr1 == _GEN_36 ? 256'h0 : _GEN_14; // @[intervox_receiver.scala 100:47 108:25]
  wire [7:0] _bufCntr_T_1 = bufCntr + 8'h1; // @[intervox_receiver.scala 114:32]
  wire [15:0] _T_18 = bitInBuf >> bufCntr; // @[intervox_receiver.scala 116:26]
  wire [7:0] _T_21 = bufCntr - 8'h1; // @[intervox_receiver.scala 116:57]
  wire [15:0] _T_22 = bitInBuf >> _T_21; // @[intervox_receiver.scala 116:48]
  wire [15:0] _T_26 = {{3'd0}, bitIn[15:3]}; // @[intervox_receiver.scala 123:27]
  wire [15:0] _T_28 = {{12'd0}, bitIn[15:12]}; // @[intervox_receiver.scala 123:42]
  wire  _T_30 = _T_26[0] != _T_28[0]; // @[intervox_receiver.scala 123:33]
  wire [255:0] _GEN_28 = sync_lo & sync_hi ? _GEN_19 : {{240'd0}, bitIn}; // @[intervox_receiver.scala 35:30 90:48]
  wire [255:0] _GEN_40 = reset ? 256'h0 : _GEN_28; // @[intervox_receiver.scala 35:{30,30}]
  assign io_CLK_OUT = outReg; // @[intervox_receiver.scala 47:21]
  assign io_DATA_OUT = change; // @[intervox_receiver.scala 48:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 32:30]
      clkCntr1 <= 8'h0; // @[intervox_receiver.scala 32:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 90:48]
      if (clkCntr1 == _GEN_36) begin // @[intervox_receiver.scala 100:47]
        clkCntr1 <= 8'h0; // @[intervox_receiver.scala 102:25]
      end else begin
        clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 92:18]
      end
    end else if (sync_lo) begin // @[intervox_receiver.scala 74:30]
      if (clkCntr1 == expected_cycles_syncword) begin // @[intervox_receiver.scala 77:56]
        clkCntr1 <= 8'h0; // @[intervox_receiver.scala 79:26]
      end else begin
        clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 75:22]
      end
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 67:33]
      clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 68:22]
    end
    if (reset) begin // @[intervox_receiver.scala 33:30]
      pllCntr <= 8'h0; // @[intervox_receiver.scala 33:30]
    end else if (pllCntr == 8'h9) begin // @[intervox_receiver.scala 54:26]
      pllCntr <= 8'h2; // @[intervox_receiver.scala 56:17]
    end else begin
      pllCntr <= _pllCntr_T_1; // @[intervox_receiver.scala 53:13]
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      bufCntr <= 8'h0; // @[intervox_receiver.scala 34:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 90:48]
      if (enaBuf) begin // @[intervox_receiver.scala 113:29]
        if (bufCntr == _GEN_36) begin // @[intervox_receiver.scala 119:50]
          bufCntr <= 8'h0; // @[intervox_receiver.scala 120:25]
        end else begin
          bufCntr <= _bufCntr_T_1; // @[intervox_receiver.scala 114:21]
        end
      end
    end
    bitIn <= _GEN_40[15:0]; // @[intervox_receiver.scala 35:{30,30}]
    if (reset) begin // @[intervox_receiver.scala 36:30]
      bitInBuf <= 16'h0; // @[intervox_receiver.scala 36:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 90:48]
      if (clkCntr1 == _GEN_36) begin // @[intervox_receiver.scala 100:47]
        if (bitIn <= 16'h7f00 & bitIn > 16'h0) begin // @[intervox_receiver.scala 104:53]
          bitInBuf <= bitIn; // @[intervox_receiver.scala 105:26]
        end
      end
    end
    if (reset) begin // @[intervox_receiver.scala 39:30]
      outReg <= 1'h0; // @[intervox_receiver.scala 39:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 90:48]
      if (enaBuf) begin // @[intervox_receiver.scala 113:29]
        if (_T_18[0] != _T_22[0]) begin // @[intervox_receiver.scala 116:64]
          outReg <= _outReg_T; // @[intervox_receiver.scala 117:24]
        end else begin
          outReg <= _GEN_0;
        end
      end else begin
        outReg <= _GEN_0;
      end
    end else begin
      outReg <= _GEN_0;
    end
    if (reset) begin // @[intervox_receiver.scala 41:30]
      sync_lo <= 1'h0; // @[intervox_receiver.scala 41:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 67:33]
      sync_lo <= _GEN_3;
    end
    if (reset) begin // @[intervox_receiver.scala 42:30]
      sync_hi <= 1'h0; // @[intervox_receiver.scala 42:30]
    end else if (sync_lo) begin // @[intervox_receiver.scala 74:30]
      sync_hi <= _GEN_6;
    end
    if (reset) begin // @[intervox_receiver.scala 44:30]
      change <= 1'h0; // @[intervox_receiver.scala 44:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 90:48]
      if (enaBuf) begin // @[intervox_receiver.scala 113:29]
        if (bufCntr == _GEN_36) begin // @[intervox_receiver.scala 119:50]
          change <= _T_30;
        end
      end
    end
    if (reset) begin // @[intervox_receiver.scala 45:30]
      enaBuf <= 1'h0; // @[intervox_receiver.scala 45:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 90:48]
      enaBuf <= _GEN_16;
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
  clkCntr1 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  pllCntr = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  bufCntr = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  bitIn = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  bitInBuf = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  outReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sync_lo = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sync_hi = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  change = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  enaBuf = _RAND_9[0:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 152:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 152:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 152:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 152:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 152:26]
  wire  pll_PLL_MCLK; // @[intervox_receiver.scala 160:21]
  wire  pll_locked; // @[intervox_receiver.scala 160:21]
  wire  pll_PLL_IN; // @[intervox_receiver.scala 160:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 152:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 160:21]
    .PLL_MCLK(pll_PLL_MCLK),
    .locked(pll_locked),
    .PLL_IN(pll_PLL_IN)
  );
  assign io_CLK_REC = pll_locked & pll_PLL_MCLK; // @[intervox_receiver.scala 166:32 167:20 171:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 155:25]
  assign io_NEXT_FRAME = 1'h0; // @[intervox_receiver.scala 156:25]
  assign io_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 157:25]
  assign io_DBUG1 = pll_locked; // @[intervox_receiver.scala 166:24]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 154:25]
  assign pll_PLL_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 163:19]
endmodule
