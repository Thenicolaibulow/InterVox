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
  output  io_CHANGE
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inBufr; // @[intervox_receiver.scala 12:34]
  reg [1:0] inBufrPrev; // @[intervox_receiver.scala 13:34]
  reg  change; // @[intervox_receiver.scala 16:34]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_receiver.scala 26:35]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_receiver.scala 33:35]
  wire  _GEN_8 = inBufr[0] ^ inBufr[1] | change; // @[intervox_receiver.scala 39:36 40:17 16:34]
  wire  _T_8 = inBufr == 2'h1; // @[intervox_receiver.scala 43:41]
  wire  _GEN_11 = inBufrPrev == 2'h0 & inBufr == 2'h1 | _GEN_8; // @[intervox_receiver.scala 43:50 46:17]
  wire  _GEN_14 = inBufrPrev == 2'h2 & _T_8 | _GEN_11; // @[intervox_receiver.scala 49:50 52:17]
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
  change = _RAND_2[0:0];
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
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  wire  BFR_clock; // @[intervox_receiver.scala 101:29]
  wire  BFR_io_write; // @[intervox_receiver.scala 101:29]
  wire [63:0] BFR_io_dataIn; // @[intervox_receiver.scala 101:29]
  wire [63:0] BFR_io_dataOut; // @[intervox_receiver.scala 101:29]
  wire  BFR1_clock; // @[intervox_receiver.scala 106:30]
  wire  BFR1_io_write; // @[intervox_receiver.scala 106:30]
  wire [63:0] BFR1_io_dataIn; // @[intervox_receiver.scala 106:30]
  wire [63:0] BFR1_io_dataOut; // @[intervox_receiver.scala 106:30]
  wire  DATAEDGE_clock; // @[intervox_receiver.scala 141:38]
  wire  DATAEDGE_reset; // @[intervox_receiver.scala 141:38]
  wire  DATAEDGE_io_INPUT; // @[intervox_receiver.scala 141:38]
  wire  DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 141:38]
  reg [7:0] lastOne; // @[intervox_receiver.scala 116:30]
  reg [15:0] leds; // @[intervox_receiver.scala 117:30]
  reg [7:0] deltaCntr; // @[intervox_receiver.scala 120:30]
  reg [6:0] bitCntr; // @[intervox_receiver.scala 121:30]
  reg  clkRec; // @[intervox_receiver.scala 122:30]
  reg  change; // @[intervox_receiver.scala 124:30]
  reg  dataOut; // @[intervox_receiver.scala 125:30]
  reg  syncWord; // @[intervox_receiver.scala 126:30]
  reg  zeroFlipped; // @[intervox_receiver.scala 127:30]
  reg  syncFlipped; // @[intervox_receiver.scala 128:30]
  reg  syncFlipped1; // @[intervox_receiver.scala 129:30]
  wire [7:0] _deltaCntr_T_1 = deltaCntr + 8'h1; // @[intervox_receiver.scala 139:31]
  wire  _clkRec_T = ~clkRec; // @[intervox_receiver.scala 152:28]
  wire  _GEN_1 = change ? ~clkRec : clkRec; // @[intervox_receiver.scala 148:25 152:25 122:30]
  wire  _GEN_3 = change ? 1'h0 : zeroFlipped; // @[intervox_receiver.scala 148:25 156:25 127:30]
  wire  _GEN_4 = change ? 1'h0 : syncFlipped; // @[intervox_receiver.scala 148:25 157:25 128:30]
  wire  _GEN_5 = change ? 1'h0 : syncFlipped1; // @[intervox_receiver.scala 148:25 158:25 129:30]
  wire  _GEN_6 = syncWord ? 1'h0 : syncWord; // @[intervox_receiver.scala 161:27 162:21 126:30]
  wire [6:0] _GEN_7 = syncWord ? 7'h0 : bitCntr; // @[intervox_receiver.scala 161:27 163:21 121:30]
  wire [6:0] _bitCntr_T_1 = bitCntr + 7'h1; // @[intervox_receiver.scala 170:28]
  wire [6:0] _GEN_10 = clkRec ? _bitCntr_T_1 : _GEN_7; // @[intervox_receiver.scala 169:25 170:17]
  wire [6:0] _BFR_io_dataIn_T_1 = 7'h3f - bitCntr; // @[intervox_receiver.scala 186:69]
  wire [127:0] _BFR_io_dataIn_T_2 = 128'h1 << _BFR_io_dataIn_T_1; // @[intervox_receiver.scala 186:60]
  wire [127:0] _GEN_60 = {{64'd0}, BFR_io_dataOut}; // @[intervox_receiver.scala 186:53]
  wire [127:0] _BFR_io_dataIn_T_3 = _GEN_60 | _BFR_io_dataIn_T_2; // @[intervox_receiver.scala 186:53]
  wire  _GEN_15 = change | syncWord; // @[intervox_receiver.scala 180:29]
  wire [127:0] _GEN_16 = change ? _BFR_io_dataIn_T_3 : 128'h0; // @[intervox_receiver.scala 180:29]
  wire  _GEN_17 = change | dataOut; // @[intervox_receiver.scala 180:29 125:30]
  wire  _GEN_18 = deltaCntr <= lastOne ? _GEN_15 : syncWord; // @[intervox_receiver.scala 177:35]
  wire [127:0] _GEN_19 = deltaCntr <= lastOne ? _GEN_16 : 128'h0; // @[intervox_receiver.scala 177:35]
  wire [9:0] _T_7 = lastOne * 2'h2; // @[intervox_receiver.scala 197:59]
  wire [9:0] _GEN_61 = {{2'd0}, deltaCntr}; // @[intervox_receiver.scala 197:47]
  wire [127:0] _BFR_io_dataIn_T_6 = 128'h0 << _BFR_io_dataIn_T_1; // @[intervox_receiver.scala 203:56]
  wire [127:0] _BFR_io_dataIn_T_7 = _GEN_60 & _BFR_io_dataIn_T_6; // @[intervox_receiver.scala 203:49]
  wire  _GEN_24 = ~zeroFlipped ? _clkRec_T : _GEN_1; // @[intervox_receiver.scala 207:34 210:20]
  wire  _GEN_25 = ~zeroFlipped | _GEN_3; // @[intervox_receiver.scala 207:34 211:25]
  wire [127:0] _GEN_27 = deltaCntr > lastOne & _GEN_61 < _T_7 ? _BFR_io_dataIn_T_7 : _GEN_19; // @[intervox_receiver.scala 197:68]
  wire  _GEN_29 = deltaCntr > lastOne & _GEN_61 < _T_7 ? _GEN_24 : _GEN_1; // @[intervox_receiver.scala 197:68]
  wire  _GEN_31 = ~syncFlipped ? _clkRec_T : _GEN_29; // @[intervox_receiver.scala 228:38 230:24]
  wire  _GEN_32 = ~syncFlipped | _GEN_4; // @[intervox_receiver.scala 228:38 231:29]
  wire  _GEN_33 = _GEN_61 >= _T_7 ? _GEN_31 : _GEN_29; // @[intervox_receiver.scala 221:47]
  wire [9:0] _T_16 = lastOne * 2'h3; // @[intervox_receiver.scala 234:38]
  wire  _T_20 = ~syncFlipped1; // @[intervox_receiver.scala 242:31]
  wire [63:0] _leds_T = {{46'd0}, BFR1_io_dataOut[63:46]}; // @[intervox_receiver.scala 253:45]
  wire [63:0] _leds_T_1 = _leds_T & 64'hffff; // @[intervox_receiver.scala 253:54]
  wire  _GEN_36 = ~syncFlipped1 | _GEN_5; // @[intervox_receiver.scala 242:39 245:30]
  wire [63:0] _GEN_39 = ~syncFlipped1 ? BFR_io_dataOut : 64'h0; // @[intervox_receiver.scala 110:28 242:39 251:33]
  wire [63:0] _GEN_40 = ~syncFlipped1 ? _leds_T_1 : {{48'd0}, leds}; // @[intervox_receiver.scala 242:39 253:25 117:30]
  wire  _GEN_41 = _GEN_61 >= _T_16 & change | _GEN_6; // @[intervox_receiver.scala 234:66 241:22]
  wire  _GEN_45 = _GEN_61 >= _T_16 & change & _T_20; // @[intervox_receiver.scala 109:28 234:66]
  wire [63:0] _GEN_46 = _GEN_61 >= _T_16 & change ? _GEN_39 : 64'h0; // @[intervox_receiver.scala 110:28 234:66]
  wire [63:0] _GEN_47 = _GEN_61 >= _T_16 & change ? _GEN_40 : {{48'd0}, leds}; // @[intervox_receiver.scala 117:30 234:66]
  wire [63:0] _GEN_55 = ~change ? _GEN_47 : {{48'd0}, leds}; // @[intervox_receiver.scala 219:25 117:30]
  wire [15:0] _GEN_56 = io_BTN_C ? io_SW : {{8'd0}, lastOne}; // @[intervox_receiver.scala 260:31 261:21 116:30]
  wire [63:0] _GEN_57 = io_BTN_C ? {{48'd0}, io_SW} : _GEN_55; // @[intervox_receiver.scala 260:31 262:21]
  wire [15:0] _GEN_58 = io_SW > 16'h0 ? _GEN_56 : {{8'd0}, lastOne}; // @[intervox_receiver.scala 259:22 116:30]
  wire [63:0] _GEN_59 = io_SW > 16'h0 ? _GEN_57 : _GEN_55; // @[intervox_receiver.scala 259:22]
  wire [15:0] _GEN_66 = reset ? 16'hf : _GEN_58; // @[intervox_receiver.scala 116:{30,30}]
  wire [63:0] _GEN_67 = reset ? 64'h0 : _GEN_59; // @[intervox_receiver.scala 117:{30,30}]
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
  edgeDetector DATAEDGE ( // @[intervox_receiver.scala 141:38]
    .clock(DATAEDGE_clock),
    .reset(DATAEDGE_reset),
    .io_INPUT(DATAEDGE_io_INPUT),
    .io_CHANGE(DATAEDGE_io_CHANGE)
  );
  assign io_CLK_OUT = clkRec; // @[intervox_receiver.scala 132:21]
  assign io_DATA_OUT = dataOut; // @[intervox_receiver.scala 133:21]
  assign io_DBUG = change; // @[intervox_receiver.scala 134:21]
  assign io_DBUG1 = syncWord; // @[intervox_receiver.scala 135:21]
  assign io_LED = leds; // @[intervox_receiver.scala 136:21]
  assign BFR_clock = clock;
  assign BFR_io_write = deltaCntr > lastOne & _GEN_61 < _T_7 | _GEN_18; // @[intervox_receiver.scala 197:68]
  assign BFR_io_dataIn = _GEN_27[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = ~change & _GEN_45; // @[intervox_receiver.scala 219:25 109:28]
  assign BFR1_io_dataIn = ~change ? _GEN_46 : 64'h0; // @[intervox_receiver.scala 219:25 110:28]
  assign DATAEDGE_clock = clock;
  assign DATAEDGE_reset = reset;
  assign DATAEDGE_io_INPUT = io_DATA_IN; // @[intervox_receiver.scala 142:29]
  always @(posedge clock) begin
    lastOne <= _GEN_66[7:0]; // @[intervox_receiver.scala 116:{30,30}]
    leds <= _GEN_67[15:0]; // @[intervox_receiver.scala 117:{30,30}]
    if (reset) begin // @[intervox_receiver.scala 120:30]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 120:30]
    end else if (change) begin // @[intervox_receiver.scala 148:25]
      deltaCntr <= 8'h0; // @[intervox_receiver.scala 154:25]
    end else begin
      deltaCntr <= _deltaCntr_T_1; // @[intervox_receiver.scala 139:18]
    end
    if (reset) begin // @[intervox_receiver.scala 121:30]
      bitCntr <= 7'h0; // @[intervox_receiver.scala 121:30]
    end else if (~change) begin // @[intervox_receiver.scala 219:25]
      if (_GEN_61 >= _T_16 & change) begin // @[intervox_receiver.scala 234:66]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 242:39]
          bitCntr <= 7'h0; // @[intervox_receiver.scala 247:25]
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
    end else if (~change) begin // @[intervox_receiver.scala 219:25]
      if (_GEN_61 >= _T_16 & change) begin // @[intervox_receiver.scala 234:66]
        if (~syncFlipped1) begin // @[intervox_receiver.scala 242:39]
          clkRec <= _clkRec_T; // @[intervox_receiver.scala 244:24]
        end else begin
          clkRec <= _GEN_33;
        end
      end else begin
        clkRec <= _GEN_33;
      end
    end else begin
      clkRec <= _GEN_29;
    end
    if (reset) begin // @[intervox_receiver.scala 124:30]
      change <= 1'h0; // @[intervox_receiver.scala 124:30]
    end else if (change) begin // @[intervox_receiver.scala 148:25]
      change <= 1'h0; // @[intervox_receiver.scala 150:16]
    end else begin
      change <= DATAEDGE_io_CHANGE; // @[intervox_receiver.scala 143:29]
    end
    if (reset) begin // @[intervox_receiver.scala 125:30]
      dataOut <= 1'h0; // @[intervox_receiver.scala 125:30]
    end else if (deltaCntr > lastOne & _GEN_61 < _T_7) begin // @[intervox_receiver.scala 197:68]
      dataOut <= 1'h0;
    end else if (deltaCntr <= lastOne) begin // @[intervox_receiver.scala 177:35]
      dataOut <= _GEN_17;
    end
    if (reset) begin // @[intervox_receiver.scala 126:30]
      syncWord <= 1'h0; // @[intervox_receiver.scala 126:30]
    end else if (~change) begin // @[intervox_receiver.scala 219:25]
      syncWord <= _GEN_41;
    end else if (syncWord) begin // @[intervox_receiver.scala 161:27]
      syncWord <= 1'h0; // @[intervox_receiver.scala 162:21]
    end
    if (reset) begin // @[intervox_receiver.scala 127:30]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 127:30]
    end else if (deltaCntr > lastOne & _GEN_61 < _T_7) begin // @[intervox_receiver.scala 197:68]
      zeroFlipped <= _GEN_25;
    end else if (change) begin // @[intervox_receiver.scala 148:25]
      zeroFlipped <= 1'h0; // @[intervox_receiver.scala 156:25]
    end
    if (reset) begin // @[intervox_receiver.scala 128:30]
      syncFlipped <= 1'h0; // @[intervox_receiver.scala 128:30]
    end else if (~change) begin // @[intervox_receiver.scala 219:25]
      if (_GEN_61 >= _T_7) begin // @[intervox_receiver.scala 221:47]
        syncFlipped <= _GEN_32;
      end else begin
        syncFlipped <= _GEN_4;
      end
    end else begin
      syncFlipped <= _GEN_4;
    end
    if (reset) begin // @[intervox_receiver.scala 129:30]
      syncFlipped1 <= 1'h0; // @[intervox_receiver.scala 129:30]
    end else if (~change) begin // @[intervox_receiver.scala 219:25]
      if (_GEN_61 >= _T_16 & change) begin // @[intervox_receiver.scala 234:66]
        syncFlipped1 <= _GEN_36;
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
  _RAND_7 = {1{`RANDOM}};
  syncWord = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  zeroFlipped = _RAND_8[0:0];
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
module i2s_Transmitter(
  input   clock,
  input   reset,
  input   io_CLK_IN,
  output  io_BCLK,
  output  io_LRCLK,
  output  io_SDATA
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] bitCntr; // @[intervox_receiver.scala 277:26]
  reg  lrclk; // @[intervox_receiver.scala 278:26]
  reg  sdataO; // @[intervox_receiver.scala 279:26]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_receiver.scala 297:28]
  wire  _GEN_1 = bitCntr == 8'h0 | lrclk; // @[intervox_receiver.scala 299:30 301:19 278:26]
  wire  _T_3 = bitCntr > 8'h1f; // @[intervox_receiver.scala 303:22]
  wire  _GEN_3 = bitCntr <= 8'h18 | sdataO; // @[intervox_receiver.scala 307:32 309:20 279:26]
  wire  _GEN_4 = bitCntr > 8'h18 & bitCntr <= 8'h1f ? 1'h0 : _GEN_3; // @[intervox_receiver.scala 311:51 313:20]
  wire  _GEN_5 = bitCntr <= 8'h38 & _T_3 | _GEN_4; // @[intervox_receiver.scala 315:51 317:20]
  assign io_BCLK = io_CLK_IN; // @[intervox_receiver.scala 285:17]
  assign io_LRCLK = lrclk; // @[intervox_receiver.scala 283:17]
  assign io_SDATA = sdataO; // @[intervox_receiver.scala 284:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_receiver.scala 277:26]
      bitCntr <= 8'h0; // @[intervox_receiver.scala 277:26]
    end else if (io_CLK_IN) begin // @[intervox_receiver.scala 292:28]
      bitCntr <= _bitCntr_T_1; // @[intervox_receiver.scala 297:17]
    end
    if (reset) begin // @[intervox_receiver.scala 278:26]
      lrclk <= 1'h0; // @[intervox_receiver.scala 278:26]
    end else if (io_CLK_IN) begin // @[intervox_receiver.scala 292:28]
      if (bitCntr > 8'h1f) begin // @[intervox_receiver.scala 303:29]
        lrclk <= 1'h0; // @[intervox_receiver.scala 305:19]
      end else begin
        lrclk <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_receiver.scala 279:26]
      sdataO <= 1'h0; // @[intervox_receiver.scala 279:26]
    end else if (io_CLK_IN) begin // @[intervox_receiver.scala 292:28]
      if (bitCntr > 8'h38) begin // @[intervox_receiver.scala 319:31]
        sdataO <= 1'h0; // @[intervox_receiver.scala 321:20]
      end else begin
        sdataO <= _GEN_5;
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
  bitCntr = _RAND_0[7:0];
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
  wire  clockRec_clock; // @[intervox_receiver.scala 345:29]
  wire  clockRec_reset; // @[intervox_receiver.scala 345:29]
  wire  clockRec_io_DATA_IN; // @[intervox_receiver.scala 345:29]
  wire  clockRec_io_CLK_OUT; // @[intervox_receiver.scala 345:29]
  wire  clockRec_io_DATA_OUT; // @[intervox_receiver.scala 345:29]
  wire  clockRec_io_DBUG; // @[intervox_receiver.scala 345:29]
  wire  clockRec_io_DBUG1; // @[intervox_receiver.scala 345:29]
  wire [15:0] clockRec_io_LED; // @[intervox_receiver.scala 345:29]
  wire [15:0] clockRec_io_SW; // @[intervox_receiver.scala 345:29]
  wire  clockRec_io_BTN_C; // @[intervox_receiver.scala 345:29]
  wire  i2sTrans_clock; // @[intervox_receiver.scala 356:29]
  wire  i2sTrans_reset; // @[intervox_receiver.scala 356:29]
  wire  i2sTrans_io_CLK_IN; // @[intervox_receiver.scala 356:29]
  wire  i2sTrans_io_BCLK; // @[intervox_receiver.scala 356:29]
  wire  i2sTrans_io_LRCLK; // @[intervox_receiver.scala 356:29]
  wire  i2sTrans_io_SDATA; // @[intervox_receiver.scala 356:29]
  clock_Recovery clockRec ( // @[intervox_receiver.scala 345:29]
    .clock(clockRec_clock),
    .reset(clockRec_reset),
    .io_DATA_IN(clockRec_io_DATA_IN),
    .io_CLK_OUT(clockRec_io_CLK_OUT),
    .io_DATA_OUT(clockRec_io_DATA_OUT),
    .io_DBUG(clockRec_io_DBUG),
    .io_DBUG1(clockRec_io_DBUG1),
    .io_LED(clockRec_io_LED),
    .io_SW(clockRec_io_SW),
    .io_BTN_C(clockRec_io_BTN_C)
  );
  i2s_Transmitter i2sTrans ( // @[intervox_receiver.scala 356:29]
    .clock(i2sTrans_clock),
    .reset(i2sTrans_reset),
    .io_CLK_IN(i2sTrans_io_CLK_IN),
    .io_BCLK(i2sTrans_io_BCLK),
    .io_LRCLK(i2sTrans_io_LRCLK),
    .io_SDATA(i2sTrans_io_SDATA)
  );
  assign io_CLK_REC = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 352:21]
  assign io_DATA_OUT = clockRec_io_DATA_OUT; // @[intervox_receiver.scala 350:21]
  assign io_CLK_DBUG = 1'h0; // @[intervox_receiver.scala 351:21]
  assign io_DBUG = clockRec_io_DBUG; // @[intervox_receiver.scala 354:21]
  assign io_DBUG1 = clockRec_io_DBUG1; // @[intervox_receiver.scala 353:21]
  assign io_LED = clockRec_io_LED; // @[intervox_receiver.scala 349:21]
  assign io_BCLK = i2sTrans_io_BCLK; // @[intervox_receiver.scala 360:21]
  assign io_LRCLK = i2sTrans_io_LRCLK; // @[intervox_receiver.scala 362:21]
  assign io_SDATA = i2sTrans_io_SDATA; // @[intervox_receiver.scala 361:21]
  assign clockRec_clock = clock;
  assign clockRec_reset = reset;
  assign clockRec_io_DATA_IN = io_INTERVOX_IN; // @[intervox_receiver.scala 346:29]
  assign clockRec_io_SW = io_SW; // @[intervox_receiver.scala 347:29]
  assign clockRec_io_BTN_C = io_BTN_C; // @[intervox_receiver.scala 348:29]
  assign i2sTrans_clock = clock;
  assign i2sTrans_reset = reset;
  assign i2sTrans_io_CLK_IN = clockRec_io_CLK_OUT; // @[intervox_receiver.scala 357:29]
endmodule
