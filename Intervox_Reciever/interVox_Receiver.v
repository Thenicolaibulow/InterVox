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
  output [15:0] io_LED,
  input  [15:0] io_SW,
  output [63:0] io_DATAREG,
  input         io_BTN_C
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire  BFR_clock; // @[intervox_receiver.scala 100:29]
  wire  BFR_io_write; // @[intervox_receiver.scala 100:29]
  wire [63:0] BFR_io_dataIn; // @[intervox_receiver.scala 100:29]
  wire [63:0] BFR_io_dataOut; // @[intervox_receiver.scala 100:29]
  wire  DATAEDGE_clock; // @[intervox_receiver.scala 136:38]
  wire  DATAEDGE_reset; // @[intervox_receiver.scala 136:38]
  wire  DATAEDGE_io_INPUT; // @[intervox_receiver.scala 136:38]
  wire  DATAEDGE_io_RISE; // @[intervox_receiver.scala 136:38]
  wire  DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 136:38]
  wire  CLKREC_EDGE_clock; // @[intervox_receiver.scala 140:41]
  wire  CLKREC_EDGE_reset; // @[intervox_receiver.scala 140:41]
  wire  CLKREC_EDGE_io_INPUT; // @[intervox_receiver.scala 140:41]
  wire  CLKREC_EDGE_io_RISE; // @[intervox_receiver.scala 140:41]
  wire  CLKREC_EDGE_io_CHANGE; // @[intervox_receiver.scala 140:41]
  reg [7:0] lastOne; // @[intervox_receiver.scala 111:30]
  reg [15:0] leds; // @[intervox_receiver.scala 112:30]
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 115:30]
  reg [6:0] bitCntr; // @[intervox_receiver.scala 116:30]
  reg  clkRec; // @[intervox_receiver.scala 117:30]
  reg  change; // @[intervox_receiver.scala 118:30]
  reg  dataOut; // @[intervox_receiver.scala 119:30]
  reg [63:0] dataReg; // @[intervox_receiver.scala 120:30]
  reg  syncWord; // @[intervox_receiver.scala 121:30]
  reg  zeroFlipped; // @[intervox_receiver.scala 122:30]
  reg  syncFlipped; // @[intervox_receiver.scala 123:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 124:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 134:31]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 150:28]
  wire  _GEN_1 = change ? ~clkRec : clkRec; // @[intervox_receiver.scala 146:25 150:25 117:30]
  wire  _GEN_3 = change ? 1'h0 : zeroFlipped; // @[intervox_receiver.scala 146:25 154:25 122:30]
  wire  _GEN_4 = change ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 146:25 155:25 123:30]
  wire  _GEN_5 = change ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 146:25 156:25 124:30]
  wire  _GEN_6 = syncWord ? 1'h0 : syncWord; // @[intervox_receiver.scala 159:27 160:21 121:30]
  wire [6:0] _GEN_7 = syncWord ? 7'h0 : bitCntr; // @[intervox_receiver.scala 159:27 161:21 116:30]
  wire [6:0] _bitCntr_T_1 = bitCntr + 7'h1; // @[intervox_receiver.scala 169:28]
  wire [6:0] _GEN_11 = CLKREC_EDGE_io_RISE ? _bitCntr_T_1 : _GEN_7; // @[intervox_receiver.scala 168:38 169:17]
  wire [7:0] _T_4 = lastOne + 8'h2; // @[intervox_receiver.scala 175:33]
  wire [6:0] _BFR_io_dataIn_T_1 = 7'h3f - bitCntr; // @[intervox_receiver.scala 185:65]
  wire [6:0] _BFR_io_dataIn_T_3 = _BFR_io_dataIn_T_1 + 7'h2; // @[intervox_receiver.scala 185:75]
  wire [127:0] _BFR_io_dataIn_T_4 = 128'h1 << _BFR_io_dataIn_T_3; // @[intervox_receiver.scala 185:56]
  wire [127:0] _GEN_48 = {{64'd0}, BFR_io_dataOut}; // @[intervox_receiver.scala 185:49]
  wire [127:0] _BFR_io_dataIn_T_5 = _GEN_48 | _BFR_io_dataIn_T_4; // @[intervox_receiver.scala 185:49]
  wire  _GEN_12 = change | dataOut; // @[intervox_receiver.scala 178:29 181:21 119:30]
  wire  _GEN_13 = change | syncWord; // @[intervox_receiver.scala 178:29 184:31]
  wire [127:0] _GEN_14 = change ? _BFR_io_dataIn_T_5 : 128'h0; // @[intervox_receiver.scala 178:29 185:31]
  wire  _GEN_15 = deltaCntr <= _T_4 ? _GEN_12 : dataOut; // @[intervox_receiver.scala 119:30 175:41]
  wire  _GEN_16 = deltaCntr <= _T_4 ? _GEN_13 : syncWord; // @[intervox_receiver.scala 175:41]
  wire [127:0] _GEN_17 = deltaCntr <= _T_4 ? _GEN_14 : 128'h0; // @[intervox_receiver.scala 175:41]
  wire [9:0] _T_10 = lastOne * 2'h2; // @[intervox_receiver.scala 195:65]
  wire [9:0] _GEN_49 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 195:53]
  wire [6:0] _BFR_io_dataIn_T_7 = bitCntr + 7'h2; // @[intervox_receiver.scala 205:76]
  wire [6:0] _BFR_io_dataIn_T_9 = 7'h3f - _BFR_io_dataIn_T_7; // @[intervox_receiver.scala 205:65]
  wire [127:0] _BFR_io_dataIn_T_10 = 128'h0 << _BFR_io_dataIn_T_9; // @[intervox_receiver.scala 205:56]
  wire [127:0] _BFR_io_dataIn_T_11 = _GEN_48 | _BFR_io_dataIn_T_10; // @[intervox_receiver.scala 205:49]
  wire  _GEN_18 = ~zeroFlipped ? _clkRec_T : _GEN_1; // @[intervox_receiver.scala 198:34 201:20]
  wire  _GEN_19 = ~zeroFlipped | _GEN_3; // @[intervox_receiver.scala 198:34 202:25]
  wire  _GEN_20 = ~zeroFlipped | _GEN_16; // @[intervox_receiver.scala 198:34 204:31]
  wire [127:0] _GEN_21 = ~zeroFlipped ? _BFR_io_dataIn_T_11 : _GEN_17; // @[intervox_receiver.scala 198:34 205:31]
  wire  _GEN_23 = deltaCntr > _T_4 & _GEN_49 < _T_10 ? _GEN_18 : _GEN_1; // @[intervox_receiver.scala 195:74]
  wire [127:0] _GEN_26 = deltaCntr > _T_4 & _GEN_49 < _T_10 ? _GEN_21 : _GEN_17; // @[intervox_receiver.scala 195:74]
  wire [9:0] _T_17 = _T_10 + 10'h2; // @[intervox_receiver.scala 217:45]
  wire  _GEN_28 = ~syncFlipped ? _clkRec_T : _GEN_23; // @[intervox_receiver.scala 224:38 226:24]
  wire  _GEN_29 = ~syncFlipped | _GEN_4; // @[intervox_receiver.scala 224:38 227:29]
  wire  _GEN_30 = _GEN_49 >= _T_17 ? _GEN_28 : _GEN_23; // @[intervox_receiver.scala 217:53]
  wire [9:0] _T_20 = lastOne * 2'h3; // @[intervox_receiver.scala 230:38]
  wire  _GEN_33 = ~syncFlipped1 | _GEN_5; // @[intervox_receiver.scala 238:39 241:30]
  wire  _GEN_35 = _GEN_49 >= _T_20 & change | _GEN_6; // @[intervox_receiver.scala 230:66 237:22]
  wire [63:0] _leds_T = {{48'd0}, BFR_io_dataOut[63:48]}; // @[intervox_receiver.scala 248:32]
  wire [63:0] _leds_T_1 = _leds_T & 64'hffff; // @[intervox_receiver.scala 248:41]
  wire [15:0] _GEN_44 = io_BTN_C ? io_SW : {{8'd0}, lastOne}; // @[intervox_receiver.scala 252:31 253:21 111:30]
  wire [63:0] _GEN_45 = io_BTN_C ? {{48'd0}, io_SW} : _leds_T_1; // @[intervox_receiver.scala 248:13 252:31 254:21]
  wire [15:0] _GEN_46 = io_SW > 16'h0 ? _GEN_44 : {{8'd0}, lastOne}; // @[intervox_receiver.scala 251:22 111:30]
  wire [63:0] _GEN_47 = io_SW > 16'h0 ? _GEN_45 : _leds_T_1; // @[intervox_receiver.scala 248:13 251:22]
  wire [15:0] _GEN_54 = reset ? 16'hf : _GEN_46; // @[intervox_receiver.scala 111:{30,30}]
  wire [63:0] _GEN_55 = reset ? 64'h0 : _GEN_47; // @[intervox_receiver.scala 112:{30,30}]
  RWSmem BFR ( // @[intervox_receiver.scala 100:29]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  edgeDetector DATAEDGE ( // @[intervox_receiver.scala 136:38]
    .clock(DATAEDGE_clock),
    .reset(DATAEDGE_reset),
    .io_INPUT(DATAEDGE_io_INPUT),
    .io_RISE(DATAEDGE_io_RISE),
    .io_CHANGE(DATAEDGE_io_CHANGE)
  );
  edgeDetector CLKREC_EDGE ( // @[intervox_receiver.scala 140:41]
    .clock(CLKREC_EDGE_clock),
    .reset(CLKREC_EDGE_reset),
    .io_INPUT(CLKREC_EDGE_io_INPUT),
    .io_RISE(CLKREC_EDGE_io_RISE),
    .io_CHANGE(CLKREC_EDGE_io_CHANGE)
  );
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 127:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 128:21]
  assign io_DBUG = change; // @[intervox_receiver.scala 129:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 130:21]
  assign io_LED = leds; // @[intervox_receiver.scala 131:21]
  assign io_DATAREG = dataReg; // @[intervox_receiver.scala 132:21]
  assign BFR_clock = clock;
  assign BFR_io_write = deltaCntr > _T_4 & _GEN_49 < _T_10 ? _GEN_20 : _GEN_16; // @[intervox_receiver.scala 195:74]
  assign BFR_io_dataIn = _GEN_26[63:0];
  assign DATAEDGE_clock = clock;
  assign DATAEDGE_reset = reset;
  assign DATAEDGE_io_INPUT = io_DATA_IN; // @[intervox_receiver.scala 137:29]
  assign CLKREC_EDGE_clock = clock;
  assign CLKREC_EDGE_reset = reset;
  assign CLKREC_EDGE_io_INPUT = clkRec; // @[intervox_receiver.scala 141:32]
  always @(posedge clock) begin
    lastOne <= _GEN_54[7:0]; // @[intervox_receiver.scala 111:{30,30}]
    leds <= _GEN_55[15:0]; // @[intervox_receiver.scala 112:{30,30}]
    if (reset) begin // @[intervox_receiver.scala 115:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 115:30]
    end else if (change) begin // @[intervox_receiver.scala 146:25]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 152:25]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 134:18]
    end
    if (reset) begin // @[intervox_receiver.scala 116:30]
      bitCntr <= 7'h0; // @[intervox_receiver.scala 116:30]
    end else if (~change) begin // @[intervox_receiver.scala 215:25]
      if (_GEN_49 >= _T_20 & change) begin // @[intervox_receiver.scala 230:66]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 238:39]
          bitCntr <= 7'h0; // @[intervox_receiver.scala 243:25]
        end else begin
          bitCntr <= _GEN_11;
        end
      end else begin
        bitCntr <= _GEN_11;
      end
    end else begin
      bitCntr <= _GEN_11;
    end
    if (reset) begin // @[intervox_receiver.scala 117:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 117:30]
    end else if (~change) begin // @[intervox_receiver.scala 215:25]
      if (_GEN_49 >= _T_20 & change) begin // @[intervox_receiver.scala 230:66]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 238:39]
          clkRec <= _clkRec_T; // @[intervox_receiver.scala 240:24]
        end else begin
          clkRec <= _GEN_30;
        end
      end else begin
        clkRec <= _GEN_30;
      end
    end else begin
      clkRec <= _GEN_23;
    end
    if (reset) begin // @[intervox_receiver.scala 118:30]
      change <= 1'h0; // @[intervox_receiver.scala 118:30]
    end else if (change) begin // @[intervox_receiver.scala 146:25]
      change <= 1'h0; // @[intervox_receiver.scala 148:16]
    end else begin
      change <= DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 138:29]
    end
    if (reset) begin // @[intervox_receiver.scala 119:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 119:30]
    end else if (deltaCntr > _T_4 & _GEN_49 < _T_10) begin // @[intervox_receiver.scala 195:74]
      if (~zeroFlipped) begin // @[intervox_receiver.scala 198:34]
        dataOut <= 1'h0; // @[intervox_receiver.scala 207:21]
      end else begin
        dataOut <= _GEN_15;
      end
    end else begin
      dataOut <= _GEN_15;
    end
    if (reset) begin // @[intervox_receiver.scala 120:30]
      dataReg <= 64'h0; // @[intervox_receiver.scala 120:30]
    end else if (syncWord) begin // @[intervox_receiver.scala 159:27]
      dataReg <= BFR_io_dataOut; // @[intervox_receiver.scala 162:21]
    end
    if (reset) begin // @[intervox_receiver.scala 121:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 121:30]
    end else if (~change) begin // @[intervox_receiver.scala 215:25]
      syncWord <= _GEN_35;
    end else if (syncWord) begin // @[intervox_receiver.scala 159:27]
      syncWord <= 1'h0; // @[intervox_receiver.scala 160:21]
    end
    if (reset) begin // @[intervox_receiver.scala 122:30]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 122:30]
    end else if (deltaCntr > _T_4 & _GEN_49 < _T_10) begin // @[intervox_receiver.scala 195:74]
      zeroFlipped <= _GEN_19;
    end else if (change) begin // @[intervox_receiver.scala 146:25]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 154:25]
    end
    if (reset) begin // @[intervox_receiver.scala 123:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 123:30]
    end else if (~change) begin // @[intervox_receiver.scala 215:25]
      if (_GEN_49 >= _T_17) begin // @[intervox_receiver.scala 217:53]
        syncFlipped <= _GEN_29;
      end else begin
        syncFlipped <= _GEN_4;
      end
    end else begin
      syncFlipped <= _GEN_4;
    end
    if (reset) begin // @[intervox_receiver.scala 124:30]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 124:30]
    end else if (~change) begin // @[intervox_receiver.scala 215:25]
      if (_GEN_49 >= _T_20 & change) begin // @[intervox_receiver.scala 230:66]
        syncFlipped1 <= _GEN_33;
      end else begin
        syncFlipped1 <= _GEN_5;
      end
    end else begin
      syncFlipped1 <= _GEN_5;
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
  lastOne = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  leds = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  deltaCntr = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  bitCntr = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  clkRec = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  change = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  dataOut = _RAND_6[0:0];
  _RAND_7 = {2{`RANDOM}};
  dataReg = _RAND_7[63:0];
  _RAND_8 = {1{`RANDOM}};
  syncWord = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  zeroFlipped = _RAND_9[0:0];
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
  wire  BCLKEDGE_clock; // @[intervox_receiver.scala 281:37]
  wire  BCLKEDGE_reset; // @[intervox_receiver.scala 281:37]
  wire  BCLKEDGE_io_INPUT; // @[intervox_receiver.scala 281:37]
  wire  BCLKEDGE_io_RISE; // @[intervox_receiver.scala 281:37]
  wire  BCLKEDGE_io_CHANGE; // @[intervox_receiver.scala 281:37]
  reg [7:0] bitCntr; // @[intervox_receiver.scala 269:26]
  reg  lrclk; // @[intervox_receiver.scala 270:26]
  reg  dlay; // @[intervox_receiver.scala 271:26]
  reg  sdataO; // @[intervox_receiver.scala 273:26]
  reg [63:0] sdata; // @[intervox_receiver.scala 274:26]
  wire [7:0] _GEN_0 = io_NEXT ? 8'h0 : bitCntr; // @[intervox_receiver.scala 284:26 285:17 269:26]
  wire [7:0] _GEN_1 = bitCntr >= 8'h40 ? 8'h0 : _GEN_0; // @[intervox_receiver.scala 288:26 289:17]
  wire  _GEN_2 = bitCntr == 8'h0 | lrclk; // @[intervox_receiver.scala 294:30 295:19 270:26]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_receiver.scala 302:32]
  wire [7:0] _sdataO_T_1 = 8'h3e - bitCntr; // @[intervox_receiver.scala 307:48]
  wire [63:0] _sdataO_T_2 = sdata >> _sdataO_T_1; // @[intervox_receiver.scala 307:42]
  wire  _GEN_4 = bitCntr <= 8'h18 & _sdataO_T_2[0]; // @[intervox_receiver.scala 306:38 307:28 309:28]
  wire  _GEN_5 = bitCntr <= 8'h1f ? _GEN_4 : sdataO; // @[intervox_receiver.scala 273:26 304:36]
  wire [7:0] _sdataO_T_6 = bitCntr - 8'h1f; // @[intervox_receiver.scala 317:59]
  wire [7:0] _sdataO_T_8 = 8'h26 - _sdataO_T_6; // @[intervox_receiver.scala 317:48]
  wire [63:0] _sdataO_T_9 = sdata >> _sdataO_T_8; // @[intervox_receiver.scala 317:42]
  wire  _GEN_6 = bitCntr <= 8'h38 & _sdataO_T_9[0]; // @[intervox_receiver.scala 316:38 317:28 319:28]
  wire  _GEN_13 = BCLKEDGE_io_RISE | dlay; // @[intervox_receiver.scala 293:35 298:14 271:26]
  edgeDetector BCLKEDGE ( // @[intervox_receiver.scala 281:37]
    .clock(BCLKEDGE_clock),
    .reset(BCLKEDGE_reset),
    .io_INPUT(BCLKEDGE_io_INPUT),
    .io_RISE(BCLKEDGE_io_RISE),
    .io_CHANGE(BCLKEDGE_io_CHANGE)
  );
  assign io_BCLK = io_CLK_IN; // @[intervox_receiver.scala 277:17]
  assign io_LRCLK = lrclk; // @[intervox_receiver.scala 278:17]
  assign io_SDATA = sdataO; // @[intervox_receiver.scala 279:17]
  assign BCLKEDGE_clock = clock;
  assign BCLKEDGE_reset = reset;
  assign BCLKEDGE_io_INPUT = io_CLK_IN; // @[intervox_receiver.scala 282:33]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 269:26]
      bitCntr <= 8'h0; // @[intervox_receiver.scala 269:26]
    end else if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 293:35]
      if (dlay) begin // @[intervox_receiver.scala 300:27]
        bitCntr <= _bitCntr_T_1; // @[intervox_receiver.scala 302:21]
      end else begin
        bitCntr <= _GEN_1;
      end
    end else begin
      bitCntr <= _GEN_1;
    end
    if (reset) begin // @[intervox_receiver.scala 270:26]
      lrclk <= 1'h0; // @[intervox_receiver.scala 270:26]
    end else if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 293:35]
      if (dlay) begin // @[intervox_receiver.scala 300:27]
        if (bitCntr > 8'h1f) begin // @[intervox_receiver.scala 313:33]
          lrclk <= 1'h0; // @[intervox_receiver.scala 314:23]
        end else begin
          lrclk <= _GEN_2;
        end
      end else begin
        lrclk <= _GEN_2;
      end
    end
    if (reset) begin // @[intervox_receiver.scala 271:26]
      dlay <= 1'h0; // @[intervox_receiver.scala 271:26]
    end else begin
      dlay <= _GEN_13;
    end
    if (reset) begin // @[intervox_receiver.scala 273:26]
      sdataO <= 1'h0; // @[intervox_receiver.scala 273:26]
    end else if (BCLKEDGE_io_RISE) begin // @[intervox_receiver.scala 293:35]
      if (dlay) begin // @[intervox_receiver.scala 300:27]
        if (bitCntr > 8'h1f) begin // @[intervox_receiver.scala 313:33]
          sdataO <= _GEN_6;
        end else begin
          sdataO <= _GEN_5;
        end
      end
    end
    if (reset) begin // @[intervox_receiver.scala 274:26]
      sdata <= 64'h0; // @[intervox_receiver.scala 274:26]
    end else begin
      sdata <= io_DATA_IN; // @[intervox_receiver.scala 276:17]
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
  bitCntr = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  lrclk = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dlay = _RAND_2[0:0];
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
module interVox_Receiver(
  input         clock,
  input         reset,
  input         io_INTERVOX_IN,
  output        io_CLK_REC,
  output        io_DATA_OUT,
  output        io_CLK_DBUG,
  output        io_DBUG,
  output        io_DBUG1,
  output [15:0] io_LED,
  input  [15:0] io_SW,
  output        io_BCLK,
  output        io_LRCLK,
  output        io_SDATA,
  input         io_BTN_C,
  input         io_BTN_D,
  input         io_BTN_L,
  input         io_BTN_R
);
  wire  clockRec_clock; // @[intervox_receiver.scala 346:29]
  wire  clockRec_reset; // @[intervox_receiver.scala 346:29]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 346:29]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 346:29]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 346:29]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 346:29]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 346:29]
  wire [15:0] clockRec_io_LED; // @[intervox_receiver.scala 346:29]
  wire [15:0] clockRec_io_SW; // @[intervox_receiver.scala 346:29]
  wire [63:0] clockRec_io_DATAREG; // @[intervox_receiver.scala 346:29]
  wire  clockRec_io_BTN_C; // @[intervox_receiver.scala 346:29]
  wire  i2sTrans_clock; // @[intervox_receiver.scala 357:29]
  wire  i2sTrans_reset; // @[intervox_receiver.scala 357:29]
  wire  i2sTrans_io_CLK_IN; // @[intervox_receiver.scala 357:29]
  wire [63:0] i2sTrans_io_DATA_IN; // @[intervox_receiver.scala 357:29]
  wire  i2sTrans_io_NEXT; // @[intervox_receiver.scala 357:29]
  wire  i2sTrans_io_BCLK; // @[intervox_receiver.scala 357:29]
  wire  i2sTrans_io_LRCLK; // @[intervox_receiver.scala 357:29]
  wire  i2sTrans_io_SDATA; // @[intervox_receiver.scala 357:29]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 346:29]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1),
    .io_LED(clockRec_io_LED),
    .io_SW(clockRec_io_SW),
    .io_DATAREG(clockRec_io_DATAREG),
    .io_BTN_C(clockRec_io_BTN_C)
  );
  i2s_Transmitter i2sTrans ( // @[intervox_receiver.scala 357:29]
    .clock(i2sTrans_clock),
    .reset(i2sTrans_reset),
    .io_CLK_IN(i2sTrans_io_CLK_IN),
    .io_DATA_IN(i2sTrans_io_DATA_IN),
    .io_NEXT(i2sTrans_io_NEXT),
    .io_BCLK(i2sTrans_io_BCLK),
    .io_LRCLK(i2sTrans_io_LRCLK),
    .io_SDATA(i2sTrans_io_SDATA)
  );
  assign io_CLK_REC = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 353:21]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 351:21]
  assign io_CLK_DBUG = 1'h0; // @[intervox_receiver.scala 352:21]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 355:21]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 354:21]
  assign io_LED = clockRec_io_LED; // @[intervox_receiver.scala 350:21]
  assign io_BCLK = i2sTrans_io_BCLK; // @[intervox_receiver.scala 361:21]
  assign io_LRCLK = i2sTrans_io_LRCLK; // @[intervox_receiver.scala 363:21]
  assign io_SDATA = i2sTrans_io_SDATA; // @[intervox_receiver.scala 362:21]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 347:29]
  assign clockRec_io_SW = io_SW; // @[intervox_receiver.scala 348:29]
  assign clockRec_io_BTN_C = io_BTN_C; // @[intervox_receiver.scala 349:29]
  assign i2sTrans_clock = clock;
  assign i2sTrans_reset = reset;
  assign i2sTrans_io_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 358:29]
  assign i2sTrans_io_DATA_IN = clockRec_io_DATAREG; // @[intervox_receiver.scala 359:29]
  assign i2sTrans_io_NEXT = clockRec_io_DBUG1; // @[intervox_receiver.scala 360:29]
endmodule
