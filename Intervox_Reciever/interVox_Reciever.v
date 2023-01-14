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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inBufr; // @[intervox_receiver.scala 83:30]
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 84:30]
  reg  clkRec; // @[intervox_receiver.scala 85:30]
  reg  change; // @[intervox_receiver.scala 86:30]
  reg  dataOut; // @[intervox_receiver.scala 87:30]
  reg  syncWord; // @[intervox_receiver.scala 88:30]
  reg  zeroFlipped; // @[intervox_receiver.scala 89:30]
  reg  syncFlipped; // @[intervox_receiver.scala 90:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 91:30]
  reg  syncFlipped2; // @[intervox_receiver.scala 92:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 100:31]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_receiver.scala 109:34]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_receiver.scala 115:34]
  wire  _GEN_4 = inBufr[0] ^ inBufr[1] | change; // @[intervox_receiver.scala 119:36 120:16 86:30]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 130:24]
  wire  _GEN_6 = change ? ~clkRec : clkRec; // @[intervox_receiver.scala 126:25 130:21 85:30]
  wire  _GEN_8 = change ? 1'h0 : zeroFlipped; // @[intervox_receiver.scala 126:25 134:21 89:30]
  wire  _GEN_9 = change ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 126:25 135:21 90:30]
  wire  _GEN_10 = change ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 126:25 136:21 91:30]
  wire  _GEN_11 = change ? 1'h0 : syncWord; // @[intervox_receiver.scala 126:25 137:18 88:30]
  wire  _GEN_12 = change | dataOut; // @[intervox_receiver.scala 146:29 149:21 87:30]
  wire [9:0] _T_15 = 8'hf * 2'h2; // @[intervox_receiver.scala 159:65]
  wire [9:0] _T_17 = _T_15 + 10'h2; // @[intervox_receiver.scala 159:72]
  wire [9:0] _GEN_37 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 159:53]
  wire  _GEN_14 = ~zeroFlipped ? _clkRec_T : _GEN_6; // @[intervox_receiver.scala 162:34 165:20]
  wire  _GEN_15 = ~zeroFlipped | _GEN_8; // @[intervox_receiver.scala 162:34 166:25]
  wire  _GEN_16 = deltaCntr > 8'h10 & _GEN_37 < _T_17 ? _GEN_14 : _GEN_6; // @[intervox_receiver.scala 159:80]
  wire  _T_21 = ~change; // @[intervox_receiver.scala 176:17]
  wire  _GEN_19 = ~syncFlipped ? _clkRec_T : _GEN_16; // @[intervox_receiver.scala 185:38 187:24]
  wire  _GEN_20 = ~syncFlipped | _GEN_9; // @[intervox_receiver.scala 185:38 188:29]
  wire  _GEN_21 = _GEN_37 == _T_17 ? _GEN_19 : _GEN_16; // @[intervox_receiver.scala 178:52]
  wire [9:0] _T_27 = 8'hf * 2'h3; // @[intervox_receiver.scala 191:38]
  wire  _GEN_23 = ~syncFlipped1 ? _clkRec_T : _GEN_21; // @[intervox_receiver.scala 200:39 202:24]
  wire  _GEN_24 = ~syncFlipped1 | _GEN_10; // @[intervox_receiver.scala 200:39 203:30]
  wire  _GEN_25 = _GEN_37 == _T_27 | _GEN_11; // @[intervox_receiver.scala 191:46 198:22]
  wire  _GEN_26 = _GEN_37 == _T_27 ? _GEN_23 : _GEN_21; // @[intervox_receiver.scala 191:46]
  wire [10:0] _T_30 = 8'hf * 3'h4; // @[intervox_receiver.scala 206:38]
  wire [10:0] _GEN_40 = {{3'd0}, deltaCntr}; // @[intervox_receiver.scala 206:25]
  wire  _GEN_29 = ~syncFlipped2 | syncFlipped2; // @[intervox_receiver.scala 213:39 216:30 92:30]
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 94:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 95:21]
  assign io_DBUG = change; // @[intervox_receiver.scala 96:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 97:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 83:30]
      inBufr <= 2'h0; // @[intervox_receiver.scala 83:30]
    end else if (io_DATA_IN) begin // @[intervox_receiver.scala 105:23]
      if (inBufr < 2'h3) begin // @[intervox_receiver.scala 107:31]
        inBufr <= _inBufr_T_1; // @[intervox_receiver.scala 109:24]
      end
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 105:23]
      if (inBufr > 2'h0) begin // @[intervox_receiver.scala 113:31]
        inBufr <= _inBufr_T_3; // @[intervox_receiver.scala 115:24]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 84:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 84:30]
    end else if (change) begin // @[intervox_receiver.scala 126:25]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 132:21]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 100:18]
    end
    if (reset) begin // @[intervox_receiver.scala 85:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 85:30]
    end else if (~change) begin // @[intervox_receiver.scala 176:25]
      if (_GEN_40 == _T_30 & _T_21) begin // @[intervox_receiver.scala 206:65]
        if (~syncFlipped2) begin // @[intervox_receiver.scala 213:39]
          clkRec <= _clkRec_T; // @[intervox_receiver.scala 215:24]
        end else begin
          clkRec <= _GEN_26;
        end
      end else begin
        clkRec <= _GEN_26;
      end
    end else if (deltaCntr > 8'h10 & _GEN_37 < _T_17) begin // @[intervox_receiver.scala 159:80]
      if (~zeroFlipped) begin // @[intervox_receiver.scala 162:34]
        clkRec <= _clkRec_T; // @[intervox_receiver.scala 165:20]
      end else begin
        clkRec <= _GEN_6;
      end
    end else begin
      clkRec <= _GEN_6;
    end
    if (reset) begin // @[intervox_receiver.scala 86:30]
      change <= 1'h0; // @[intervox_receiver.scala 86:30]
    end else if (change) begin // @[intervox_receiver.scala 126:25]
      change <= 1'h0; // @[intervox_receiver.scala 128:16]
    end else begin
      change <= _GEN_4;
    end
    if (reset) begin // @[intervox_receiver.scala 87:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 87:30]
    end else if (deltaCntr > 8'h10 & _GEN_37 < _T_17) begin // @[intervox_receiver.scala 159:80]
      dataOut <= 1'h0; // @[intervox_receiver.scala 169:17]
    end else if (deltaCntr <= 8'h10) begin // @[intervox_receiver.scala 143:41]
      dataOut <= _GEN_12;
    end
    if (reset) begin // @[intervox_receiver.scala 88:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 88:30]
    end else if (~change) begin // @[intervox_receiver.scala 176:25]
      syncWord <= _GEN_25;
    end else if (change) begin // @[intervox_receiver.scala 126:25]
      syncWord <= 1'h0; // @[intervox_receiver.scala 137:18]
    end
    if (reset) begin // @[intervox_receiver.scala 89:30]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 89:30]
    end else if (deltaCntr > 8'h10 & _GEN_37 < _T_17) begin // @[intervox_receiver.scala 159:80]
      zeroFlipped <= _GEN_15;
    end else if (change) begin // @[intervox_receiver.scala 126:25]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 134:21]
    end
    if (reset) begin // @[intervox_receiver.scala 90:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 90:30]
    end else if (~change) begin // @[intervox_receiver.scala 176:25]
      if (_GEN_37 == _T_17) begin // @[intervox_receiver.scala 178:52]
        syncFlipped <= _GEN_20;
      end else begin
        syncFlipped <= _GEN_9;
      end
    end else begin
      syncFlipped <= _GEN_9;
    end
    if (reset) begin // @[intervox_receiver.scala 91:30]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 91:30]
    end else if (~change) begin // @[intervox_receiver.scala 176:25]
      if (_GEN_37 == _T_27) begin // @[intervox_receiver.scala 191:46]
        syncFlipped1 <= _GEN_24;
      end else begin
        syncFlipped1 <= _GEN_10;
      end
    end else begin
      syncFlipped1 <= _GEN_10;
    end
    if (reset) begin // @[intervox_receiver.scala 92:30]
      syncFlipped2 <= 1'h0; // @[intervox_receiver.scala 92:30]
    end else if (~change) begin // @[intervox_receiver.scala 176:25]
      if (_GEN_40 == _T_30 & _T_21) begin // @[intervox_receiver.scala 206:65]
        syncFlipped2 <= _GEN_29;
      end
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
  inBufr = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  deltaCntr = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  clkRec = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  change = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dataOut = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  syncWord = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  zeroFlipped = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  syncFlipped = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  syncFlipped1 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  syncFlipped2 = _RAND_9[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module edgeDetector(
  input   clock,
  input   reset,
  input   io_INPUT,
  output  io_RISE
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inBufr; // @[intervox_receiver.scala 12:34]
  reg [1:0] inBufrPrev; // @[intervox_receiver.scala 13:34]
  reg  rising; // @[intervox_receiver.scala 15:34]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_receiver.scala 26:35]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_receiver.scala 33:35]
  wire  _T_8 = inBufr == 2'h1; // @[intervox_receiver.scala 43:41]
  wire  _GEN_10 = inBufrPrev == 2'h0 & inBufr == 2'h1 | rising; // @[intervox_receiver.scala 43:50 45:17 15:34]
  assign io_RISE = rising; // @[intervox_receiver.scala 64:13]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 12:34]
      inBufr <= 2'h0; // @[intervox_receiver.scala 12:34]
    end else if (io_INPUT) begin // @[intervox_receiver.scala 22:21]
      if (inBufr < 2'h2) begin // @[intervox_receiver.scala 24:27]
        inBufr <= _inBufr_T_1; // @[intervox_receiver.scala 26:25]
      end
    end else if (~io_INPUT) begin // @[intervox_receiver.scala 22:21]
      if (inBufr > 2'h0) begin // @[intervox_receiver.scala 31:27]
        inBufr <= _inBufr_T_3; // @[intervox_receiver.scala 33:25]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 13:34]
      inBufrPrev <= 2'h0; // @[intervox_receiver.scala 13:34]
    end else if (io_INPUT) begin // @[intervox_receiver.scala 22:21]
      if (inBufr < 2'h2) begin // @[intervox_receiver.scala 24:27]
        inBufrPrev <= inBufr; // @[intervox_receiver.scala 27:25]
      end
    end else if (~io_INPUT) begin // @[intervox_receiver.scala 22:21]
      if (inBufr > 2'h0) begin // @[intervox_receiver.scala 31:27]
        inBufrPrev <= inBufr; // @[intervox_receiver.scala 34:25]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 15:34]
      rising <= 1'h0; // @[intervox_receiver.scala 15:34]
    end else if (rising) begin // @[intervox_receiver.scala 56:27]
      rising <= 1'h0; // @[intervox_receiver.scala 56:37]
    end else if (inBufrPrev == 2'h2 & _T_8) begin // @[intervox_receiver.scala 49:50]
      rising <= 1'h0; // @[intervox_receiver.scala 51:17]
    end else begin
      rising <= _GEN_10;
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
  inBufr = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  inBufrPrev = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  rising = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module i2s_Transmitter(
  input   clock,
  input   reset,
  input   io_CLK_IN,
  input   io_DATA_IN,
  input   io_NEXT,
  output  io_BCLK,
  output  io_LRCLK,
  output  io_SDATA
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  BCLKEDGE_clock; // @[intervox_receiver.scala 243:37]
  wire  BCLKEDGE_reset; // @[intervox_receiver.scala 243:37]
  wire  BCLKEDGE_io_INPUT; // @[intervox_receiver.scala 243:37]
  wire  BCLKEDGE_io_RISE; // @[intervox_receiver.scala 243:37]
  reg  enable; // @[intervox_receiver.scala 232:26]
  reg [5:0] bitCntr; // @[intervox_receiver.scala 233:26]
  reg  lrclk; // @[intervox_receiver.scala 234:26]
  reg  sdata; // @[intervox_receiver.scala 236:26]
  wire  _GEN_0 = io_NEXT | enable; // @[intervox_receiver.scala 246:26 247:17 232:26]
  wire [5:0] _GEN_1 = io_NEXT ? 6'h0 : bitCntr; // @[intervox_receiver.scala 246:26 248:17 233:26]
  wire [5:0] _bitCntr_T_1 = bitCntr + 6'h1; // @[intervox_receiver.scala 255:32]
  wire  _GEN_2 = bitCntr == 6'h0 | lrclk; // @[intervox_receiver.scala 257:34 258:23 234:26]
  edgeDetector BCLKEDGE ( // @[intervox_receiver.scala 243:37]
    .clock(BCLKEDGE_clock),
    .reset(BCLKEDGE_reset),
    .io_INPUT(BCLKEDGE_io_INPUT),
    .io_RISE(BCLKEDGE_io_RISE)
  );
  assign io_BCLK = io_CLK_IN; // @[intervox_receiver.scala 241:17]
  assign io_LRCLK = lrclk; // @[intervox_receiver.scala 239:17]
  assign io_SDATA = sdata; // @[intervox_receiver.scala 240:17]
  assign BCLKEDGE_clock = clock;
  assign BCLKEDGE_reset = reset;
  assign BCLKEDGE_io_INPUT = io_BCLK; // @[intervox_receiver.scala 244:31]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 232:26]
      enable <= 1'h0; // @[intervox_receiver.scala 232:26]
    end else if (enable) begin // @[intervox_receiver.scala 251:25]
      if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 253:39]
        if (bitCntr == 6'h3f) begin // @[intervox_receiver.scala 265:35]
          enable <= 1'h0; // @[intervox_receiver.scala 266:24]
        end else begin
          enable <= _GEN_0;
        end
      end else begin
        enable <= _GEN_0;
      end
    end else begin
      enable <= _GEN_0;
    end
    if (reset) begin // @[intervox_receiver.scala 233:26]
      bitCntr <= 6'h0; // @[intervox_receiver.scala 233:26]
    end else if (enable) begin // @[intervox_receiver.scala 251:25]
      if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 253:39]
        if (bitCntr == 6'h3f) begin // @[intervox_receiver.scala 265:35]
          bitCntr <= 6'h0; // @[intervox_receiver.scala 267:25]
        end else begin
          bitCntr <= _bitCntr_T_1; // @[intervox_receiver.scala 255:21]
        end
      end else begin
        bitCntr <= _GEN_1;
      end
    end else begin
      bitCntr <= _GEN_1;
    end
    if (reset) begin // @[intervox_receiver.scala 234:26]
      lrclk <= 1'h0; // @[intervox_receiver.scala 234:26]
    end else if (enable) begin // @[intervox_receiver.scala 251:25]
      if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 253:39]
        if (bitCntr == 6'h1f) begin // @[intervox_receiver.scala 261:35]
          lrclk <= 1'h0; // @[intervox_receiver.scala 262:23]
        end else begin
          lrclk <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_receiver.scala 236:26]
      sdata <= 1'h0; // @[intervox_receiver.scala 236:26]
    end else if (enable) begin // @[intervox_receiver.scala 251:25]
      if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 253:39]
        sdata <= io_DATA_IN;
      end
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
  enable = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  bitCntr = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  lrclk = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sdata = _RAND_3[0:0];
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
  output [15:0] io_LEDS,
  output        io_BCLK,
  output        io_LRCLK,
  output        io_SDATA
);
  wire  clockRec_clock; // @[intervox_receiver.scala 294:29]
  wire  clockRec_reset; // @[intervox_receiver.scala 294:29]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 294:29]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 294:29]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 294:29]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 294:29]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 294:29]
  wire  i2sTrans_clock; // @[intervox_receiver.scala 303:29]
  wire  i2sTrans_reset; // @[intervox_receiver.scala 303:29]
  wire  i2sTrans_io_CLK_IN; // @[intervox_receiver.scala 303:29]
  wire  i2sTrans_io_DATA_IN; // @[intervox_receiver.scala 303:29]
  wire  i2sTrans_io_NEXT; // @[intervox_receiver.scala 303:29]
  wire  i2sTrans_io_BCLK; // @[intervox_receiver.scala 303:29]
  wire  i2sTrans_io_LRCLK; // @[intervox_receiver.scala 303:29]
  wire  i2sTrans_io_SDATA; // @[intervox_receiver.scala 303:29]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 294:29]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1)
  );
  i2s_Transmitter i2sTrans ( // @[intervox_receiver.scala 303:29]
    .clock(i2sTrans_clock),
    .reset(i2sTrans_reset),
    .io_CLK_IN(i2sTrans_io_CLK_IN),
    .io_DATA_IN(i2sTrans_io_DATA_IN),
    .io_NEXT(i2sTrans_io_NEXT),
    .io_BCLK(i2sTrans_io_BCLK),
    .io_LRCLK(i2sTrans_io_LRCLK),
    .io_SDATA(i2sTrans_io_SDATA)
  );
  assign io_CLK_REC = 1'h0; // @[intervox_receiver.scala 299:21]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 297:21]
  assign io_CLK_DBUG = 1'h0; // @[intervox_receiver.scala 298:21]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 301:21]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 300:21]
  assign io_LEDS = 16'hf; // @[intervox_receiver.scala 296:21]
  assign io_BCLK = i2sTrans_io_BCLK; // @[intervox_receiver.scala 307:21]
  assign io_LRCLK = i2sTrans_io_LRCLK; // @[intervox_receiver.scala 309:21]
  assign io_SDATA = i2sTrans_io_SDATA; // @[intervox_receiver.scala 308:21]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 295:29]
  assign i2sTrans_clock = clock;
  assign i2sTrans_reset = reset;
  assign i2sTrans_io_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 304:29]
  assign i2sTrans_io_DATA_IN = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 305:29]
  assign i2sTrans_io_NEXT = clockRec_io_DBUG1; // @[intervox_receiver.scala 306:29]
endmodule
