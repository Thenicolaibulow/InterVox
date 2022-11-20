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
`endif // RANDOMIZE_REG_INIT
  wire [7:0] _expected_cycles_syncword_T = 5'h10 * 3'h4; // @[intervox_receiver.scala 25:42]
  wire [7:0] expected_cycles_syncword = _expected_cycles_syncword_T - 8'h1; // @[intervox_receiver.scala 25:49]
  wire [4:0] expected_cycles_one = 5'h10 - 5'h1; // @[intervox_receiver.scala 27:36]
  reg [7:0] clkCntr1; // @[intervox_receiver.scala 32:30]
  reg [7:0] pllCntr; // @[intervox_receiver.scala 33:30]
  reg [7:0] bufCntr; // @[intervox_receiver.scala 34:30]
  reg [15:0] bitIn; // @[intervox_receiver.scala 37:30]
  reg  outReg; // @[intervox_receiver.scala 41:30]
  reg  sync_lo; // @[intervox_receiver.scala 43:30]
  reg  sync_hi; // @[intervox_receiver.scala 44:30]
  reg  change; // @[intervox_receiver.scala 46:30]
  reg  enaBuf; // @[intervox_receiver.scala 47:30]
  wire [7:0] _pllCntr_T_1 = pllCntr + 8'h1; // @[intervox_receiver.scala 55:24]
  wire [7:0] _clkCntr1_T_1 = clkCntr1 + 8'h1; // @[intervox_receiver.scala 70:34]
  wire [6:0] _T_4 = expected_cycles_one * 2'h3; // @[intervox_receiver.scala 72:52]
  wire [7:0] _GEN_2 = {{1'd0}, _T_4}; // @[intervox_receiver.scala 72:27]
  wire  _GEN_3 = clkCntr1 == _GEN_2 | sync_lo; // @[intervox_receiver.scala 72:59 73:25 43:30]
  wire  _GEN_6 = clkCntr1 == expected_cycles_syncword | sync_hi; // @[intervox_receiver.scala 79:56 80:25 44:30]
  wire [255:0] _bitIn_T = 256'h1 << clkCntr1; // @[intervox_receiver.scala 98:35]
  wire [255:0] _GEN_18 = {{240'd0}, bitIn}; // @[intervox_receiver.scala 98:28]
  wire [255:0] _bitIn_T_1 = _GEN_18 | _bitIn_T; // @[intervox_receiver.scala 98:28]
  wire [255:0] _GEN_14 = io_DATA_IN ? _bitIn_T_1 : {{240'd0}, bitIn}; // @[intervox_receiver.scala 97:33 98:19 37:30]
  wire [7:0] _GEN_28 = {{3'd0}, expected_cycles_one}; // @[intervox_receiver.scala 102:23]
  wire  _GEN_16 = clkCntr1 == _GEN_28 | enaBuf; // @[intervox_receiver.scala 102:47 103:25 47:30]
  wire [255:0] _GEN_19 = clkCntr1 == _GEN_28 ? 256'h0 : _GEN_14; // @[intervox_receiver.scala 102:47 110:25]
  wire [7:0] _bufCntr_T_1 = bufCntr + 8'h1; // @[intervox_receiver.scala 116:32]
  wire [15:0] _T_19 = {{3'd0}, bitIn[15:3]}; // @[intervox_receiver.scala 135:27]
  wire [15:0] _T_21 = {{12'd0}, bitIn[15:12]}; // @[intervox_receiver.scala 135:42]
  wire  _T_23 = _T_19[0] != _T_21[0]; // @[intervox_receiver.scala 135:33]
  wire [255:0] _GEN_26 = sync_lo & sync_hi ? _GEN_19 : {{240'd0}, bitIn}; // @[intervox_receiver.scala 37:30 92:48]
  wire [255:0] _GEN_34 = reset ? 256'h0 : _GEN_26; // @[intervox_receiver.scala 37:{30,30}]
  assign io_CLK_OUT = outReg; // @[intervox_receiver.scala 49:21]
  assign io_DATA_OUT = change; // @[intervox_receiver.scala 50:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 32:30]
      clkCntr1 <= 8'h0; // @[intervox_receiver.scala 32:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 92:48]
      if (clkCntr1 == _GEN_28) begin // @[intervox_receiver.scala 102:47]
        clkCntr1 <= 8'h0; // @[intervox_receiver.scala 104:25]
      end else begin
        clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 94:18]
      end
    end else if (sync_lo) begin // @[intervox_receiver.scala 76:30]
      if (clkCntr1 == expected_cycles_syncword) begin // @[intervox_receiver.scala 79:56]
        clkCntr1 <= 8'h0; // @[intervox_receiver.scala 81:26]
      end else begin
        clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 77:22]
      end
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 69:33]
      clkCntr1 <= _clkCntr1_T_1; // @[intervox_receiver.scala 70:22]
    end
    if (reset) begin // @[intervox_receiver.scala 33:30]
      pllCntr <= 8'h0; // @[intervox_receiver.scala 33:30]
    end else if (pllCntr == 8'h7) begin // @[intervox_receiver.scala 56:26]
      pllCntr <= 8'h0; // @[intervox_receiver.scala 58:17]
    end else begin
      pllCntr <= _pllCntr_T_1; // @[intervox_receiver.scala 55:13]
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      bufCntr <= 8'h0; // @[intervox_receiver.scala 34:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 92:48]
      if (enaBuf) begin // @[intervox_receiver.scala 115:29]
        if (bufCntr == _GEN_28) begin // @[intervox_receiver.scala 131:50]
          bufCntr <= 8'h0; // @[intervox_receiver.scala 132:25]
        end else begin
          bufCntr <= _bufCntr_T_1; // @[intervox_receiver.scala 116:21]
        end
      end
    end
    bitIn <= _GEN_34[15:0]; // @[intervox_receiver.scala 37:{30,30}]
    if (reset) begin // @[intervox_receiver.scala 41:30]
      outReg <= 1'h0; // @[intervox_receiver.scala 41:30]
    end else if (pllCntr == 8'h7) begin // @[intervox_receiver.scala 56:26]
      outReg <= ~outReg; // @[intervox_receiver.scala 57:16]
    end
    if (reset) begin // @[intervox_receiver.scala 43:30]
      sync_lo <= 1'h0; // @[intervox_receiver.scala 43:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 69:33]
      sync_lo <= _GEN_3;
    end
    if (reset) begin // @[intervox_receiver.scala 44:30]
      sync_hi <= 1'h0; // @[intervox_receiver.scala 44:30]
    end else if (sync_lo) begin // @[intervox_receiver.scala 76:30]
      sync_hi <= _GEN_6;
    end
    if (reset) begin // @[intervox_receiver.scala 46:30]
      change <= 1'h0; // @[intervox_receiver.scala 46:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 92:48]
      if (enaBuf) begin // @[intervox_receiver.scala 115:29]
        if (bufCntr == _GEN_28) begin // @[intervox_receiver.scala 131:50]
          change <= _T_23;
        end
      end
    end
    if (reset) begin // @[intervox_receiver.scala 47:30]
      enaBuf <= 1'h0; // @[intervox_receiver.scala 47:30]
    end else if (sync_lo & sync_hi) begin // @[intervox_receiver.scala 92:48]
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
  outReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sync_lo = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sync_hi = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  change = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  enaBuf = _RAND_8[0:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 164:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 164:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 164:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 164:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 164:26]
  wire  pll_PLL_MCLK; // @[intervox_receiver.scala 172:21]
  wire  pll_locked; // @[intervox_receiver.scala 172:21]
  wire  pll_PLL_IN; // @[intervox_receiver.scala 172:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 164:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 172:21]
    .PLL_MCLK(pll_PLL_MCLK),
    .locked(pll_locked),
    .PLL_IN(pll_PLL_IN)
  );
  assign io_CLK_REC = pll_locked & pll_PLL_MCLK; // @[intervox_receiver.scala 178:32 179:20 183:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 167:25]
  assign io_NEXT_FRAME = 1'h0; // @[intervox_receiver.scala 168:25]
  assign io_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 169:25]
  assign io_DBUG1 = pll_locked; // @[intervox_receiver.scala 178:24]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 166:25]
  assign pll_PLL_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 175:19]
endmodule
