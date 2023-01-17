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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inBufr; // @[intervox_receiver.scala 12:34]
  reg [1:0] inBufrPrev; // @[intervox_receiver.scala 13:34]
  reg  rising; // @[intervox_receiver.scala 15:34]
  reg  change; // @[intervox_receiver.scala 16:34]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_receiver.scala 26:35]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_receiver.scala 33:35]
  wire  _GEN_8 = inBufr[0] ^ inBufr[1] | change; // @[intervox_receiver.scala 39:36 40:17 16:34]
  wire  _T_8 = inBufr == 2'h1; // @[intervox_receiver.scala 43:41]
  wire  _GEN_10 = inBufrPrev == 2'h0 & inBufr == 2'h1 | rising; // @[intervox_receiver.scala 43:50 45:17 15:34]
  wire  _GEN_11 = inBufrPrev == 2'h0 & inBufr == 2'h1 | _GEN_8; // @[intervox_receiver.scala 43:50 46:17]
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
  rising = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  change = _RAND_3[0:0];
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
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  BFR_clock; // @[intervox_receiver.scala 101:29]
  wire  BFR_io_write; // @[intervox_receiver.scala 101:29]
  wire [63:0] BFR_io_dataIn; // @[intervox_receiver.scala 101:29]
  wire [63:0] BFR_io_dataOut; // @[intervox_receiver.scala 101:29]
  wire  BFR1_clock; // @[intervox_receiver.scala 106:30]
  wire  BFR1_io_write; // @[intervox_receiver.scala 106:30]
  wire [63:0] BFR1_io_dataIn; // @[intervox_receiver.scala 106:30]
  wire [63:0] BFR1_io_dataOut; // @[intervox_receiver.scala 106:30]
  wire  DATAEDGE_clock; // @[intervox_receiver.scala 138:38]
  wire  DATAEDGE_reset; // @[intervox_receiver.scala 138:38]
  wire  DATAEDGE_io_INPUT; // @[intervox_receiver.scala 138:38]
  wire  DATAEDGE_io_RISE; // @[intervox_receiver.scala 138:38]
  wire  DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 138:38]
  wire  CLKEDGE_clock; // @[intervox_receiver.scala 140:37]
  wire  CLKEDGE_reset; // @[intervox_receiver.scala 140:37]
  wire  CLKEDGE_io_INPUT; // @[intervox_receiver.scala 140:37]
  wire  CLKEDGE_io_RISE; // @[intervox_receiver.scala 140:37]
  wire  CLKEDGE_io_CHANGE; // @[intervox_receiver.scala 140:37]
  reg [7:0] lastOne; // @[intervox_receiver.scala 116:30]
  reg [15:0] leds; // @[intervox_receiver.scala 117:30]
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 120:30]
  reg [6:0] bitCntr; // @[intervox_receiver.scala 121:30]
  reg  clkRec; // @[intervox_receiver.scala 122:30]
  reg  dataOut; // @[intervox_receiver.scala 124:30]
  reg  syncWord; // @[intervox_receiver.scala 125:30]
  reg  zeroFlipped; // @[intervox_receiver.scala 126:30]
  reg  syncFlipped; // @[intervox_receiver.scala 127:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 128:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 136:31]
  wire  _T = DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 150:29]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 152:28]
  wire  _GEN_0 = DATAEDGE_io_CHANGE ? ~clkRec : clkRec; // @[intervox_receiver.scala 150:37 152:25 122:30]
  wire  _GEN_2 = DATAEDGE_io_CHANGE ? 1'h0 : zeroFlipped; // @[intervox_receiver.scala 150:37 156:25 126:30]
  wire  _GEN_3 = DATAEDGE_io_CHANGE ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 150:37 157:25 127:30]
  wire  _GEN_4 = DATAEDGE_io_CHANGE ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 150:37 158:25 128:30]
  wire  _GEN_5 = syncWord ? 1'h0 : syncWord; // @[intervox_receiver.scala 161:27 162:21 125:30]
  wire [6:0] _GEN_6 = syncWord ? 7'h0 : bitCntr; // @[intervox_receiver.scala 161:27 163:21 121:30]
  wire [6:0] _bitCntr_T_1 = bitCntr + 7'h1; // @[intervox_receiver.scala 170:28]
  wire [6:0] _BFR_io_dataIn_T_1 = 7'h3f - bitCntr; // @[intervox_receiver.scala 174:65]
  wire [127:0] _BFR_io_dataIn_T_2 = 128'h1 << _BFR_io_dataIn_T_1; // @[intervox_receiver.scala 174:56]
  wire [127:0] _GEN_49 = {{64'd0}, BFR_io_dataOut}; // @[intervox_receiver.scala 174:49]
  wire [127:0] _BFR_io_dataIn_T_3 = _GEN_49 | _BFR_io_dataIn_T_2; // @[intervox_receiver.scala 174:49]
  wire [127:0] _BFR_io_dataIn_T_6 = 128'h0 << _BFR_io_dataIn_T_1; // @[intervox_receiver.scala 176:56]
  wire [127:0] _BFR_io_dataIn_T_7 = _GEN_49 & _BFR_io_dataIn_T_6; // @[intervox_receiver.scala 176:49]
  wire [127:0] _GEN_9 = dataOut ? _BFR_io_dataIn_T_3 : _BFR_io_dataIn_T_7; // @[intervox_receiver.scala 173:30 174:31 176:31]
  wire [6:0] _GEN_10 = CLKEDGE_io_RISE ? _bitCntr_T_1 : _GEN_6; // @[intervox_receiver.scala 169:34 170:17]
  wire [127:0] _GEN_12 = CLKEDGE_io_RISE ? _GEN_9 : 128'h0; // @[intervox_receiver.scala 169:34]
  wire  _GEN_13 = _T | dataOut; // @[intervox_receiver.scala 187:41 190:21 124:30]
  wire [9:0] _T_7 = lastOne * 2'h2; // @[intervox_receiver.scala 197:59]
  wire [9:0] _GEN_51 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 197:47]
  wire  _GEN_15 = ~zeroFlipped ? _clkRec_T : _GEN_0; // @[intervox_receiver.scala 203:34 206:20]
  wire  _GEN_16 = ~zeroFlipped | _GEN_2; // @[intervox_receiver.scala 203:34 207:25]
  wire  _GEN_18 = deltaCntr > lastOne & _GEN_51 < _T_7 ? _GEN_15 : _GEN_0; // @[intervox_receiver.scala 197:68]
  wire  _GEN_20 = ~syncFlipped ? _clkRec_T : _GEN_18; // @[intervox_receiver.scala 224:38 226:24]
  wire  _GEN_21 = ~syncFlipped | _GEN_3; // @[intervox_receiver.scala 224:38 227:29]
  wire  _GEN_22 = _GEN_51 >= _T_7 ? _GEN_20 : _GEN_18; // @[intervox_receiver.scala 217:47]
  wire [9:0] _T_15 = lastOne * 2'h3; // @[intervox_receiver.scala 230:38]
  wire  _T_19 = ~syncFlipped1; // @[intervox_receiver.scala 238:31]
  wire [63:0] _leds_T = {{46'd0}, BFR1_io_dataOut[63:46]}; // @[intervox_receiver.scala 249:45]
  wire [63:0] _leds_T_1 = _leds_T & 64'hffff; // @[intervox_receiver.scala 249:54]
  wire  _GEN_25 = ~syncFlipped1 | _GEN_4; // @[intervox_receiver.scala 238:39 241:30]
  wire [63:0] _GEN_28 = ~syncFlipped1 ? BFR_io_dataOut : 64'h0; // @[intervox_receiver.scala 110:28 238:39 247:33]
  wire [63:0] _GEN_29 = ~syncFlipped1 ? _leds_T_1 : {{48'd0}, leds}; // @[intervox_receiver.scala 238:39 249:25 117:30]
  wire  _GEN_30 = _GEN_51 >= _T_15 & _T | _GEN_5; // @[intervox_receiver.scala 230:78 237:22]
  wire  _GEN_34 = _GEN_51 >= _T_15 & _T & _T_19; // @[intervox_receiver.scala 109:28 230:78]
  wire [63:0] _GEN_35 = _GEN_51 >= _T_15 & _T ? _GEN_28 : 64'h0; // @[intervox_receiver.scala 110:28 230:78]
  wire [63:0] _GEN_36 = _GEN_51 >= _T_15 & _T ? _GEN_29 : {{48'd0}, leds}; // @[intervox_receiver.scala 117:30 230:78]
  wire [63:0] _GEN_44 = ~DATAEDGE_io_CHANGE ? _GEN_36 : {{48'd0}, leds}; // @[intervox_receiver.scala 117:30 215:37]
  wire [15:0] _GEN_45 = io_BTN_C ? io_SW : {{8'd0}, lastOne}; // @[intervox_receiver.scala 256:31 257:21 116:30]
  wire [63:0] _GEN_46 = io_BTN_C ? {{48'd0}, io_SW} : _GEN_44; // @[intervox_receiver.scala 256:31 258:21]
  wire [15:0] _GEN_47 = io_SW > 16'h0 ? _GEN_45 : {{8'd0}, lastOne}; // @[intervox_receiver.scala 255:22 116:30]
  wire [63:0] _GEN_48 = io_SW > 16'h0 ? _GEN_46 : _GEN_44; // @[intervox_receiver.scala 255:22]
  wire [15:0] _GEN_55 = reset ? 16'hf : _GEN_47; // @[intervox_receiver.scala 116:{30,30}]
  wire [63:0] _GEN_56 = reset ? 64'h0 : _GEN_48; // @[intervox_receiver.scala 117:{30,30}]
  RWSmem BFR ( // @[intervox_receiver.scala 101:29]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_receiver.scala 106:30]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  edgeDetector DATAEDGE ( // @[intervox_receiver.scala 138:38]
    .clock(DATAEDGE_clock),
    .reset(DATAEDGE_reset),
    .io_INPUT(DATAEDGE_io_INPUT),
    .io_RISE(DATAEDGE_io_RISE),
    .io_CHANGE(DATAEDGE_io_CHANGE)
  );
  edgeDetector CLKEDGE ( // @[intervox_receiver.scala 140:37]
    .clock(CLKEDGE_clock),
    .reset(CLKEDGE_reset),
    .io_INPUT(CLKEDGE_io_INPUT),
    .io_RISE(CLKEDGE_io_RISE),
    .io_CHANGE(CLKEDGE_io_CHANGE)
  );
  assign io_CLK_OUT = CLKEDGE_io_RISE; // @[intervox_receiver.scala 143:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 132:21]
  assign io_DBUG = DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 145:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 133:21]
  assign io_LED = leds; // @[intervox_receiver.scala 134:21]
  assign io_DATAREG = BFR1_io_dataOut; // @[intervox_receiver.scala 144:21]
  assign BFR_clock = clock;
  assign BFR_io_write = CLKEDGE_io_RISE | syncWord; // @[intervox_receiver.scala 169:34 172:27]
  assign BFR_io_dataIn = _GEN_12[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = ~DATAEDGE_io_CHANGE & _GEN_34; // @[intervox_receiver.scala 109:28 215:37]
  assign BFR1_io_dataIn = ~DATAEDGE_io_CHANGE ? _GEN_35 : 64'h0; // @[intervox_receiver.scala 110:28 215:37]
  assign DATAEDGE_clock = clock;
  assign DATAEDGE_reset = reset;
  assign DATAEDGE_io_INPUT = io_DATA_IN; // @[intervox_receiver.scala 139:29]
  assign CLKEDGE_clock = clock;
  assign CLKEDGE_reset = reset;
  assign CLKEDGE_io_INPUT = clkRec; // @[intervox_receiver.scala 141:29]
  always @(posedge clock) begin
    lastOne <= _GEN_55[7:0]; // @[intervox_receiver.scala 116:{30,30}]
    leds <= _GEN_56[15:0]; // @[intervox_receiver.scala 117:{30,30}]
    if (reset) begin // @[intervox_receiver.scala 120:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 120:30]
    end else if (DATAEDGE_io_CHANGE) begin // @[intervox_receiver.scala 150:37]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 154:25]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 136:18]
    end
    if (reset) begin // @[intervox_receiver.scala 121:30]
      bitCntr <= 7'h0; // @[intervox_receiver.scala 121:30]
    end else if (~DATAEDGE_io_CHANGE) begin // @[intervox_receiver.scala 215:37]
      if (_GEN_51 >= _T_15 & _T) begin // @[intervox_receiver.scala 230:78]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 238:39]
          bitCntr <= 7'h0; // @[intervox_receiver.scala 243:25]
        end else begin
          bitCntr <= _GEN_10;
        end
      end else begin
        bitCntr <= _GEN_10;
      end
    end else begin
      bitCntr <= _GEN_10;
    end
    if (reset) begin // @[intervox_receiver.scala 122:30]
      clkRec <= 1'h0; // @[intervox_receiver.scala 122:30]
    end else if (~DATAEDGE_io_CHANGE) begin // @[intervox_receiver.scala 215:37]
      if (_GEN_51 >= _T_15 & _T) begin // @[intervox_receiver.scala 230:78]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 238:39]
          clkRec <= _clkRec_T; // @[intervox_receiver.scala 240:24]
        end else begin
          clkRec <= _GEN_22;
        end
      end else begin
        clkRec <= _GEN_22;
      end
    end else begin
      clkRec <= _GEN_18;
    end
    if (reset) begin // @[intervox_receiver.scala 124:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 124:30]
    end else if (deltaCntr > lastOne & _GEN_51 < _T_7) begin // @[intervox_receiver.scala 197:68]
      dataOut <= 1'h0; // @[intervox_receiver.scala 201:17]
    end else if (deltaCntr <= lastOne) begin // @[intervox_receiver.scala 184:35]
      dataOut <= _GEN_13;
    end
    if (reset) begin // @[intervox_receiver.scala 125:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 125:30]
    end else if (~DATAEDGE_io_CHANGE) begin // @[intervox_receiver.scala 215:37]
      syncWord <= _GEN_30;
    end else if (syncWord) begin // @[intervox_receiver.scala 161:27]
      syncWord <= 1'h0; // @[intervox_receiver.scala 162:21]
    end
    if (reset) begin // @[intervox_receiver.scala 126:30]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 126:30]
    end else if (deltaCntr > lastOne & _GEN_51 < _T_7) begin // @[intervox_receiver.scala 197:68]
      zeroFlipped <= _GEN_16;
    end else if (DATAEDGE_io_CHANGE) begin // @[intervox_receiver.scala 150:37]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 156:25]
    end
    if (reset) begin // @[intervox_receiver.scala 127:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 127:30]
    end else if (~DATAEDGE_io_CHANGE) begin // @[intervox_receiver.scala 215:37]
      if (_GEN_51 >= _T_7) begin // @[intervox_receiver.scala 217:47]
        syncFlipped <= _GEN_21;
      end else begin
        syncFlipped <= _GEN_3;
      end
    end else begin
      syncFlipped <= _GEN_3;
    end
    if (reset) begin // @[intervox_receiver.scala 128:30]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 128:30]
    end else if (~DATAEDGE_io_CHANGE) begin // @[intervox_receiver.scala 215:37]
      if (_GEN_51 >= _T_15 & _T) begin // @[intervox_receiver.scala 230:78]
        syncFlipped1 <= _GEN_25;
      end else begin
        syncFlipped1 <= _GEN_4;
      end
    end else begin
      syncFlipped1 <= _GEN_4;
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
  dataOut = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  syncWord = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  zeroFlipped = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  syncFlipped = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  syncFlipped1 = _RAND_9[0:0];
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
  output        io_LRCLK,
  output        io_SDATA
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] bitCntrTrans; // @[intervox_receiver.scala 272:31]
  reg  lrclk; // @[intervox_receiver.scala 273:26]
  reg  sdataO; // @[intervox_receiver.scala 274:26]
  wire [7:0] _bitCntrTrans_T_1 = bitCntrTrans + 8'h1; // @[intervox_receiver.scala 286:38]
  wire  _GEN_1 = bitCntrTrans == 8'h0 | lrclk; // @[intervox_receiver.scala 288:35 290:19 273:26]
  wire  _T_3 = bitCntrTrans > 8'h1f; // @[intervox_receiver.scala 292:27]
  wire [7:0] _sdataO_T_1 = 8'h3c - bitCntrTrans; // @[intervox_receiver.scala 298:45]
  wire [63:0] _sdataO_T_2 = io_DATA_IN >> _sdataO_T_1; // @[intervox_receiver.scala 298:39]
  wire  _GEN_3 = bitCntrTrans <= 8'h18 ? _sdataO_T_2[0] : sdataO; // @[intervox_receiver.scala 296:37 298:20 274:26]
  wire  _GEN_4 = bitCntrTrans > 8'h18 & bitCntrTrans <= 8'h1f ? 1'h0 : _GEN_3; // @[intervox_receiver.scala 300:61 302:20]
  wire [7:0] _sdataO_T_6 = bitCntrTrans + 8'h1f; // @[intervox_receiver.scala 306:61]
  wire [7:0] _sdataO_T_8 = 8'h24 - _sdataO_T_6; // @[intervox_receiver.scala 306:45]
  wire [63:0] _sdataO_T_9 = io_DATA_IN >> _sdataO_T_8; // @[intervox_receiver.scala 306:39]
  assign io_LRCLK = lrclk; // @[intervox_receiver.scala 276:17]
  assign io_SDATA = sdataO; // @[intervox_receiver.scala 277:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 272:31]
      bitCntrTrans <= 8'h0; // @[intervox_receiver.scala 272:31]
    end else if (io_CLK_IN) begin // @[intervox_receiver.scala 284:28]
      bitCntrTrans <= _bitCntrTrans_T_1; // @[intervox_receiver.scala 286:22]
    end else if (io_NEXT) begin // @[intervox_receiver.scala 280:26]
      bitCntrTrans <= 8'h0; // @[intervox_receiver.scala 281:22]
    end
    if (reset) begin // @[intervox_receiver.scala 273:26]
      lrclk <= 1'h0; // @[intervox_receiver.scala 273:26]
    end else if (io_CLK_IN) begin // @[intervox_receiver.scala 284:28]
      if (bitCntrTrans > 8'h1f) begin // @[intervox_receiver.scala 292:34]
        lrclk <= 1'h0; // @[intervox_receiver.scala 294:19]
      end else begin
        lrclk <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_receiver.scala 274:26]
      sdataO <= 1'h0; // @[intervox_receiver.scala 274:26]
    end else if (io_CLK_IN) begin // @[intervox_receiver.scala 284:28]
      if (bitCntrTrans > 8'h38) begin // @[intervox_receiver.scala 308:36]
        sdataO <= 1'h0; // @[intervox_receiver.scala 310:20]
      end else if (bitCntrTrans <= 8'h38 & _T_3) begin // @[intervox_receiver.scala 304:61]
        sdataO <= _sdataO_T_9[0]; // @[intervox_receiver.scala 306:20]
      end else begin
        sdataO <= _GEN_4;
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
  bitCntrTrans = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  lrclk = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sdataO = _RAND_2[0:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 334:29]
  wire  clockRec_reset; // @[intervox_receiver.scala 334:29]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 334:29]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 334:29]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 334:29]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 334:29]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 334:29]
  wire [15:0] clockRec_io_LED; // @[intervox_receiver.scala 334:29]
  wire [15:0] clockRec_io_SW; // @[intervox_receiver.scala 334:29]
  wire [63:0] clockRec_io_DATAREG; // @[intervox_receiver.scala 334:29]
  wire  clockRec_io_BTN_C; // @[intervox_receiver.scala 334:29]
  wire  i2sTrans_clock; // @[intervox_receiver.scala 345:29]
  wire  i2sTrans_reset; // @[intervox_receiver.scala 345:29]
  wire  i2sTrans_io_CLK_IN; // @[intervox_receiver.scala 345:29]
  wire [63:0] i2sTrans_io_DATA_IN; // @[intervox_receiver.scala 345:29]
  wire  i2sTrans_io_NEXT; // @[intervox_receiver.scala 345:29]
  wire  i2sTrans_io_LRCLK; // @[intervox_receiver.scala 345:29]
  wire  i2sTrans_io_SDATA; // @[intervox_receiver.scala 345:29]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 334:29]
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
  i2s_Transmitter i2sTrans ( // @[intervox_receiver.scala 345:29]
    .clock(i2sTrans_clock),
    .reset(i2sTrans_reset),
    .io_CLK_IN(i2sTrans_io_CLK_IN),
    .io_DATA_IN(i2sTrans_io_DATA_IN),
    .io_NEXT(i2sTrans_io_NEXT),
    .io_LRCLK(i2sTrans_io_LRCLK),
    .io_SDATA(i2sTrans_io_SDATA)
  );
  assign io_CLK_REC = 1'h0; // @[intervox_receiver.scala 341:21]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 339:21]
  assign io_CLK_DBUG = 1'h0; // @[intervox_receiver.scala 340:21]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 343:21]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 342:21]
  assign io_LED = clockRec_io_LED; // @[intervox_receiver.scala 338:21]
  assign io_BCLK = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 349:21]
  assign io_LRCLK = i2sTrans_io_LRCLK; // @[intervox_receiver.scala 351:21]
  assign io_SDATA = i2sTrans_io_SDATA; // @[intervox_receiver.scala 350:21]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 335:29]
  assign clockRec_io_SW = io_SW; // @[intervox_receiver.scala 336:29]
  assign clockRec_io_BTN_C = io_BTN_C; // @[intervox_receiver.scala 337:29]
  assign i2sTrans_clock = clock;
  assign i2sTrans_reset = reset;
  assign i2sTrans_io_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 346:29]
  assign i2sTrans_io_DATA_IN = clockRec_io_DATAREG; // @[intervox_receiver.scala 347:29]
  assign i2sTrans_io_NEXT = clockRec_io_DBUG1; // @[intervox_receiver.scala 348:29]
endmodule
