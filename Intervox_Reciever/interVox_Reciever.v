module RWSmem(
  input         clock,
  input         io_write,
  input  [63:0] io_dataIn,
  output [63:0] io_dataOut
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] mem [0:0]; // @[intervox_receiver.scala 76:24]
  wire  mem_rdwrPort_r_en; // @[intervox_receiver.scala 76:24]
  wire  mem_rdwrPort_r_addr; // @[intervox_receiver.scala 76:24]
  wire [63:0] mem_rdwrPort_r_data; // @[intervox_receiver.scala 76:24]
  wire [63:0] mem_rdwrPort_w_data; // @[intervox_receiver.scala 76:24]
  wire  mem_rdwrPort_w_addr; // @[intervox_receiver.scala 76:24]
  wire  mem_rdwrPort_w_mask; // @[intervox_receiver.scala 76:24]
  wire  mem_rdwrPort_w_en; // @[intervox_receiver.scala 76:24]
  reg  mem_rdwrPort_r_en_pipe_0;
  reg  mem_rdwrPort_r_addr_pipe_0;
  assign mem_rdwrPort_r_en = mem_rdwrPort_r_en_pipe_0;
  assign mem_rdwrPort_r_addr = mem_rdwrPort_r_addr_pipe_0;
  assign mem_rdwrPort_r_data = mem[mem_rdwrPort_r_addr]; // @[intervox_receiver.scala 76:24]
  assign mem_rdwrPort_w_data = io_dataIn;
  assign mem_rdwrPort_w_addr = 1'h0;
  assign mem_rdwrPort_w_mask = io_write;
  assign mem_rdwrPort_w_en = 1'h1 & io_write;
  assign io_dataOut = mem_rdwrPort_r_data; // @[intervox_receiver.scala 82:21 83:34]
  always @(posedge clock) begin
    if (mem_rdwrPort_w_en & mem_rdwrPort_w_mask) begin
      mem[mem_rdwrPort_w_addr] <= mem_rdwrPort_w_data; // @[intervox_receiver.scala 76:24]
    end
    mem_rdwrPort_r_en_pipe_0 <= 1'h1 & ~io_write;
    if (1'h1 & ~io_write) begin
      mem_rdwrPort_r_addr_pipe_0 <= 1'h0;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    mem[initvar] = _RAND_0[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_rdwrPort_r_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_rdwrPort_r_addr_pipe_0 = _RAND_2[0:0];
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
  output  io_RISE,
  output  io_CHANGE
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inBufr; // @[intervox_receiver.scala 12:34]
  reg [1:0] inBufrPrev; // @[intervox_receiver.scala 13:34]
  reg  trailing; // @[intervox_receiver.scala 14:34]
  reg  rising; // @[intervox_receiver.scala 15:34]
  reg  change; // @[intervox_receiver.scala 16:34]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_receiver.scala 26:35]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_receiver.scala 33:35]
  wire  _GEN_8 = rising | trailing | change; // @[intervox_receiver.scala 39:48 40:17 16:34]
  wire  _T_8 = inBufr == 2'h1; // @[intervox_receiver.scala 43:41]
  wire  _GEN_9 = inBufrPrev == 2'h0 & inBufr == 2'h1 ? 1'h0 : trailing; // @[intervox_receiver.scala 43:50 44:17 14:34]
  wire  _GEN_10 = inBufrPrev == 2'h0 & inBufr == 2'h1 | rising; // @[intervox_receiver.scala 43:50 45:17 15:34]
  wire  _GEN_11 = inBufrPrev == 2'h0 & inBufr == 2'h1 | _GEN_8; // @[intervox_receiver.scala 43:50 46:17]
  wire  _GEN_12 = inBufrPrev == 2'h2 & _T_8 | _GEN_9; // @[intervox_receiver.scala 49:50 50:17]
  wire  _GEN_14 = inBufrPrev == 2'h2 & _T_8 | _GEN_11; // @[intervox_receiver.scala 49:50 52:17]
  assign io_RISE = rising; // @[intervox_receiver.scala 64:13]
  assign io_CHANGE = change; // @[intervox_receiver.scala 62:13]
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
    if (reset) begin // @[intervox_receiver.scala 14:34]
      trailing <= 1'h0; // @[intervox_receiver.scala 14:34]
    end else if (trailing) begin // @[intervox_receiver.scala 55:27]
      trailing <= 1'h0; // @[intervox_receiver.scala 55:37]
    end else begin
      trailing <= _GEN_12;
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
    if (reset) begin // @[intervox_receiver.scala 16:34]
      change <= 1'h0; // @[intervox_receiver.scala 16:34]
    end else if (change) begin // @[intervox_receiver.scala 58:25]
      change <= 1'h0; // @[intervox_receiver.scala 59:16]
    end else begin
      change <= _GEN_14;
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
  trailing = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  rising = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  change = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module clock_Recovery(
  input         clock,
  input         reset,
  input         io_DATA_IN,
  output        io_CLK_OUT,
  output        io_DATA_OUT,
  output        io_DBUG,
  output        io_DBUG1,
  output [63:0] io_DATAREG
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  wire  BFR_clock; // @[intervox_receiver.scala 98:29]
  wire  BFR_io_write; // @[intervox_receiver.scala 98:29]
  wire [63:0] BFR_io_dataIn; // @[intervox_receiver.scala 98:29]
  wire [63:0] BFR_io_dataOut; // @[intervox_receiver.scala 98:29]
  wire  DATAEDGE_clock; // @[intervox_receiver.scala 133:38]
  wire  DATAEDGE_reset; // @[intervox_receiver.scala 133:38]
  wire  DATAEDGE_io_INPUT; // @[intervox_receiver.scala 133:38]
  wire  DATAEDGE_io_RISE; // @[intervox_receiver.scala 133:38]
  wire  DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 133:38]
  wire  CLKREC_EDGE_clock; // @[intervox_receiver.scala 137:41]
  wire  CLKREC_EDGE_reset; // @[intervox_receiver.scala 137:41]
  wire  CLKREC_EDGE_io_INPUT; // @[intervox_receiver.scala 137:41]
  wire  CLKREC_EDGE_io_RISE; // @[intervox_receiver.scala 137:41]
  wire  CLKREC_EDGE_io_CHANGE; // @[intervox_receiver.scala 137:41]
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 112:30]
  reg [6:0] bitCntr; // @[intervox_receiver.scala 113:30]
  reg  clkRec; // @[intervox_receiver.scala 114:30]
  reg  change; // @[intervox_receiver.scala 115:30]
  reg  dataOut; // @[intervox_receiver.scala 116:30]
  reg [63:0] dataReg; // @[intervox_receiver.scala 117:30]
  reg  syncWord; // @[intervox_receiver.scala 118:30]
  reg  zeroFlipped; // @[intervox_receiver.scala 119:30]
  reg  syncFlipped; // @[intervox_receiver.scala 120:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 121:30]
  reg  syncFlipped2; // @[intervox_receiver.scala 122:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 131:31]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 147:28]
  wire  _GEN_0 = syncWord ? 1'h0 : syncWord; // @[intervox_receiver.scala 154:31 155:25 118:30]
  wire [6:0] _GEN_1 = syncWord ? 7'h0 : bitCntr; // @[intervox_receiver.scala 154:31 156:25 113:30]
  wire  _GEN_6 = change ? ~clkRec : clkRec; // @[intervox_receiver.scala 143:25 147:25 114:30]
  wire  _GEN_8 = change ? 1'h0 : zeroFlipped; // @[intervox_receiver.scala 143:25 151:25 119:30]
  wire  _GEN_9 = change ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 143:25 152:25 120:30]
  wire  _GEN_10 = change ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 143:25 153:25 121:30]
  wire  _GEN_11 = change ? _GEN_0 : syncWord; // @[intervox_receiver.scala 143:25 118:30]
  wire [6:0] _GEN_12 = change ? _GEN_1 : bitCntr; // @[intervox_receiver.scala 143:25 113:30]
  wire  _GEN_14 = change & syncWord; // @[intervox_receiver.scala 143:25 102:27]
  wire [6:0] _bitCntr_T_1 = bitCntr + 7'h1; // @[intervox_receiver.scala 165:28]
  wire [6:0] _GEN_16 = CLKREC_EDGE_io_RISE ? _bitCntr_T_1 : _GEN_12; // @[intervox_receiver.scala 164:38 165:17]
  wire [6:0] _BFR_io_dataIn_T_1 = 7'h40 - bitCntr; // @[intervox_receiver.scala 181:65]
  wire [127:0] _BFR_io_dataIn_T_2 = 128'h1 << _BFR_io_dataIn_T_1; // @[intervox_receiver.scala 181:56]
  wire [127:0] _GEN_53 = {{64'd0}, BFR_io_dataOut}; // @[intervox_receiver.scala 181:49]
  wire [127:0] _BFR_io_dataIn_T_4 = _GEN_53 + _BFR_io_dataIn_T_2; // @[intervox_receiver.scala 181:49]
  wire  _GEN_17 = change | dataOut; // @[intervox_receiver.scala 174:29 177:21 116:30]
  wire  _GEN_18 = change | _GEN_14; // @[intervox_receiver.scala 174:29 180:31]
  wire [127:0] _GEN_19 = change ? _BFR_io_dataIn_T_4 : 128'h0; // @[intervox_receiver.scala 174:29 181:31]
  wire  _GEN_21 = deltaCntr <= 8'h10 ? _GEN_18 : _GEN_14; // @[intervox_receiver.scala 171:41]
  wire [127:0] _GEN_22 = deltaCntr <= 8'h10 ? _GEN_19 : 128'h0; // @[intervox_receiver.scala 171:41]
  wire [9:0] _T_10 = 8'hf * 2'h2; // @[intervox_receiver.scala 191:65]
  wire [9:0] _T_12 = _T_10 + 10'h2; // @[intervox_receiver.scala 191:72]
  wire [9:0] _GEN_54 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 191:53]
  wire [127:0] _BFR_io_dataIn_T_7 = 128'h0 << _BFR_io_dataIn_T_1; // @[intervox_receiver.scala 201:56]
  wire [127:0] _BFR_io_dataIn_T_9 = _GEN_53 + _BFR_io_dataIn_T_7; // @[intervox_receiver.scala 201:49]
  wire  _GEN_23 = ~zeroFlipped ? _clkRec_T : _GEN_6; // @[intervox_receiver.scala 194:34 197:20]
  wire  _GEN_24 = ~zeroFlipped | _GEN_8; // @[intervox_receiver.scala 194:34 198:25]
  wire  _GEN_25 = ~zeroFlipped | _GEN_21; // @[intervox_receiver.scala 194:34 200:31]
  wire [127:0] _GEN_26 = ~zeroFlipped ? _BFR_io_dataIn_T_9 : _GEN_22; // @[intervox_receiver.scala 194:34 201:31]
  wire  _GEN_27 = deltaCntr > 8'h10 & _GEN_54 < _T_12 ? _GEN_23 : _GEN_6; // @[intervox_receiver.scala 191:80]
  wire [127:0] _GEN_30 = deltaCntr > 8'h10 & _GEN_54 < _T_12 ? _GEN_26 : _GEN_22; // @[intervox_receiver.scala 191:80]
  wire  _T_16 = ~change; // @[intervox_receiver.scala 211:17]
  wire  _GEN_32 = ~syncFlipped ? _clkRec_T : _GEN_27; // @[intervox_receiver.scala 220:38 222:24]
  wire  _GEN_33 = ~syncFlipped | _GEN_9; // @[intervox_receiver.scala 220:38 223:29]
  wire  _GEN_34 = _GEN_54 == _T_12 ? _GEN_32 : _GEN_27; // @[intervox_receiver.scala 213:52]
  wire [9:0] _T_22 = 8'hf * 2'h3; // @[intervox_receiver.scala 226:38]
  wire  _GEN_36 = ~syncFlipped1 ? _clkRec_T : _GEN_34; // @[intervox_receiver.scala 234:39 236:24]
  wire  _GEN_37 = ~syncFlipped1 | _GEN_10; // @[intervox_receiver.scala 234:39 237:30]
  wire  _GEN_39 = _GEN_54 == _T_22 | _GEN_11; // @[intervox_receiver.scala 226:46 233:22]
  wire  _GEN_40 = _GEN_54 == _T_22 ? _GEN_36 : _GEN_34; // @[intervox_receiver.scala 226:46]
  wire [10:0] _T_25 = 8'hf * 3'h4; // @[intervox_receiver.scala 242:38]
  wire [10:0] _GEN_58 = {{3'd0}, deltaCntr}; // @[intervox_receiver.scala 242:25]
  wire  _GEN_44 = ~syncFlipped2 | syncFlipped2; // @[intervox_receiver.scala 122:30 249:39 252:30]
  RWSmem BFR ( // @[intervox_receiver.scala 98:29]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  edgeDetector DATAEDGE ( // @[intervox_receiver.scala 133:38]
    .clock(DATAEDGE_clock),
    .reset(DATAEDGE_reset),
    .io_INPUT(DATAEDGE_io_INPUT),
    .io_RISE(DATAEDGE_io_RISE),
    .io_CHANGE(DATAEDGE_io_CHANGE)
  );
  edgeDetector CLKREC_EDGE ( // @[intervox_receiver.scala 137:41]
    .clock(CLKREC_EDGE_clock),
    .reset(CLKREC_EDGE_reset),
    .io_INPUT(CLKREC_EDGE_io_INPUT),
    .io_RISE(CLKREC_EDGE_io_RISE),
    .io_CHANGE(CLKREC_EDGE_io_CHANGE)
  );
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 124:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 125:21]
  assign io_DBUG = change; // @[intervox_receiver.scala 126:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 127:21]
  assign io_DATAREG = dataReg; // @[intervox_receiver.scala 129:21]
  assign BFR_clock = clock;
  assign BFR_io_write = deltaCntr > 8'h10 & _GEN_54 < _T_12 ? _GEN_25 : _GEN_21; // @[intervox_receiver.scala 191:80]
  assign BFR_io_dataIn = _GEN_30[63:0];
  assign DATAEDGE_clock = clock;
  assign DATAEDGE_reset = reset;
  assign DATAEDGE_io_INPUT = io_DATA_IN; // @[intervox_receiver.scala 134:29]
  assign CLKREC_EDGE_clock = clock;
  assign CLKREC_EDGE_reset = reset;
  assign CLKREC_EDGE_io_INPUT = io_DATA_IN; // @[intervox_receiver.scala 138:32]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 112:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 112:30]
    end else if (change) begin // @[intervox_receiver.scala 143:25]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 149:25]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 131:18]
    end
    if (reset) begin // @[intervox_receiver.scala 113:30]
      bitCntr <= 7'h0; // @[intervox_receiver.scala 113:30]
    end else if (~change) begin // @[intervox_receiver.scala 211:25]
      if (_GEN_54 == _T_22) begin // @[intervox_receiver.scala 226:46]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 234:39]
          bitCntr <= 7'h0; // @[intervox_receiver.scala 239:25]
        end else begin
          bitCntr <= _GEN_16;
        end
      end else begin
        bitCntr <= _GEN_16;
      end
    end else begin
      bitCntr <= _GEN_16;
    end
    if (reset) begin // @[intervox_receiver.scala 114:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 114:30]
    end else if (~change) begin // @[intervox_receiver.scala 211:25]
      if (_GEN_58 == _T_25 & _T_16) begin // @[intervox_receiver.scala 242:65]
        if (~syncFlipped2) begin // @[intervox_receiver.scala 249:39]
          clkRec <= _clkRec_T; // @[intervox_receiver.scala 251:24]
        end else begin
          clkRec <= _GEN_40;
        end
      end else begin
        clkRec <= _GEN_40;
      end
    end else if (deltaCntr > 8'h10 & _GEN_54 < _T_12) begin // @[intervox_receiver.scala 191:80]
      if (~zeroFlipped) begin // @[intervox_receiver.scala 194:34]
        clkRec <= _clkRec_T; // @[intervox_receiver.scala 197:20]
      end else begin
        clkRec <= _GEN_6;
      end
    end else begin
      clkRec <= _GEN_6;
    end
    if (reset) begin // @[intervox_receiver.scala 115:30]
      change <= 1'h0; // @[intervox_receiver.scala 115:30]
    end else if (change) begin // @[intervox_receiver.scala 143:25]
      change <= 1'h0; // @[intervox_receiver.scala 145:16]
    end else begin
      change <= DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 135:29]
    end
    if (reset) begin // @[intervox_receiver.scala 116:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 116:30]
    end else if (deltaCntr > 8'h10 & _GEN_54 < _T_12) begin // @[intervox_receiver.scala 191:80]
      dataOut <= 1'h0; // @[intervox_receiver.scala 204:17]
    end else if (deltaCntr <= 8'h10) begin // @[intervox_receiver.scala 171:41]
      dataOut <= _GEN_17;
    end
    if (reset) begin // @[intervox_receiver.scala 117:30]
      dataReg <= 64'h0; // @[intervox_receiver.scala 117:30]
    end else if (change) begin // @[intervox_receiver.scala 143:25]
      if (syncWord) begin // @[intervox_receiver.scala 154:31]
        dataReg <= BFR_io_dataOut; // @[intervox_receiver.scala 157:25]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 118:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 118:30]
    end else if (~change) begin // @[intervox_receiver.scala 211:25]
      syncWord <= _GEN_39;
    end else if (change) begin // @[intervox_receiver.scala 143:25]
      if (syncWord) begin // @[intervox_receiver.scala 154:31]
        syncWord <= 1'h0; // @[intervox_receiver.scala 155:25]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 119:30]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 119:30]
    end else if (deltaCntr > 8'h10 & _GEN_54 < _T_12) begin // @[intervox_receiver.scala 191:80]
      zeroFlipped <= _GEN_24;
    end else if (change) begin // @[intervox_receiver.scala 143:25]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 151:25]
    end
    if (reset) begin // @[intervox_receiver.scala 120:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 120:30]
    end else if (~change) begin // @[intervox_receiver.scala 211:25]
      if (_GEN_54 == _T_12) begin // @[intervox_receiver.scala 213:52]
        syncFlipped <= _GEN_33;
      end else begin
        syncFlipped <= _GEN_9;
      end
    end else begin
      syncFlipped <= _GEN_9;
    end
    if (reset) begin // @[intervox_receiver.scala 121:30]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 121:30]
    end else if (~change) begin // @[intervox_receiver.scala 211:25]
      if (_GEN_54 == _T_22) begin // @[intervox_receiver.scala 226:46]
        syncFlipped1 <= _GEN_37;
      end else begin
        syncFlipped1 <= _GEN_10;
      end
    end else begin
      syncFlipped1 <= _GEN_10;
    end
    if (reset) begin // @[intervox_receiver.scala 122:30]
      syncFlipped2 <= 1'h0; // @[intervox_receiver.scala 122:30]
    end else if (~change) begin // @[intervox_receiver.scala 211:25]
      if (_GEN_58 == _T_25 & _T_16) begin // @[intervox_receiver.scala 242:65]
        syncFlipped2 <= _GEN_44;
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
  deltaCntr = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  bitCntr = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  clkRec = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  change = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dataOut = _RAND_4[0:0];
  _RAND_5 = {2{`RANDOM}};
  dataReg = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  syncWord = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  zeroFlipped = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  syncFlipped = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  syncFlipped1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  syncFlipped2 = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module i2s_Transmitter(
  input         clock,
  input         reset,
  input         io_CLK_IN,
  input  [63:0] io_DATA_IN,
  input         io_NEXT,
  output        io_BCLK,
  output        io_LRCLK,
  output        io_SDATA
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  BCLKEDGE_clock; // @[intervox_receiver.scala 280:37]
  wire  BCLKEDGE_reset; // @[intervox_receiver.scala 280:37]
  wire  BCLKEDGE_io_INPUT; // @[intervox_receiver.scala 280:37]
  wire  BCLKEDGE_io_RISE; // @[intervox_receiver.scala 280:37]
  wire  BCLKEDGE_io_CHANGE; // @[intervox_receiver.scala 280:37]
  reg  enable; // @[intervox_receiver.scala 268:26]
  reg [7:0] bitCntr; // @[intervox_receiver.scala 269:26]
  reg  lrclk; // @[intervox_receiver.scala 270:26]
  reg  sdataO; // @[intervox_receiver.scala 272:26]
  reg [63:0] sdata; // @[intervox_receiver.scala 273:26]
  wire  _GEN_0 = io_NEXT | enable; // @[intervox_receiver.scala 283:26 284:17 268:26]
  wire [7:0] _GEN_1 = io_NEXT ? 8'h0 : bitCntr; // @[intervox_receiver.scala 283:26 285:17 269:26]
  wire [7:0] _GEN_3 = bitCntr >= 8'h3f ? 8'h0 : _GEN_1; // @[intervox_receiver.scala 288:26 290:17]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_receiver.scala 297:32]
  wire  _GEN_4 = bitCntr == 8'h0 | lrclk; // @[intervox_receiver.scala 299:34 300:23 270:26]
  wire [63:0] _sdataO_T = sdata >> bitCntr; // @[intervox_receiver.scala 307:34]
  edgeDetector BCLKEDGE ( // @[intervox_receiver.scala 280:37]
    .clock(BCLKEDGE_clock),
    .reset(BCLKEDGE_reset),
    .io_INPUT(BCLKEDGE_io_INPUT),
    .io_RISE(BCLKEDGE_io_RISE),
    .io_CHANGE(BCLKEDGE_io_CHANGE)
  );
  assign io_BCLK = io_CLK_IN; // @[intervox_receiver.scala 276:17]
  assign io_LRCLK = lrclk; // @[intervox_receiver.scala 277:17]
  assign io_SDATA = sdataO; // @[intervox_receiver.scala 278:17]
  assign BCLKEDGE_clock = clock;
  assign BCLKEDGE_reset = reset;
  assign BCLKEDGE_io_INPUT = io_CLK_IN; // @[intervox_receiver.scala 281:31]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 268:26]
      enable <= 1'h0; // @[intervox_receiver.scala 268:26]
    end else if (bitCntr >= 8'h3f) begin // @[intervox_receiver.scala 288:26]
      enable <= 1'h0; // @[intervox_receiver.scala 289:16]
    end else begin
      enable <= _GEN_0;
    end
    if (reset) begin // @[intervox_receiver.scala 269:26]
      bitCntr <= 8'h0; // @[intervox_receiver.scala 269:26]
    end else if (enable) begin // @[intervox_receiver.scala 293:25]
      if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 295:39]
        bitCntr <= _bitCntr_T_1; // @[intervox_receiver.scala 297:21]
      end else begin
        bitCntr <= _GEN_3;
      end
    end else begin
      bitCntr <= _GEN_3;
    end
    if (reset) begin // @[intervox_receiver.scala 270:26]
      lrclk <= 1'h0; // @[intervox_receiver.scala 270:26]
    end else if (enable) begin // @[intervox_receiver.scala 293:25]
      if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 295:39]
        if (bitCntr == 8'h1f) begin // @[intervox_receiver.scala 303:35]
          lrclk <= 1'h0; // @[intervox_receiver.scala 304:23]
        end else begin
          lrclk <= _GEN_4;
        end
      end
    end
    if (reset) begin // @[intervox_receiver.scala 272:26]
      sdataO <= 1'h0; // @[intervox_receiver.scala 272:26]
    end else if (enable) begin // @[intervox_receiver.scala 293:25]
      if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 295:39]
        sdataO <= _sdataO_T[0]; // @[intervox_receiver.scala 307:20]
      end
    end
    if (reset) begin // @[intervox_receiver.scala 273:26]
      sdata <= 64'h0; // @[intervox_receiver.scala 273:26]
    end else begin
      sdata <= io_DATA_IN; // @[intervox_receiver.scala 275:17]
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
  bitCntr = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  lrclk = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sdataO = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  sdata = _RAND_4[63:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 327:29]
  wire  clockRec_reset; // @[intervox_receiver.scala 327:29]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 327:29]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 327:29]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 327:29]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 327:29]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 327:29]
  wire [63:0] clockRec_io_DATAREG; // @[intervox_receiver.scala 327:29]
  wire  i2sTrans_clock; // @[intervox_receiver.scala 336:29]
  wire  i2sTrans_reset; // @[intervox_receiver.scala 336:29]
  wire  i2sTrans_io_CLK_IN; // @[intervox_receiver.scala 336:29]
  wire [63:0] i2sTrans_io_DATA_IN; // @[intervox_receiver.scala 336:29]
  wire  i2sTrans_io_NEXT; // @[intervox_receiver.scala 336:29]
  wire  i2sTrans_io_BCLK; // @[intervox_receiver.scala 336:29]
  wire  i2sTrans_io_LRCLK; // @[intervox_receiver.scala 336:29]
  wire  i2sTrans_io_SDATA; // @[intervox_receiver.scala 336:29]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 327:29]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1),
    .io_DATAREG(clockRec_io_DATAREG)
  );
  i2s_Transmitter i2sTrans ( // @[intervox_receiver.scala 336:29]
    .clock(i2sTrans_clock),
    .reset(i2sTrans_reset),
    .io_CLK_IN(i2sTrans_io_CLK_IN),
    .io_DATA_IN(i2sTrans_io_DATA_IN),
    .io_NEXT(i2sTrans_io_NEXT),
    .io_BCLK(i2sTrans_io_BCLK),
    .io_LRCLK(i2sTrans_io_LRCLK),
    .io_SDATA(i2sTrans_io_SDATA)
  );
  assign io_CLK_REC = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 332:21]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 330:21]
  assign io_CLK_DBUG = 1'h0; // @[intervox_receiver.scala 331:21]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 334:21]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 333:21]
  assign io_LEDS = 16'hf; // @[intervox_receiver.scala 329:21]
  assign io_BCLK = i2sTrans_io_BCLK; // @[intervox_receiver.scala 340:21]
  assign io_LRCLK = i2sTrans_io_LRCLK; // @[intervox_receiver.scala 342:21]
  assign io_SDATA = i2sTrans_io_SDATA; // @[intervox_receiver.scala 341:21]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 328:29]
  assign i2sTrans_clock = clock;
  assign i2sTrans_reset = reset;
  assign i2sTrans_io_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 337:29]
  assign i2sTrans_io_DATA_IN = clockRec_io_DATAREG; // @[intervox_receiver.scala 338:29]
  assign i2sTrans_io_NEXT = clockRec_io_DBUG1; // @[intervox_receiver.scala 339:29]
endmodule
