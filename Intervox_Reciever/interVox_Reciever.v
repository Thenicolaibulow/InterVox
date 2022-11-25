module clock_Recovery(
  input   clock,
  input   reset,
  input   io_DATA_IN,
  output  io_CLK_OUT,
  output  io_DATA_OUT,
  output  io_DBUG,
  output  io_DBUG1
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
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] clkCntr; // @[intervox_receiver.scala 27:30]
  reg [7:0] clkCntr1; // @[intervox_receiver.scala 28:30]
  reg [3:0] clkCntr2; // @[intervox_receiver.scala 29:30]
  reg [7:0] clkDelta; // @[intervox_receiver.scala 31:30]
  reg [7:0] lastOne; // @[intervox_receiver.scala 32:30]
  reg [1:0] inBufr; // @[intervox_receiver.scala 34:30]
  reg [1:0] whatChange; // @[intervox_receiver.scala 35:30]
  reg  clkRec; // @[intervox_receiver.scala 38:30]
  reg  change; // @[intervox_receiver.scala 39:30]
  reg  dataOut; // @[intervox_receiver.scala 40:30]
  reg  zeroPeriode; // @[intervox_receiver.scala 42:30]
  wire [1:0] _clkCntr_T_1 = clkCntr + 2'h1; // @[intervox_receiver.scala 55:28]
  wire [7:0] _clkCntr1_T_1 = clkCntr1 + 8'h1; // @[intervox_receiver.scala 57:29]
  wire  _GEN_1 = clkCntr == 2'h1 ? 1'h0 : change; // @[intervox_receiver.scala 59:26 61:16 39:30]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_receiver.scala 66:30]
  wire [1:0] _GEN_2 = inBufr < 2'h3 ? _inBufr_T_1 : inBufr; // @[intervox_receiver.scala 65:27 66:20 34:30]
  wire [1:0] _GEN_3 = io_DATA_IN ? _GEN_2 : inBufr; // @[intervox_receiver.scala 64:29 34:30]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_receiver.scala 71:30]
  wire  _T_5 = ~change; // @[intervox_receiver.scala 74:17]
  wire  _GEN_6 = inBufr[0] != inBufr[1] | _GEN_1; // @[intervox_receiver.scala 76:38 77:20]
  wire  _GEN_14 = clkDelta > 8'h0 & clkDelta < 8'ha | dataOut; // @[intervox_receiver.scala 100:17 40:30 99:47]
  wire [3:0] _clkCntr2_T_1 = clkCntr2 + 4'h1; // @[intervox_receiver.scala 129:34]
  wire [1:0] _whatChange_T_1 = whatChange - 2'h1; // @[intervox_receiver.scala 131:42]
  wire [1:0] _whatChange_T_3 = whatChange + 2'h1; // @[intervox_receiver.scala 135:38]
  wire [7:0] _T_22 = lastOne - 8'h1; // @[intervox_receiver.scala 138:39]
  wire [7:0] _GEN_12 = {{4'd0}, clkCntr2}; // @[intervox_receiver.scala 138:27]
  wire [3:0] _GEN_21 = _GEN_12 == _T_22 ? 4'h0 : _clkCntr2_T_1; // @[intervox_receiver.scala 137:22 138:45 139:29]
  wire [3:0] _GEN_23 = _T_5 ? _GEN_21 : clkCntr2; // @[intervox_receiver.scala 127:19 29:30]
  wire [3:0] _GEN_24 = change ? _clkCntr2_T_1 : _GEN_23; // @[intervox_receiver.scala 127:19 129:22]
  wire  _T_29 = clkCntr1 < lastOne; // @[intervox_receiver.scala 147:23]
  wire  _GEN_27 = clkCntr1 < lastOne ? 1'h0 : zeroPeriode; // @[intervox_receiver.scala 147:33 149:25 42:30]
  wire  _GEN_29 = whatChange[0] & ~whatChange[1] ? _GEN_27 : zeroPeriode; // @[intervox_receiver.scala 145:60 42:30]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 157:23]
  wire  _GEN_30 = ~whatChange[0] & whatChange[1] ? ~clkRec : clkRec; // @[intervox_receiver.scala 155:64 157:20 38:30]
  wire  _GEN_33 = _T_29 ? _GEN_30 : clkRec; // @[intervox_receiver.scala 154:29 38:30]
  wire [7:0] _T_38 = lastOne / 2'h2; // @[intervox_receiver.scala 170:60]
  wire [7:0] _T_40 = _T_38 + 8'h1; // @[intervox_receiver.scala 170:67]
  wire  _GEN_40 = clkCntr1 > lastOne | _GEN_29; // @[intervox_receiver.scala 166:31 174:21]
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 45:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 46:21]
  assign io_DBUG = zeroPeriode; // @[intervox_receiver.scala 47:21]
  assign io_DBUG1 = change; // @[intervox_receiver.scala 48:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 27:30]
      clkCntr <= 2'h0; // @[intervox_receiver.scala 27:30]
    end else if (clkCntr == 2'h1) begin // @[intervox_receiver.scala 59:26]
      clkCntr <= 2'h0; // @[intervox_receiver.scala 60:17]
    end else begin
      clkCntr <= _clkCntr_T_1; // @[intervox_receiver.scala 55:17]
    end
    if (reset) begin // @[intervox_receiver.scala 28:30]
      clkCntr1 <= 8'h0; // @[intervox_receiver.scala 28:30]
    end else if (~change) begin // @[intervox_receiver.scala 74:25]
      if (inBufr[0] != inBufr[1]) begin // @[intervox_receiver.scala 76:38]
        clkCntr1 <= 8'h0; // @[intervox_receiver.scala 78:22]
      end else begin
        clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 57:17]
      end
    end else begin
      clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 57:17]
    end
    if (reset) begin // @[intervox_receiver.scala 29:30]
      clkCntr2 <= 4'h0; // @[intervox_receiver.scala 29:30]
    end else if (whatChange[0] & ~whatChange[1]) begin // @[intervox_receiver.scala 145:60]
      if (clkCntr1 < lastOne) begin // @[intervox_receiver.scala 147:33]
        clkCntr2 <= 4'h0; // @[intervox_receiver.scala 148:25]
      end else begin
        clkCntr2 <= _GEN_24;
      end
    end else begin
      clkCntr2 <= _GEN_24;
    end
    if (reset) begin // @[intervox_receiver.scala 31:30]
      clkDelta <= 8'h0; // @[intervox_receiver.scala 31:30]
    end else if (~change) begin // @[intervox_receiver.scala 74:25]
      if (inBufr[0] != inBufr[1]) begin // @[intervox_receiver.scala 76:38]
        clkDelta <= clkCntr1; // @[intervox_receiver.scala 79:22]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 32:30]
      lastOne <= 8'h7; // @[intervox_receiver.scala 32:30]
    end else if (clkDelta > 8'h0 & clkDelta < 8'ha) begin // @[intervox_receiver.scala 99:47]
      lastOne <= clkDelta; // @[intervox_receiver.scala 106:17]
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      inBufr <= 2'h0; // @[intervox_receiver.scala 34:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 69:29]
      if (inBufr > 2'h0) begin // @[intervox_receiver.scala 70:27]
        inBufr <= _inBufr_T_3; // @[intervox_receiver.scala 71:20]
      end else begin
        inBufr <= _GEN_3;
      end
    end else begin
      inBufr <= _GEN_3;
    end
    if (reset) begin // @[intervox_receiver.scala 35:30]
      whatChange <= 2'h0; // @[intervox_receiver.scala 35:30]
    end else if (change) begin // @[intervox_receiver.scala 127:19]
      whatChange <= _whatChange_T_1;
    end else if (_T_5) begin // @[intervox_receiver.scala 127:19]
      whatChange <= _whatChange_T_3; // @[intervox_receiver.scala 135:24]
    end
    if (reset) begin // @[intervox_receiver.scala 38:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 38:30]
    end else if (clkCntr1 > lastOne) begin // @[intervox_receiver.scala 166:31]
      if (~zeroPeriode & _GEN_12 >= _T_40) begin // @[intervox_receiver.scala 170:74]
        clkRec <= _clkRec_T; // @[intervox_receiver.scala 171:20]
      end else begin
        clkRec <= _GEN_33;
      end
    end else begin
      clkRec <= _GEN_33;
    end
    if (reset) begin // @[intervox_receiver.scala 39:30]
      change <= 1'h0; // @[intervox_receiver.scala 39:30]
    end else if (~change) begin // @[intervox_receiver.scala 74:25]
      change <= _GEN_6;
    end else if (clkCntr == 2'h1) begin // @[intervox_receiver.scala 59:26]
      change <= 1'h0; // @[intervox_receiver.scala 61:16]
    end
    if (reset) begin // @[intervox_receiver.scala 40:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 40:30]
    end else if (clkDelta > 8'ha & clkDelta < 8'h10) begin // @[intervox_receiver.scala 116:48]
      dataOut <= 1'h0; // @[intervox_receiver.scala 117:17]
    end else begin
      dataOut <= _GEN_14;
    end
    if (reset) begin // @[intervox_receiver.scala 42:30]
      zeroPeriode <= 1'h0; // @[intervox_receiver.scala 42:30]
    end else begin
      zeroPeriode <= _GEN_40;
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
  clkCntr2 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  clkDelta = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  lastOne = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  inBufr = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  whatChange = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  clkRec = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  change = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  dataOut = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  zeroPeriode = _RAND_10[0:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 210:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 210:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 210:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 210:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 210:26]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 210:26]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 210:26]
  wire  pll_PLL_MCLK; // @[intervox_receiver.scala 219:21]
  wire  pll_locked; // @[intervox_receiver.scala 219:21]
  wire  pll_PLL_IN; // @[intervox_receiver.scala 219:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 210:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 219:21]
    .PLL_MCLK(pll_PLL_MCLK),
    .locked(pll_locked),
    .PLL_IN(pll_PLL_IN)
  );
  assign io_CLK_REC = pll_locked & pll_PLL_MCLK; // @[intervox_receiver.scala 225:32 226:20 229:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 213:25]
  assign io_NEXT_FRAME = clockRec_io_DBUG; // @[intervox_receiver.scala 214:25]
  assign io_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 216:25]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 215:25]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 212:25]
  assign pll_PLL_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 222:19]
endmodule
