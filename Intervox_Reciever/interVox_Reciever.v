module clock_Recovery(
  input         clock,
  input         reset,
  input         io_DATA_IN,
  output        io_CLK_OUT,
  output        io_DATA_OUT,
  output        io_DBUG,
  output        io_DBUG1,
  output [15:0] io_LEDS
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
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 25:30]
  reg [1:0] inBufr; // @[intervox_receiver.scala 26:30]
  reg [7:0] lastOne; // @[intervox_receiver.scala 27:30]
  reg [1:0] inBufrPrev; // @[intervox_receiver.scala 28:30]
  reg  clkRec; // @[intervox_receiver.scala 32:30]
  reg  change; // @[intervox_receiver.scala 33:30]
  reg  changed; // @[intervox_receiver.scala 34:30]
  reg  changedOne; // @[intervox_receiver.scala 35:30]
  reg  dataOut; // @[intervox_receiver.scala 36:30]
  reg  zeroPeriode; // @[intervox_receiver.scala 37:30]
  reg  syncWord; // @[intervox_receiver.scala 38:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 48:31]
  wire  _T_1 = inBufr == 2'h0; // @[intervox_receiver.scala 54:21]
  wire [1:0] _GEN_0 = inBufr == 2'h0 ? 2'h1 : inBufr; // @[intervox_receiver.scala 54:29 55:20 26:30]
  wire  _T_3 = inBufr > 2'h0; // @[intervox_receiver.scala 58:39]
  wire [2:0] _inBufr_T = {inBufr, 1'h0}; // @[intervox_receiver.scala 61:30]
  wire [1:0] _GEN_1 = inBufr < 2'h2 & inBufr > 2'h0 ? inBufr : inBufrPrev; // @[intervox_receiver.scala 58:46 60:24 28:30]
  wire [2:0] _GEN_2 = inBufr < 2'h2 & inBufr > 2'h0 ? _inBufr_T : {{1'd0}, _GEN_0}; // @[intervox_receiver.scala 58:46 61:20]
  wire [1:0] _GEN_3 = inBufr == 2'h2 ? inBufr : _GEN_1; // @[intervox_receiver.scala 63:29 65:24]
  wire [2:0] _GEN_4 = io_DATA_IN ? _GEN_2 : {{1'd0}, inBufr}; // @[intervox_receiver.scala 51:29 26:30]
  wire [1:0] _GEN_5 = io_DATA_IN ? _GEN_3 : inBufrPrev; // @[intervox_receiver.scala 51:29 28:30]
  wire [1:0] _inBufr_T_1 = {{1'd0}, inBufr[1]}; // @[intervox_receiver.scala 76:30]
  wire [2:0] _GEN_7 = _T_3 ? {{1'd0}, _inBufr_T_1} : _GEN_4; // @[intervox_receiver.scala 72:27 76:20]
  wire [2:0] _GEN_10 = ~io_DATA_IN ? _GEN_7 : _GEN_4; // @[intervox_receiver.scala 69:29]
  wire  _T_10 = inBufr == 2'h1; // @[intervox_receiver.scala 92:41]
  wire  _GEN_11 = inBufrPrev == 2'h0 & inBufr == 2'h1 | change; // @[intervox_receiver.scala 92:50 94:21 33:30]
  wire  _GEN_12 = inBufrPrev == 2'h2 & _T_10 | _GEN_11; // @[intervox_receiver.scala 102:50 104:21]
  wire  _GEN_14 = change ? 1'h0 : changed; // @[intervox_receiver.scala 109:25 111:21 34:30]
  wire  _GEN_15 = ~changedOne | changedOne; // @[intervox_receiver.scala 117:33 119:25 35:30]
  wire  _GEN_17 = ~changedOne ? 1'h0 : syncWord; // @[intervox_receiver.scala 117:33 123:25 38:30]
  wire  _GEN_18 = deltaCntr <= lastOne | dataOut; // @[intervox_receiver.scala 127:37 132:25 36:30]
  wire  _GEN_19 = deltaCntr <= lastOne ? 1'h0 : zeroPeriode; // @[intervox_receiver.scala 127:37 134:25 37:30]
  wire  _GEN_25 = change ? _GEN_17 : syncWord; // @[intervox_receiver.scala 114:25 38:30]
  wire  _GEN_27 = change ? _GEN_19 : zeroPeriode; // @[intervox_receiver.scala 114:25 37:30]
  wire  _GEN_30 = deltaCntr > lastOne | _GEN_27; // @[intervox_receiver.scala 145:34 152:25]
  wire  _GEN_31 = deltaCntr > lastOne ? 1'h0 : _GEN_25; // @[intervox_receiver.scala 145:34 154:25]
  wire [9:0] _T_20 = lastOne * 2'h2; // @[intervox_receiver.scala 159:32]
  wire [9:0] _GEN_38 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 159:21]
  wire  _GEN_33 = _GEN_38 > _T_20 | _GEN_31; // @[intervox_receiver.scala 159:40 161:18]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 173:20]
  wire  _GEN_36 = deltaCntr >= lastOne & ~changed & ~change | deltaCntr >= lastOne & zeroPeriode & ~changed | _GEN_14; // @[intervox_receiver.scala 179:145 181:17]
  wire [2:0] _GEN_39 = reset ? 3'h0 : _GEN_10; // @[intervox_receiver.scala 26:{30,30}]
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 41:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 42:21]
  assign io_DBUG = zeroPeriode; // @[intervox_receiver.scala 43:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 44:21]
  assign io_LEDS = {{8'd0}, lastOne}; // @[intervox_receiver.scala 45:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 25:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 25:30]
    end else if (change) begin // @[intervox_receiver.scala 114:25]
      if (deltaCntr <= lastOne) begin // @[intervox_receiver.scala 127:37]
        deltaCntr <= 8'h0; // @[intervox_receiver.scala 140:25]
      end else if (~changedOne) begin // @[intervox_receiver.scala 117:33]
        deltaCntr <= 8'h0; // @[intervox_receiver.scala 121:25]
      end else begin
        deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 48:18]
      end
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 48:18]
    end
    inBufr <= _GEN_39[1:0]; // @[intervox_receiver.scala 26:{30,30}]
    if (reset) begin // @[intervox_receiver.scala 27:30]
      lastOne <= 8'h9; // @[intervox_receiver.scala 27:30]
    end else if (change) begin // @[intervox_receiver.scala 114:25]
      if (deltaCntr <= lastOne) begin // @[intervox_receiver.scala 127:37]
        lastOne <= deltaCntr; // @[intervox_receiver.scala 136:25]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 28:30]
      inBufrPrev <= 2'h0; // @[intervox_receiver.scala 28:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 69:29]
      if (_T_1) begin // @[intervox_receiver.scala 78:29]
        inBufrPrev <= inBufr; // @[intervox_receiver.scala 80:24]
      end else if (_T_3) begin // @[intervox_receiver.scala 72:27]
        inBufrPrev <= inBufr; // @[intervox_receiver.scala 74:24]
      end else begin
        inBufrPrev <= _GEN_5;
      end
    end else begin
      inBufrPrev <= _GEN_5;
    end
    if (reset) begin // @[intervox_receiver.scala 32:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 32:30]
    end else if (deltaCntr >= lastOne & ~changed & ~change | deltaCntr >= lastOne & zeroPeriode & ~changed) begin // @[intervox_receiver.scala 179:145]
      clkRec <= _clkRec_T; // @[intervox_receiver.scala 180:17]
    end else if (change) begin // @[intervox_receiver.scala 172:27]
      clkRec <= ~clkRec; // @[intervox_receiver.scala 173:17]
    end
    if (reset) begin // @[intervox_receiver.scala 33:30]
      change <= 1'h0; // @[intervox_receiver.scala 33:30]
    end else if (change) begin // @[intervox_receiver.scala 109:25]
      change <= 1'h0; // @[intervox_receiver.scala 110:21]
    end else begin
      change <= _GEN_12;
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      changed <= 1'h0; // @[intervox_receiver.scala 34:30]
    end else begin
      changed <= _GEN_36;
    end
    if (reset) begin // @[intervox_receiver.scala 35:30]
      changedOne <= 1'h0; // @[intervox_receiver.scala 35:30]
    end else if (deltaCntr > lastOne) begin // @[intervox_receiver.scala 145:34]
      changedOne <= 1'h0; // @[intervox_receiver.scala 156:25]
    end else if (change) begin // @[intervox_receiver.scala 114:25]
      if (deltaCntr <= lastOne) begin // @[intervox_receiver.scala 127:37]
        changedOne <= 1'h0; // @[intervox_receiver.scala 138:25]
      end else begin
        changedOne <= _GEN_15;
      end
    end
    if (reset) begin // @[intervox_receiver.scala 36:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 36:30]
    end else if (deltaCntr > lastOne) begin // @[intervox_receiver.scala 145:34]
      dataOut <= 1'h0; // @[intervox_receiver.scala 150:25]
    end else if (change) begin // @[intervox_receiver.scala 114:25]
      dataOut <= _GEN_18;
    end
    if (reset) begin // @[intervox_receiver.scala 37:30]
      zeroPeriode <= 1'h0; // @[intervox_receiver.scala 37:30]
    end else begin
      zeroPeriode <= _GEN_30;
    end
    if (reset) begin // @[intervox_receiver.scala 38:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 38:30]
    end else begin
      syncWord <= _GEN_33;
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
  deltaCntr = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  inBufr = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  lastOne = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  inBufrPrev = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  clkRec = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  change = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  changed = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  changedOne = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  dataOut = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  zeroPeriode = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  syncWord = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module interVox_Reciever(
  input         clock,
  input         reset,
  input         io_INTERVOX_IN,
  output        io_CLK_REC,
  output        io_DATA_OUT,
  output        io_CLK_DBUG,
  output        io_DBUG,
  output        io_DBUG1,
  output [15:0] io_LEDS
);
  wire  clockRec_clock; // @[intervox_receiver.scala 198:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 198:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 198:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 198:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 198:26]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 198:26]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 198:26]
  wire [15:0] clockRec_io_LEDS; // @[intervox_receiver.scala 198:26]
  wire  pll_PLL_MCLK; // @[intervox_receiver.scala 209:21]
  wire  pll_locked; // @[intervox_receiver.scala 209:21]
  wire  pll_PLL_IN; // @[intervox_receiver.scala 209:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 198:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1),
    .io_LEDS(clockRec_io_LEDS)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 209:21]
    .PLL_MCLK(pll_PLL_MCLK),
    .locked(pll_locked),
    .PLL_IN(pll_PLL_IN)
  );
  assign io_CLK_REC = pll_locked & pll_PLL_MCLK; // @[intervox_receiver.scala 215:32 216:20 219:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 203:25]
  assign io_CLK_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 204:25]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 206:25]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 205:25]
  assign io_LEDS = clockRec_io_LEDS; // @[intervox_receiver.scala 202:25]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 200:25]
  assign pll_PLL_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 212:19]
endmodule
