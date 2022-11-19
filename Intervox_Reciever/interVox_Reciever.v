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
`endif // RANDOMIZE_REG_INIT
  wire [8:0] _expected_cycles_syncword_T = 6'h20 * 3'h4; // @[intervox_receiver.scala 25:42]
  wire [8:0] expected_cycles_syncword = _expected_cycles_syncword_T - 9'h1; // @[intervox_receiver.scala 25:49]
  wire [6:0] expected_cycles_zero = 7'h40 - 7'h1; // @[intervox_receiver.scala 26:37]
  wire [5:0] expected_cycles_one = 6'h20 - 6'h1; // @[intervox_receiver.scala 27:36]
  reg [7:0] clkCntr; // @[intervox_receiver.scala 29:30]
  reg [7:0] pllCntr; // @[intervox_receiver.scala 30:30]
  reg  inState; // @[intervox_receiver.scala 31:30]
  reg  outReg; // @[intervox_receiver.scala 34:30]
  reg  dataOut; // @[intervox_receiver.scala 35:30]
  reg  nextFrame; // @[intervox_receiver.scala 36:30]
  reg  noChange; // @[intervox_receiver.scala 37:30]
  wire [7:0] _pllCntr_T_1 = pllCntr + 8'h1; // @[intervox_receiver.scala 43:24]
  wire  _T_1 = ~io_DATA_IN; // @[intervox_receiver.scala 50:23]
  wire [7:0] _clkCntr_T_1 = clkCntr + 8'h1; // @[intervox_receiver.scala 59:32]
  wire  _GEN_3 = ~inState | inState; // @[intervox_receiver.scala 63:34 65:25 31:30]
  wire [7:0] _GEN_5 = io_DATA_IN ? _clkCntr_T_1 : clkCntr; // @[intervox_receiver.scala 50:23 68:21 29:30]
  wire [7:0] _GEN_7 = ~io_DATA_IN ? _clkCntr_T_1 : _GEN_5; // @[intervox_receiver.scala 50:23 59:21]
  wire [8:0] _T_6 = expected_cycles_syncword - 9'h10; // @[intervox_receiver.scala 72:47]
  wire [8:0] _GEN_23 = {{1'd0}, clkCntr}; // @[intervox_receiver.scala 72:18]
  wire  _GEN_8 = inState | nextFrame; // @[intervox_receiver.scala 74:30 76:23 36:30]
  wire [7:0] _GEN_9 = _GEN_23 >= expected_cycles_syncword ? 8'h0 : _GEN_7; // @[intervox_receiver.scala 78:52 80:21]
  wire [7:0] _GEN_11 = _GEN_23 >= _T_6 ? _GEN_9 : _GEN_7; // @[intervox_receiver.scala 72:55]
  wire  _GEN_12 = inState == io_DATA_IN | noChange; // @[intervox_receiver.scala 87:37 89:22 37:30]
  wire [7:0] _GEN_25 = {{2'd0}, expected_cycles_one}; // @[intervox_receiver.scala 98:18]
  wire  _GEN_15 = ~noChange | dataOut; // @[intervox_receiver.scala 100:31 102:21 35:30]
  wire [7:0] _GEN_16 = ~noChange ? 8'h0 : _GEN_11; // @[intervox_receiver.scala 100:31 103:21]
  wire  _GEN_17 = clkCntr == _GEN_25 ? _GEN_15 : dataOut; // @[intervox_receiver.scala 35:30 98:42]
  wire [7:0] _GEN_18 = clkCntr == _GEN_25 ? _GEN_16 : _GEN_11; // @[intervox_receiver.scala 98:42]
  wire [7:0] _GEN_27 = {{1'd0}, expected_cycles_zero}; // @[intervox_receiver.scala 114:22]
  assign io_CLK_OUT = outReg; // @[intervox_receiver.scala 39:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 40:21]
  assign io_NEXT_FRAME = nextFrame; // @[intervox_receiver.scala 41:21]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 29:30]
      clkCntr <= 8'h0; // @[intervox_receiver.scala 29:30]
    end else if (clkCntr > _GEN_25) begin // @[intervox_receiver.scala 107:40]
      if (clkCntr == _GEN_27) begin // @[intervox_receiver.scala 114:47]
        clkCntr <= 8'h0; // @[intervox_receiver.scala 116:21]
      end else begin
        clkCntr <= _GEN_18;
      end
    end else begin
      clkCntr <= _GEN_18;
    end
    if (reset) begin // @[intervox_receiver.scala 30:30]
      pllCntr <= 8'h0; // @[intervox_receiver.scala 30:30]
    end else if (pllCntr == 8'h7) begin // @[intervox_receiver.scala 44:26]
      pllCntr <= 8'h0; // @[intervox_receiver.scala 46:17]
    end else begin
      pllCntr <= _pllCntr_T_1; // @[intervox_receiver.scala 43:13]
    end
    if (reset) begin // @[intervox_receiver.scala 31:30]
      inState <= 1'h0; // @[intervox_receiver.scala 31:30]
    end else if (~io_DATA_IN) begin // @[intervox_receiver.scala 50:23]
      if (inState) begin // @[intervox_receiver.scala 54:36]
        inState <= 1'h0; // @[intervox_receiver.scala 56:25]
      end
    end else if (io_DATA_IN) begin // @[intervox_receiver.scala 50:23]
      inState <= _GEN_3;
    end
    if (reset) begin // @[intervox_receiver.scala 34:30]
      outReg <= 1'h0; // @[intervox_receiver.scala 34:30]
    end else if (pllCntr == 8'h7) begin // @[intervox_receiver.scala 44:26]
      outReg <= ~outReg; // @[intervox_receiver.scala 45:16]
    end
    if (reset) begin // @[intervox_receiver.scala 35:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 35:30]
    end else if (clkCntr > _GEN_25) begin // @[intervox_receiver.scala 107:40]
      if (noChange) begin // @[intervox_receiver.scala 109:31]
        dataOut <= 1'h0; // @[intervox_receiver.scala 111:21]
      end else begin
        dataOut <= _GEN_17;
      end
    end else begin
      dataOut <= _GEN_17;
    end
    if (reset) begin // @[intervox_receiver.scala 36:30]
      nextFrame <= 1'h0; // @[intervox_receiver.scala 36:30]
    end else if (_GEN_23 >= _T_6) begin // @[intervox_receiver.scala 72:55]
      nextFrame <= _GEN_8;
    end
    if (reset) begin // @[intervox_receiver.scala 37:30]
      noChange <= 1'h0; // @[intervox_receiver.scala 37:30]
    end else if (clkCntr == 8'h10 | clkCntr == 8'h30) begin // @[intervox_receiver.scala 85:47]
      if (inState == _T_1) begin // @[intervox_receiver.scala 92:38]
        noChange <= 1'h0; // @[intervox_receiver.scala 94:22]
      end else begin
        noChange <= _GEN_12;
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
  clkCntr = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  pllCntr = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  inState = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  outReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dataOut = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  nextFrame = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  noChange = _RAND_6[0:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 137:26]
  wire  clockRec_reset; // @[intervox_receiver.scala 137:26]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 137:26]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 137:26]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 137:26]
  wire  clockRec_io_NEXT_FRAME; // @[intervox_receiver.scala 137:26]
  wire  pll_PLL_MCLK; // @[intervox_receiver.scala 145:21]
  wire  pll_locked; // @[intervox_receiver.scala 145:21]
  wire  pll_PLL_IN; // @[intervox_receiver.scala 145:21]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 137:26]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_NEXT_FRAME(clockRec_io_NEXT_FRAME)
  );
  clk_wiz_0_clk_wiz pll ( // @[intervox_receiver.scala 145:21]
    .PLL_MCLK(pll_PLL_MCLK),
    .locked(pll_locked),
    .PLL_IN(pll_PLL_IN)
  );
  assign io_CLK_REC = pll_locked & pll_PLL_MCLK; // @[intervox_receiver.scala 151:32 152:20 156:20]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 140:25]
  assign io_NEXT_FRAME = clockRec_io_NEXT_FRAME; // @[intervox_receiver.scala 141:25]
  assign io_DBUG = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 142:25]
  assign io_DBUG1 = pll_locked; // @[intervox_receiver.scala 151:24]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 139:25]
  assign pll_PLL_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 148:19]
endmodule
