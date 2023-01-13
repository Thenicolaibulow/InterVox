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
  reg [1:0] edgeState; // @[intervox_receiver.scala 27:30]
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 28:30]
  reg [7:0] lastOne; // @[intervox_receiver.scala 29:30]
  reg  clkRec; // @[intervox_receiver.scala 30:30]
  reg  change; // @[intervox_receiver.scala 31:30]
  reg  changed; // @[intervox_receiver.scala 32:30]
  reg  dataOut; // @[intervox_receiver.scala 33:30]
  reg  zeroPeriode; // @[intervox_receiver.scala 34:30]
  reg  syncWord; // @[intervox_receiver.scala 35:30]
  reg  syncFlipped; // @[intervox_receiver.scala 36:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 37:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 46:31]
  wire [1:0] _GEN_3 = ~io_DATA_IN ? 2'h1 : edgeState; // @[intervox_receiver.scala 65:37 66:27 27:30]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 76:24]
  wire [7:0] _T_8 = lastOne + 8'h1; // @[intervox_receiver.scala 86:37]
  wire [7:0] _T_9 = _T_8 / 2'h2; // @[intervox_receiver.scala 86:43]
  wire [7:0] _T_12 = lastOne + 8'h2; // @[intervox_receiver.scala 86:74]
  wire  _GEN_9 = deltaCntr > _T_9 & deltaCntr < _T_12 | dataOut; // @[intervox_receiver.scala 86:83 91:25 33:30]
  wire  _GEN_10 = deltaCntr > _T_9 & deltaCntr < _T_12 ? 1'h0 : zeroPeriode; // @[intervox_receiver.scala 86:83 93:25 34:30]
  wire  _GEN_13 = change ? 1'h0 : changed; // @[intervox_receiver.scala 71:25 74:21 32:30]
  wire  _GEN_14 = change ? ~clkRec : clkRec; // @[intervox_receiver.scala 71:25 76:21 30:30]
  wire  _GEN_15 = change ? 1'h0 : syncWord; // @[intervox_receiver.scala 71:25 78:21 35:30]
  wire  _GEN_16 = change ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 71:25 79:21 36:30]
  wire  _GEN_17 = change ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 71:25 80:21 37:30]
  wire  _GEN_20 = change ? _GEN_10 : zeroPeriode; // @[intervox_receiver.scala 71:25 34:30]
  wire [9:0] _T_18 = lastOne * 2'h2; // @[intervox_receiver.scala 101:66]
  wire [9:0] _T_20 = _T_18 + 10'h2; // @[intervox_receiver.scala 101:74]
  wire [9:0] _GEN_35 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 101:54]
  wire  _GEN_23 = deltaCntr >= _T_12 & _GEN_35 < _T_20 | _GEN_20; // @[intervox_receiver.scala 101:81 108:25]
  wire  _GEN_24 = deltaCntr >= _T_12 & _GEN_35 < _T_20 ? 1'h0 : _GEN_15; // @[intervox_receiver.scala 101:81 110:25]
  wire  _GEN_25 = ~syncFlipped ? _clkRec_T : _GEN_14; // @[intervox_receiver.scala 117:34 119:21]
  wire  _GEN_26 = ~syncFlipped | _GEN_16; // @[intervox_receiver.scala 117:34 120:25]
  wire [9:0] _T_28 = lastOne * 2'h3; // @[intervox_receiver.scala 123:38]
  wire [9:0] _T_30 = _T_28 + 10'h1; // @[intervox_receiver.scala 123:45]
  wire  _GEN_28 = _GEN_35 >= _T_30 & ~syncFlipped1 | _GEN_17; // @[intervox_receiver.scala 123:78 126:26]
  wire  _GEN_29 = _GEN_35 >= _T_20 | _GEN_24; // @[intervox_receiver.scala 113:49 115:18]
  wire  _GEN_34 = deltaCntr > _T_8 & ~changed & ~change | deltaCntr > _T_8 & zeroPeriode & ~changed | _GEN_13; // @[intervox_receiver.scala 137:155 139:17]
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 39:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 40:21]
  assign io_DBUG = change; // @[intervox_receiver.scala 41:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 42:21]
  assign io_LEDS = {{8'd0}, lastOne}; // @[intervox_receiver.scala 43:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 27:30]
      edgeState <= 2'h0; // @[intervox_receiver.scala 27:30]
    end else if (2'h0 == edgeState) begin // @[intervox_receiver.scala 49:22]
      if (io_DATA_IN) begin // @[intervox_receiver.scala 51:37]
        edgeState <= 2'h1; // @[intervox_receiver.scala 52:27]
      end
    end else if (2'h1 == edgeState) begin // @[intervox_receiver.scala 49:22]
      if (io_DATA_IN) begin // @[intervox_receiver.scala 56:37]
        edgeState <= 2'h2; // @[intervox_receiver.scala 57:27]
      end else begin
        edgeState <= 2'h0; // @[intervox_receiver.scala 60:27]
      end
    end else if (2'h2 == edgeState) begin // @[intervox_receiver.scala 49:22]
      edgeState <= _GEN_3;
    end
    if (reset) begin // @[intervox_receiver.scala 28:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 28:30]
    end else if (change) begin // @[intervox_receiver.scala 71:25]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 82:21]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 46:18]
    end
    if (reset) begin // @[intervox_receiver.scala 29:30]
      lastOne <= 8'hf; // @[intervox_receiver.scala 29:30]
    end else if (change) begin // @[intervox_receiver.scala 71:25]
      if (deltaCntr > _T_9 & deltaCntr < _T_12) begin // @[intervox_receiver.scala 86:83]
        lastOne <= deltaCntr; // @[intervox_receiver.scala 95:25]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 30:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 30:30]
    end else if (deltaCntr > _T_8 & ~changed & ~change | deltaCntr > _T_8 & zeroPeriode & ~changed) begin // @[intervox_receiver.scala 137:155]
      clkRec <= _clkRec_T; // @[intervox_receiver.scala 138:17]
    end else if (_GEN_35 >= _T_20) begin // @[intervox_receiver.scala 113:49]
      if (_GEN_35 >= _T_30 & ~syncFlipped1) begin // @[intervox_receiver.scala 123:78]
        clkRec <= _clkRec_T; // @[intervox_receiver.scala 125:21]
      end else begin
        clkRec <= _GEN_25;
      end
    end else if (change) begin // @[intervox_receiver.scala 71:25]
      clkRec <= ~clkRec; // @[intervox_receiver.scala 76:21]
    end
    if (reset) begin // @[intervox_receiver.scala 31:30]
      change <= 1'h0; // @[intervox_receiver.scala 31:30]
    end else if (change) begin // @[intervox_receiver.scala 71:25]
      change <= 1'h0; // @[intervox_receiver.scala 72:16]
    end else if (!(2'h0 == edgeState)) begin // @[intervox_receiver.scala 49:22]
      change <= 2'h1 == edgeState | change;
    end
    if (reset) begin // @[intervox_receiver.scala 32:30]
      changed <= 1'h0; // @[intervox_receiver.scala 32:30]
    end else begin
      changed <= _GEN_34;
    end
    if (reset) begin // @[intervox_receiver.scala 33:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 33:30]
    end else if (deltaCntr >= _T_12 & _GEN_35 < _T_20) begin // @[intervox_receiver.scala 101:81]
      dataOut <= 1'h0; // @[intervox_receiver.scala 106:25]
    end else if (change) begin // @[intervox_receiver.scala 71:25]
      dataOut <= _GEN_9;
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      zeroPeriode <= 1'h0; // @[intervox_receiver.scala 34:30]
    end else begin
      zeroPeriode <= _GEN_23;
    end
    if (reset) begin // @[intervox_receiver.scala 35:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 35:30]
    end else begin
      syncWord <= _GEN_29;
    end
    if (reset) begin // @[intervox_receiver.scala 36:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 36:30]
    end else if (_GEN_35 >= _T_20) begin // @[intervox_receiver.scala 113:49]
      syncFlipped <= _GEN_26;
    end else if (change) begin // @[intervox_receiver.scala 71:25]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 79:21]
    end
    if (reset) begin // @[intervox_receiver.scala 37:30]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 37:30]
    end else if (_GEN_35 >= _T_20) begin // @[intervox_receiver.scala 113:49]
      syncFlipped1 <= _GEN_28;
    end else if (change) begin // @[intervox_receiver.scala 71:25]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 80:21]
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
  edgeState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  deltaCntr = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  lastOne = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  clkRec = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  change = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  changed = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  dataOut = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  zeroPeriode = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  syncWord = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  syncFlipped = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  syncFlipped1 = _RAND_10[0:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 156:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 156:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 156:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 156:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 156:26]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 156:26]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 156:26]
  wire [15:0] clockRec_io_LEDS; // @[intervox_receiver.scala 156:26]
  wire  pll_CLK_OUT; // @[intervox_receiver.scala 172:21]
  wire  pll_locked; // @[intervox_receiver.scala 172:21]
  wire  pll_CLK_IN; // @[intervox_receiver.scala 172:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 156:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1),
    .io_LEDS(clockRec_io_LEDS)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 172:21]
    .CLK_OUT(pll_CLK_OUT),
    .locked(pll_locked),
    .CLK_IN(pll_CLK_IN)
  );
  assign io_CLK_REC = pll_locked & pll_CLK_OUT; // @[intervox_receiver.scala 178:32 179:20 182:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 161:25]
  assign io_CLK_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 162:25]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 164:25]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 163:25]
  assign io_LEDS = clockRec_io_LEDS; // @[intervox_receiver.scala 160:25]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 158:25]
  assign pll_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 175:19]
endmodule
