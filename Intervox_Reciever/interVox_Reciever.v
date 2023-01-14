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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inBufr; // @[intervox_receiver.scala 31:30]
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 32:30]
  reg  clkRec; // @[intervox_receiver.scala 33:30]
  reg  change; // @[intervox_receiver.scala 34:30]
  reg  dataOut; // @[intervox_receiver.scala 35:30]
  reg  syncWord; // @[intervox_receiver.scala 36:30]
  reg  zeroFlipped; // @[intervox_receiver.scala 37:30]
  reg  syncFlipped; // @[intervox_receiver.scala 38:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 39:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 49:31]
  wire [1:0] _inBufr_T_1 = inBufr - 2'h1; // @[intervox_receiver.scala 56:34]
  wire [1:0] _inBufr_T_3 = inBufr + 2'h1; // @[intervox_receiver.scala 61:34]
  wire  _GEN_4 = inBufr[0] ^ inBufr[1] | change; // @[intervox_receiver.scala 65:36 66:16 34:30]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 72:24]
  wire  _GEN_6 = change ? ~clkRec : clkRec; // @[intervox_receiver.scala 70:25 72:21 33:30]
  wire  _GEN_8 = change ? 1'h0 : zeroFlipped; // @[intervox_receiver.scala 70:25 74:21 37:30]
  wire  _GEN_9 = change ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 70:25 75:21 38:30]
  wire  _GEN_10 = change ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 70:25 76:21 39:30]
  wire  _GEN_11 = change | dataOut; // @[intervox_receiver.scala 82:29 83:21 35:30]
  wire  _GEN_12 = deltaCntr <= 8'h11 ? 1'h0 : syncWord; // @[intervox_receiver.scala 80:41 81:18 36:30]
  wire [9:0] _T_15 = 8'hf * 2'h2; // @[intervox_receiver.scala 88:64]
  wire [9:0] _GEN_32 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 88:53]
  wire  _GEN_14 = ~zeroFlipped ? _clkRec_T : _GEN_6; // @[intervox_receiver.scala 89:34 91:20]
  wire  _GEN_15 = ~zeroFlipped | _GEN_8; // @[intervox_receiver.scala 89:34 92:25]
  wire  _GEN_16 = deltaCntr > 8'h11 & _GEN_32 < _T_15 ? _GEN_14 : _GEN_6; // @[intervox_receiver.scala 88:72]
  wire [9:0] _T_22 = _T_15 + 10'h2; // @[intervox_receiver.scala 102:44]
  wire [9:0] _T_24 = 8'hf * 2'h3; // @[intervox_receiver.scala 102:77]
  wire [9:0] _T_26 = _T_24 - 10'h2; // @[intervox_receiver.scala 102:84]
  wire  _GEN_19 = ~syncFlipped ? _clkRec_T : _GEN_16; // @[intervox_receiver.scala 103:38 105:24]
  wire  _GEN_20 = ~syncFlipped | _GEN_9; // @[intervox_receiver.scala 103:38 106:29]
  wire  _GEN_21 = _GEN_32 > _T_22 & _GEN_32 < _T_26 ? _GEN_19 : _GEN_16; // @[intervox_receiver.scala 102:92]
  wire  _GEN_24 = ~syncFlipped1 | _GEN_10; // @[intervox_receiver.scala 111:39 114:30]
  wire  _GEN_25 = _GEN_32 > _T_24 | _GEN_12; // @[intervox_receiver.scala 109:42 110:22]
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 43:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 44:21]
  assign io_DBUG = change; // @[intervox_receiver.scala 45:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 46:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 31:30]
      inBufr <= 2'h0; // @[intervox_receiver.scala 31:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 53:23]
      if (inBufr > 2'h0) begin // @[intervox_receiver.scala 55:31]
        inBufr <= _inBufr_T_1; // @[intervox_receiver.scala 56:24]
      end
    end else if (io_DATA_IN) begin // @[intervox_receiver.scala 53:23]
      if (inBufr < 2'h3) begin // @[intervox_receiver.scala 60:31]
        inBufr <= _inBufr_T_3; // @[intervox_receiver.scala 61:24]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 32:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 32:30]
    end else if (change) begin // @[intervox_receiver.scala 70:25]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 73:21]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 49:18]
    end
    if (reset) begin // @[intervox_receiver.scala 33:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 33:30]
    end else if (~change) begin // @[intervox_receiver.scala 100:25]
      if (_GEN_32 > _T_24) begin // @[intervox_receiver.scala 109:42]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 111:39]
          clkRec <= _clkRec_T; // @[intervox_receiver.scala 113:24]
        end else begin
          clkRec <= _GEN_21;
        end
      end else begin
        clkRec <= _GEN_21;
      end
    end else begin
      clkRec <= _GEN_16;
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      change <= 1'h0; // @[intervox_receiver.scala 34:30]
    end else if (change) begin // @[intervox_receiver.scala 70:25]
      change <= 1'h0; // @[intervox_receiver.scala 71:16]
    end else begin
      change <= _GEN_4;
    end
    if (reset) begin // @[intervox_receiver.scala 35:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 35:30]
    end else if (deltaCntr > 8'h11 & _GEN_32 < _T_15) begin // @[intervox_receiver.scala 88:72]
      dataOut <= 1'h0; // @[intervox_receiver.scala 94:17]
    end else if (deltaCntr <= 8'h11) begin // @[intervox_receiver.scala 80:41]
      dataOut <= _GEN_11;
    end
    if (reset) begin // @[intervox_receiver.scala 36:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 36:30]
    end else if (~change) begin // @[intervox_receiver.scala 100:25]
      syncWord <= _GEN_25;
    end else if (deltaCntr <= 8'h11) begin // @[intervox_receiver.scala 80:41]
      syncWord <= 1'h0; // @[intervox_receiver.scala 81:18]
    end
    if (reset) begin // @[intervox_receiver.scala 37:30]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 37:30]
    end else if (deltaCntr > 8'h11 & _GEN_32 < _T_15) begin // @[intervox_receiver.scala 88:72]
      zeroFlipped <= _GEN_15;
    end else if (change) begin // @[intervox_receiver.scala 70:25]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 74:21]
    end
    if (reset) begin // @[intervox_receiver.scala 38:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 38:30]
    end else if (~change) begin // @[intervox_receiver.scala 100:25]
      if (_GEN_32 > _T_22 & _GEN_32 < _T_26) begin // @[intervox_receiver.scala 102:92]
        syncFlipped <= _GEN_20;
      end else begin
        syncFlipped <= _GEN_9;
      end
    end else begin
      syncFlipped <= _GEN_9;
    end
    if (reset) begin // @[intervox_receiver.scala 39:30]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 39:30]
    end else if (~change) begin // @[intervox_receiver.scala 100:25]
      if (_GEN_32 > _T_24) begin // @[intervox_receiver.scala 109:42]
        syncFlipped1 <= _GEN_24;
      end else begin
        syncFlipped1 <= _GEN_10;
      end
    end else begin
      syncFlipped1 <= _GEN_10;
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
  wire  clockRec_clock; // @[intervox_receiver.scala 132:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 132:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 132:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 132:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 132:26]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 132:26]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 132:26]
  wire  pll_CLK_OUT; // @[intervox_receiver.scala 145:21]
  wire  pll_locked; // @[intervox_receiver.scala 145:21]
  wire  pll_CLK_IN; // @[intervox_receiver.scala 145:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 132:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 145:21]
    .CLK_OUT(pll_CLK_OUT),
    .locked(pll_locked),
    .CLK_IN(pll_CLK_IN)
  );
  assign io_CLK_REC = pll_CLK_OUT; // @[intervox_receiver.scala 150:16]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 137:25]
  assign io_CLK_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 138:25]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 140:25]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 139:25]
  assign io_LEDS = 16'hf; // @[intervox_receiver.scala 136:25]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 134:25]
  assign pll_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 148:19]
endmodule
