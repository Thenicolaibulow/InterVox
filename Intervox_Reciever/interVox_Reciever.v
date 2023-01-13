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
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 25:30]
  reg [1:0] inBufr; // @[intervox_receiver.scala 26:30]
  reg [7:0] lastOne; // @[intervox_receiver.scala 27:30]
  reg [1:0] inBufrPrev; // @[intervox_receiver.scala 28:30]
  reg  clkRec; // @[intervox_receiver.scala 30:30]
  reg  change; // @[intervox_receiver.scala 31:30]
  reg  changed; // @[intervox_receiver.scala 32:30]
  reg  dataOut; // @[intervox_receiver.scala 33:30]
  reg  zeroPeriode; // @[intervox_receiver.scala 34:30]
  reg  syncWord; // @[intervox_receiver.scala 35:30]
  reg  syncFlipped; // @[intervox_receiver.scala 36:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 37:31]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 46:31]
  wire  _T_1 = inBufr == 2'h0; // @[intervox_receiver.scala 52:21]
  wire [1:0] _GEN_0 = inBufr == 2'h0 ? 2'h1 : inBufr; // @[intervox_receiver.scala 52:29 53:20 26:30]
  wire  _T_3 = inBufr > 2'h0; // @[intervox_receiver.scala 56:39]
  wire [2:0] _inBufr_T = {inBufr, 1'h0}; // @[intervox_receiver.scala 59:30]
  wire [1:0] _GEN_1 = inBufr < 2'h2 & inBufr > 2'h0 ? inBufr : inBufrPrev; // @[intervox_receiver.scala 56:46 58:24 28:30]
  wire [2:0] _GEN_2 = inBufr < 2'h2 & inBufr > 2'h0 ? _inBufr_T : {{1'd0}, _GEN_0}; // @[intervox_receiver.scala 56:46 59:20]
  wire [1:0] _GEN_3 = inBufr == 2'h2 ? inBufr : _GEN_1; // @[intervox_receiver.scala 61:29 63:24]
  wire [2:0] _GEN_4 = io_DATA_IN ? _GEN_2 : {{1'd0}, inBufr}; // @[intervox_receiver.scala 49:29 26:30]
  wire [1:0] _GEN_5 = io_DATA_IN ? _GEN_3 : inBufrPrev; // @[intervox_receiver.scala 49:29 28:30]
  wire [1:0] _inBufr_T_1 = {{1'd0}, inBufr[1]}; // @[intervox_receiver.scala 74:30]
  wire [2:0] _GEN_7 = _T_3 ? {{1'd0}, _inBufr_T_1} : _GEN_4; // @[intervox_receiver.scala 70:27 74:20]
  wire [2:0] _GEN_10 = ~io_DATA_IN ? _GEN_7 : _GEN_4; // @[intervox_receiver.scala 67:29]
  wire  _change_T = ~change; // @[intervox_receiver.scala 93:24]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 97:24]
  wire [7:0] _T_17 = lastOne + 8'h1; // @[intervox_receiver.scala 107:37]
  wire [7:0] _T_18 = _T_17 / 2'h2; // @[intervox_receiver.scala 107:43]
  wire [7:0] _T_21 = lastOne + 8'h2; // @[intervox_receiver.scala 107:74]
  wire  _GEN_11 = deltaCntr > _T_18 & deltaCntr < _T_21 | dataOut; // @[intervox_receiver.scala 107:83 112:25 33:30]
  wire  _GEN_12 = deltaCntr > _T_18 & deltaCntr < _T_21 ? 1'h0 : zeroPeriode; // @[intervox_receiver.scala 107:83 114:25 34:30]
  wire  _GEN_15 = inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1 ? 1'h0 : changed; // @[intervox_receiver.scala 91:96 95:21 32:30]
  wire  _GEN_16 = inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1 ? ~clkRec : clkRec; // @[intervox_receiver.scala 91:96 97:21 30:30]
  wire  _GEN_17 = inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1 ? 1'h0 : syncWord; // @[intervox_receiver.scala 91:96 99:21 35:30]
  wire  _GEN_18 = inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1 ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 100:21 36:30 91:96]
  wire  _GEN_19 = inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1 ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 101:21 37:31 91:96]
  wire  _GEN_22 = inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1 ? _GEN_12 : zeroPeriode; // @[intervox_receiver.scala 34:30 91:96]
  wire [9:0] _T_27 = lastOne * 2'h2; // @[intervox_receiver.scala 122:66]
  wire [9:0] _T_29 = _T_27 + 10'h2; // @[intervox_receiver.scala 122:74]
  wire [9:0] _GEN_38 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 122:54]
  wire  _GEN_25 = deltaCntr >= _T_21 & _GEN_38 < _T_29 | _GEN_22; // @[intervox_receiver.scala 122:81 129:25]
  wire  _GEN_26 = deltaCntr >= _T_21 & _GEN_38 < _T_29 ? 1'h0 : _GEN_17; // @[intervox_receiver.scala 122:81 131:25]
  wire  _GEN_27 = ~syncFlipped ? _clkRec_T : _GEN_16; // @[intervox_receiver.scala 138:34 140:21]
  wire  _GEN_28 = ~syncFlipped | _GEN_18; // @[intervox_receiver.scala 138:34 141:25]
  wire [9:0] _T_37 = lastOne * 2'h3; // @[intervox_receiver.scala 144:38]
  wire [9:0] _T_39 = _T_37 + 10'h1; // @[intervox_receiver.scala 144:45]
  wire  _GEN_30 = _GEN_38 >= _T_39 & ~syncFlipped1 | _GEN_19; // @[intervox_receiver.scala 144:78 147:26]
  wire  _GEN_31 = _GEN_38 >= _T_29 | _GEN_26; // @[intervox_receiver.scala 134:49 136:18]
  wire  _GEN_36 = deltaCntr > _T_17 & ~changed & _change_T | deltaCntr > _T_17 & zeroPeriode & ~changed | _GEN_15; // @[intervox_receiver.scala 168:155 170:17]
  wire [2:0] _GEN_41 = reset ? 3'h0 : _GEN_10; // @[intervox_receiver.scala 26:{30,30}]
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 39:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 40:21]
  assign io_DBUG = change; // @[intervox_receiver.scala 41:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 42:21]
  assign io_LEDS = {{8'd0}, lastOne}; // @[intervox_receiver.scala 43:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 25:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 25:30]
    end else if (inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1) begin // @[intervox_receiver.scala 91:96]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 103:21]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 46:18]
    end
    inBufr <= _GEN_41[1:0]; // @[intervox_receiver.scala 26:{30,30}]
    if (reset) begin // @[intervox_receiver.scala 27:30]
      lastOne <= 8'hf; // @[intervox_receiver.scala 27:30]
    end else if (inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1) begin // @[intervox_receiver.scala 91:96]
      if (deltaCntr > _T_18 & deltaCntr < _T_21) begin // @[intervox_receiver.scala 107:83]
        lastOne <= deltaCntr; // @[intervox_receiver.scala 116:25]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 28:30]
      inBufrPrev <= 2'h0; // @[intervox_receiver.scala 28:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 67:29]
      if (_T_1) begin // @[intervox_receiver.scala 76:29]
        inBufrPrev <= inBufr; // @[intervox_receiver.scala 78:24]
      end else if (_T_3) begin // @[intervox_receiver.scala 70:27]
        inBufrPrev <= inBufr; // @[intervox_receiver.scala 72:24]
      end else begin
        inBufrPrev <= _GEN_5;
      end
    end else begin
      inBufrPrev <= _GEN_5;
    end
    if (reset) begin // @[intervox_receiver.scala 30:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 30:30]
    end else if (deltaCntr > _T_17 & ~changed & _change_T | deltaCntr > _T_17 & zeroPeriode & ~changed) begin // @[intervox_receiver.scala 168:155]
      clkRec <= _clkRec_T; // @[intervox_receiver.scala 169:17]
    end else if (_GEN_38 >= _T_29) begin // @[intervox_receiver.scala 134:49]
      if (_GEN_38 >= _T_39 & ~syncFlipped1) begin // @[intervox_receiver.scala 144:78]
        clkRec <= _clkRec_T; // @[intervox_receiver.scala 146:21]
      end else begin
        clkRec <= _GEN_27;
      end
    end else if (inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1) begin // @[intervox_receiver.scala 91:96]
      clkRec <= ~clkRec; // @[intervox_receiver.scala 97:21]
    end
    if (reset) begin // @[intervox_receiver.scala 31:30]
      change <= 1'h0; // @[intervox_receiver.scala 31:30]
    end else if (inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1) begin // @[intervox_receiver.scala 91:96]
      change <= ~change; // @[intervox_receiver.scala 93:21]
    end
    if (reset) begin // @[intervox_receiver.scala 32:30]
      changed <= 1'h0; // @[intervox_receiver.scala 32:30]
    end else begin
      changed <= _GEN_36;
    end
    if (reset) begin // @[intervox_receiver.scala 33:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 33:30]
    end else if (deltaCntr >= _T_21 & _GEN_38 < _T_29) begin // @[intervox_receiver.scala 122:81]
      dataOut <= 1'h0; // @[intervox_receiver.scala 127:25]
    end else if (inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1) begin // @[intervox_receiver.scala 91:96]
      dataOut <= _GEN_11;
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      zeroPeriode <= 1'h0; // @[intervox_receiver.scala 34:30]
    end else begin
      zeroPeriode <= _GEN_25;
    end
    if (reset) begin // @[intervox_receiver.scala 35:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 35:30]
    end else begin
      syncWord <= _GEN_31;
    end
    if (reset) begin // @[intervox_receiver.scala 36:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 36:30]
    end else if (_GEN_38 >= _T_29) begin // @[intervox_receiver.scala 134:49]
      syncFlipped <= _GEN_28;
    end else if (inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1) begin // @[intervox_receiver.scala 91:96]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 100:21]
    end
    if (reset) begin // @[intervox_receiver.scala 37:31]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 37:31]
    end else if (_GEN_38 >= _T_29) begin // @[intervox_receiver.scala 134:49]
      syncFlipped1 <= _GEN_30;
    end else if (inBufrPrev == 2'h0 & inBufr == 2'h1 | inBufrPrev == 2'h2 & inBufr == 2'h1) begin // @[intervox_receiver.scala 91:96]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 101:21]
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
  dataOut = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  zeroPeriode = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  syncWord = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  syncFlipped = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  syncFlipped1 = _RAND_11[0:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 187:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 187:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 187:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 187:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 187:26]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 187:26]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 187:26]
  wire [15:0] clockRec_io_LEDS; // @[intervox_receiver.scala 187:26]
  wire  pll_CLK_OUT; // @[intervox_receiver.scala 203:21]
  wire  pll_locked; // @[intervox_receiver.scala 203:21]
  wire  pll_CLK_IN; // @[intervox_receiver.scala 203:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 187:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1),
    .io_LEDS(clockRec_io_LEDS)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 203:21]
    .CLK_OUT(pll_CLK_OUT),
    .locked(pll_locked),
    .CLK_IN(pll_CLK_IN)
  );
  assign io_CLK_REC = pll_locked & pll_CLK_OUT; // @[intervox_receiver.scala 209:32 210:20 213:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 192:25]
  assign io_CLK_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 193:25]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 195:25]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 194:25]
  assign io_LEDS = clockRec_io_LEDS; // @[intervox_receiver.scala 191:25]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 189:25]
  assign pll_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 206:19]
endmodule
