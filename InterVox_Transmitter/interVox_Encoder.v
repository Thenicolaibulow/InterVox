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
  reg [63:0] mem [0:0]; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_r_en; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_r_addr; // @[intervox_transmitter.scala 19:24]
  wire [63:0] mem_rdwrPort_r_data; // @[intervox_transmitter.scala 19:24]
  wire [63:0] mem_rdwrPort_w_data; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_w_addr; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_w_mask; // @[intervox_transmitter.scala 19:24]
  wire  mem_rdwrPort_w_en; // @[intervox_transmitter.scala 19:24]
  reg  mem_rdwrPort_r_en_pipe_0;
  reg  mem_rdwrPort_r_addr_pipe_0;
  assign mem_rdwrPort_r_en = mem_rdwrPort_r_en_pipe_0;
  assign mem_rdwrPort_r_addr = mem_rdwrPort_r_addr_pipe_0;
  assign mem_rdwrPort_r_data = mem[mem_rdwrPort_r_addr]; // @[intervox_transmitter.scala 19:24]
  assign mem_rdwrPort_w_data = io_dataIn;
  assign mem_rdwrPort_w_addr = 1'h0;
  assign mem_rdwrPort_w_mask = io_write;
  assign mem_rdwrPort_w_en = 1'h1 & io_write;
  assign io_dataOut = mem_rdwrPort_r_data; // @[intervox_transmitter.scala 25:21 26:34]
  always @(posedge clock) begin
    if (mem_rdwrPort_w_en & mem_rdwrPort_w_mask) begin
      mem[mem_rdwrPort_w_addr] <= mem_rdwrPort_w_data; // @[intervox_transmitter.scala 19:24]
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
module biPhaseEncoder(
  input         clock,
  input         reset,
  output        io_DATA_OUT,
  input  [63:0] io_AUDIOINPUT,
  input  [63:0] io_DSPINPUT,
  input         io_ENA,
  input         io_CLK
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg  outReg; // @[intervox_transmitter.scala 38:32]
  reg [63:0] stereoData; // @[intervox_transmitter.scala 39:32]
  reg [15:0] dspData; // @[intervox_transmitter.scala 40:32]
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 41:32]
  reg  hasOne; // @[intervox_transmitter.scala 42:32]
  reg [7:0] zeroFlip; // @[intervox_transmitter.scala 43:33]
  reg  stillOne; // @[intervox_transmitter.scala 44:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 45:32]
  reg  ndexR; // @[intervox_transmitter.scala 46:32]
  reg  enabled; // @[intervox_transmitter.scala 47:32]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 61:38]
  wire  _outReg_T = ~outReg; // @[intervox_transmitter.scala 71:23]
  wire  _GEN_0 = bitCntr_enc == 8'h3 ? ~outReg : outReg; // @[intervox_transmitter.scala 70:36 71:20 38:32]
  wire  _GEN_1 = bitCntr_enc == 8'h4 ? _outReg_T : _GEN_0; // @[intervox_transmitter.scala 74:36 75:20]
  wire  _GEN_2 = bitCntr_enc == 8'h5 ? _outReg_T : _GEN_1; // @[intervox_transmitter.scala 77:36 78:20]
  wire  _ndexR_T = ~ndexR; // @[intervox_transmitter.scala 85:22]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 88:38]
  wire [5:0] _GEN_3 = _ndexR_T ? _dataIndex_T_1 : dataIndex; // @[intervox_transmitter.scala 86:32 88:25 45:32]
  wire [5:0] _T_10 = 6'h3f - dataIndex; // @[intervox_transmitter.scala 107:39]
  wire [63:0] _T_11 = stereoData >> _T_10; // @[intervox_transmitter.scala 107:33]
  wire  _GEN_4 = _T_11[0] | hasOne; // @[intervox_transmitter.scala 107:62 109:26 42:32]
  wire  _GEN_5 = _ndexR_T ? _GEN_4 : hasOne; // @[intervox_transmitter.scala 106:34 42:32]
  wire  _GEN_6 = bitCntr_enc < 8'h35 ? _GEN_5 : hasOne; // @[intervox_transmitter.scala 104:37 42:32]
  wire [5:0] _T_19 = dataIndex - 6'h18; // @[intervox_transmitter.scala 121:53]
  wire [5:0] _T_21 = 6'h27 - _T_19; // @[intervox_transmitter.scala 121:40]
  wire [63:0] _T_22 = stereoData >> _T_21; // @[intervox_transmitter.scala 121:33]
  wire  _GEN_7 = _T_22[0] | _GEN_6; // @[intervox_transmitter.scala 121:73 122:26]
  wire  _GEN_8 = _ndexR_T ? _GEN_7 : _GEN_6; // @[intervox_transmitter.scala 120:34]
  wire  _GEN_9 = bitCntr_enc >= 8'h35 & bitCntr_enc < 8'h65 ? _GEN_8 : _GEN_6; // @[intervox_transmitter.scala 118:64]
  wire [5:0] _T_30 = dataIndex - 6'h30; // @[intervox_transmitter.scala 133:42]
  wire [15:0] _T_31 = dspData >> _T_30; // @[intervox_transmitter.scala 133:30]
  wire  _GEN_10 = _T_31[0] | _GEN_9; // @[intervox_transmitter.scala 133:62 134:26]
  wire  _GEN_11 = _ndexR_T ? _GEN_10 : _GEN_9; // @[intervox_transmitter.scala 132:34]
  wire  _GEN_12 = bitCntr_enc >= 8'h65 & bitCntr_enc <= 8'h7f ? _GEN_11 : _GEN_9; // @[intervox_transmitter.scala 131:66]
  wire  _GEN_13 = stillOne ? 1'h0 : _GEN_12; // @[intervox_transmitter.scala 147:37 148:24]
  wire  _GEN_14 = stillOne ? 1'h0 : 1'h1; // @[intervox_transmitter.scala 146:24 147:37 149:26]
  wire  _GEN_15 = zeroFlip == 8'h1 ? 1'h0 : 1'h1; // @[intervox_transmitter.scala 155:27 156:39 157:28]
  wire  _GEN_16 = zeroFlip == 8'h1 ? _outReg_T : outReg; // @[intervox_transmitter.scala 156:39 158:26 154:27]
  wire  _GEN_17 = hasOne ? _outReg_T : _GEN_16; // @[intervox_transmitter.scala 143:33 145:22]
  wire  _GEN_18 = hasOne ? _GEN_14 : stillOne; // @[intervox_transmitter.scala 143:33 44:32]
  wire  _GEN_19 = hasOne ? _GEN_13 : _GEN_12; // @[intervox_transmitter.scala 143:33]
  wire [7:0] _GEN_20 = hasOne ? zeroFlip : {{7'd0}, _GEN_15}; // @[intervox_transmitter.scala 143:33 43:33]
  wire [5:0] _GEN_22 = bitCntr_enc > 8'h5 ? _GEN_3 : dataIndex; // @[intervox_transmitter.scala 45:32 82:36]
  wire [63:0] _GEN_46 = reset ? 64'h0 : io_DSPINPUT; // @[intervox_transmitter.scala 40:{32,32} 52:17]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 49:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc > 8'h5) begin // @[intervox_transmitter.scala 82:36]
          outReg <= _GEN_17;
        end else begin
          outReg <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 39:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 39:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 51:17]
    end
    dspData <= _GEN_46[15:0]; // @[intervox_transmitter.scala 40:{32,32} 52:17]
    if (reset) begin // @[intervox_transmitter.scala 41:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 41:32]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 164:38]
          bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 165:25]
        end else begin
          bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 61:23]
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      hasOne <= 1'h0; // @[intervox_transmitter.scala 42:32]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc > 8'h5) begin // @[intervox_transmitter.scala 82:36]
          hasOne <= _GEN_19;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:33]
      zeroFlip <= 8'h0; // @[intervox_transmitter.scala 43:33]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc > 8'h5) begin // @[intervox_transmitter.scala 82:36]
          zeroFlip <= _GEN_20;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 44:32]
      stillOne <= 1'h0; // @[intervox_transmitter.scala 44:32]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc > 8'h5) begin // @[intervox_transmitter.scala 82:36]
          stillOne <= _GEN_18;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 45:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 45:32]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 164:38]
          dataIndex <= 6'h0; // @[intervox_transmitter.scala 166:23]
        end else begin
          dataIndex <= _GEN_22;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 46:32]
      ndexR <= 1'h0; // @[intervox_transmitter.scala 46:32]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc > 8'h5) begin // @[intervox_transmitter.scala 82:36]
          ndexR <= ~ndexR; // @[intervox_transmitter.scala 85:19]
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 47:32]
      enabled <= 1'h0; // @[intervox_transmitter.scala 47:32]
    end else if (io_CLK) begin // @[intervox_transmitter.scala 56:25]
      if (enabled) begin // @[intervox_transmitter.scala 58:28]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 164:38]
          enabled <= 1'h0; // @[intervox_transmitter.scala 167:21]
        end else begin
          enabled <= io_ENA; // @[intervox_transmitter.scala 53:17]
        end
      end else begin
        enabled <= io_ENA; // @[intervox_transmitter.scala 53:17]
      end
    end else begin
      enabled <= io_ENA; // @[intervox_transmitter.scala 53:17]
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
  outReg = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  stereoData = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  dspData = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  bitCntr_enc = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  hasOne = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  zeroFlip = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  stillOne = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  dataIndex = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  ndexR = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  enabled = _RAND_9[0:0];
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
  output  io_TRAIL,
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
  reg [1:0] inBufr; // @[intervox_transmitter.scala 181:34]
  reg [1:0] inBufrPrev; // @[intervox_transmitter.scala 182:34]
  reg  trailing; // @[intervox_transmitter.scala 183:34]
  reg  rising; // @[intervox_transmitter.scala 184:34]
  reg  change; // @[intervox_transmitter.scala 185:34]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_transmitter.scala 195:35]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_transmitter.scala 202:35]
  wire  _GEN_8 = rising | trailing | change; // @[intervox_transmitter.scala 208:48 209:17 185:34]
  wire  _T_8 = inBufr == 2'h1; // @[intervox_transmitter.scala 212:41]
  wire  _GEN_9 = inBufrPrev == 2'h0 & inBufr == 2'h1 ? 1'h0 : trailing; // @[intervox_transmitter.scala 212:50 213:17 183:34]
  wire  _GEN_10 = inBufrPrev == 2'h0 & inBufr == 2'h1 | rising; // @[intervox_transmitter.scala 212:50 214:17 184:34]
  wire  _GEN_11 = inBufrPrev == 2'h0 & inBufr == 2'h1 | _GEN_8; // @[intervox_transmitter.scala 212:50 215:17]
  wire  _GEN_12 = inBufrPrev == 2'h2 & _T_8 | _GEN_9; // @[intervox_transmitter.scala 218:50 219:17]
  wire  _GEN_14 = inBufrPrev == 2'h2 & _T_8 | _GEN_11; // @[intervox_transmitter.scala 218:50 221:17]
  assign io_TRAIL = trailing; // @[intervox_transmitter.scala 232:13]
  assign io_RISE = rising; // @[intervox_transmitter.scala 233:13]
  assign io_CHANGE = change; // @[intervox_transmitter.scala 231:13]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 181:34]
      inBufr <= 2'h0; // @[intervox_transmitter.scala 181:34]
    end else if (io_INPUT) begin // @[intervox_transmitter.scala 191:21]
      if (inBufr < 2'h2) begin // @[intervox_transmitter.scala 193:27]
        inBufr <= _inBufr_T_1; // @[intervox_transmitter.scala 195:25]
      end
    end else if (~io_INPUT) begin // @[intervox_transmitter.scala 191:21]
      if (inBufr > 2'h0) begin // @[intervox_transmitter.scala 200:27]
        inBufr <= _inBufr_T_3; // @[intervox_transmitter.scala 202:25]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 182:34]
      inBufrPrev <= 2'h0; // @[intervox_transmitter.scala 182:34]
    end else if (io_INPUT) begin // @[intervox_transmitter.scala 191:21]
      if (inBufr < 2'h2) begin // @[intervox_transmitter.scala 193:27]
        inBufrPrev <= inBufr; // @[intervox_transmitter.scala 196:25]
      end
    end else if (~io_INPUT) begin // @[intervox_transmitter.scala 191:21]
      if (inBufr > 2'h0) begin // @[intervox_transmitter.scala 200:27]
        inBufrPrev <= inBufr; // @[intervox_transmitter.scala 203:25]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 183:34]
      trailing <= 1'h0; // @[intervox_transmitter.scala 183:34]
    end else if (trailing) begin // @[intervox_transmitter.scala 224:27]
      trailing <= 1'h0; // @[intervox_transmitter.scala 224:37]
    end else begin
      trailing <= _GEN_12;
    end
    if (reset) begin // @[intervox_transmitter.scala 184:34]
      rising <= 1'h0; // @[intervox_transmitter.scala 184:34]
    end else if (rising) begin // @[intervox_transmitter.scala 225:27]
      rising <= 1'h0; // @[intervox_transmitter.scala 225:37]
    end else if (inBufrPrev == 2'h2 & _T_8) begin // @[intervox_transmitter.scala 218:50]
      rising <= 1'h0; // @[intervox_transmitter.scala 220:17]
    end else begin
      rising <= _GEN_10;
    end
    if (reset) begin // @[intervox_transmitter.scala 185:34]
      change <= 1'h0; // @[intervox_transmitter.scala 185:34]
    end else if (change) begin // @[intervox_transmitter.scala 227:25]
      change <= 1'h0; // @[intervox_transmitter.scala 228:16]
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
module interVox_Encoder(
  input         clock,
  input         reset,
  output        io_MCLK_O,
  input         io_BCLK_IN,
  input         io_LRCLK_IN,
  input         io_SDATA_IN,
  output        io_DATA_O,
  output        io_LRCLK_O,
  output        io_BCLK_O,
  output        io_SDATA_O,
  output        io_NXT_FRAME,
  input  [15:0] io_SW,
  output [15:0] io_LED,
  input         io_BTN_C,
  input         io_BTN_D,
  input         io_BTN_L,
  input         io_BTN_R
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
  wire  BFR_clock; // @[intervox_transmitter.scala 275:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 275:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 275:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 275:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 276:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 276:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 276:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 276:33]
  wire  biPhaseEncoder_clock; // @[intervox_transmitter.scala 278:35]
  wire  biPhaseEncoder_reset; // @[intervox_transmitter.scala 278:35]
  wire  biPhaseEncoder_io_DATA_OUT; // @[intervox_transmitter.scala 278:35]
  wire [63:0] biPhaseEncoder_io_AUDIOINPUT; // @[intervox_transmitter.scala 278:35]
  wire [63:0] biPhaseEncoder_io_DSPINPUT; // @[intervox_transmitter.scala 278:35]
  wire  biPhaseEncoder_io_ENA; // @[intervox_transmitter.scala 278:35]
  wire  biPhaseEncoder_io_CLK; // @[intervox_transmitter.scala 278:35]
  wire  LREDGE_clock; // @[intervox_transmitter.scala 280:33]
  wire  LREDGE_reset; // @[intervox_transmitter.scala 280:33]
  wire  LREDGE_io_INPUT; // @[intervox_transmitter.scala 280:33]
  wire  LREDGE_io_TRAIL; // @[intervox_transmitter.scala 280:33]
  wire  LREDGE_io_RISE; // @[intervox_transmitter.scala 280:33]
  wire  LREDGE_io_CHANGE; // @[intervox_transmitter.scala 280:33]
  wire  BCLKEDGE_clock; // @[intervox_transmitter.scala 282:33]
  wire  BCLKEDGE_reset; // @[intervox_transmitter.scala 282:33]
  wire  BCLKEDGE_io_INPUT; // @[intervox_transmitter.scala 282:33]
  wire  BCLKEDGE_io_TRAIL; // @[intervox_transmitter.scala 282:33]
  wire  BCLKEDGE_io_RISE; // @[intervox_transmitter.scala 282:33]
  wire  BCLKEDGE_io_CHANGE; // @[intervox_transmitter.scala 282:33]
  wire  DATAEDGE_clock; // @[intervox_transmitter.scala 284:33]
  wire  DATAEDGE_reset; // @[intervox_transmitter.scala 284:33]
  wire  DATAEDGE_io_INPUT; // @[intervox_transmitter.scala 284:33]
  wire  DATAEDGE_io_TRAIL; // @[intervox_transmitter.scala 284:33]
  wire  DATAEDGE_io_RISE; // @[intervox_transmitter.scala 284:33]
  wire  DATAEDGE_io_CHANGE; // @[intervox_transmitter.scala 284:33]
  reg [1:0] currentState; // @[intervox_transmitter.scala 257:33]
  reg  syncing; // @[intervox_transmitter.scala 259:34]
  reg  synced; // @[intervox_transmitter.scala 260:34]
  reg  biPhaseEna; // @[intervox_transmitter.scala 261:34]
  reg [15:0] leds; // @[intervox_transmitter.scala 264:34]
  reg [15:0] left; // @[intervox_transmitter.scala 265:34]
  reg [15:0] right; // @[intervox_transmitter.scala 266:34]
  reg [15:0] dspData; // @[intervox_transmitter.scala 267:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 273:34]
  wire  _GEN_0 = LREDGE_io_TRAIL | syncing; // @[intervox_transmitter.scala 332:34 333:15 259:34]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 336:30]
  wire  _GEN_1 = LREDGE_io_RISE | synced; // @[intervox_transmitter.scala 338:35 339:19 260:34]
  wire [7:0] _GEN_2 = LREDGE_io_RISE ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 336:19 338:35 340:19]
  wire [7:0] _GEN_3 = syncing ? _GEN_2 : bitCntr; // @[intervox_transmitter.scala 335:27 273:34]
  wire [7:0] _GEN_6 = ~synced ? _GEN_3 : bitCntr; // @[intervox_transmitter.scala 330:23 273:34]
  wire  _T_8 = BCLKEDGE_io_RISE; // @[intervox_transmitter.scala 374:31]
  wire  _T_11 = ~io_SDATA_IN; // @[intervox_transmitter.scala 396:33]
  wire [7:0] _BFR_io_dataIn_T_1 = bitCntr - 8'h1f; // @[intervox_transmitter.scala 400:80]
  wire [7:0] _BFR_io_dataIn_T_3 = 8'h27 - _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 400:69]
  wire [255:0] _BFR_io_dataIn_T_4 = 256'h0 << _BFR_io_dataIn_T_3; // @[intervox_transmitter.scala 400:60]
  wire [255:0] _GEN_89 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 400:53]
  wire [255:0] _BFR_io_dataIn_T_5 = _GEN_89 | _BFR_io_dataIn_T_4; // @[intervox_transmitter.scala 400:53]
  wire [255:0] _GEN_8 = ~io_SDATA_IN ? _BFR_io_dataIn_T_5 : 256'h0; // @[intervox_transmitter.scala 299:25 396:42 400:35]
  wire [255:0] _BFR_io_dataIn_T_10 = 256'h1 << _BFR_io_dataIn_T_3; // @[intervox_transmitter.scala 403:60]
  wire [255:0] _BFR_io_dataIn_T_11 = _GEN_89 | _BFR_io_dataIn_T_10; // @[intervox_transmitter.scala 403:53]
  wire [255:0] _GEN_9 = io_SDATA_IN ? _BFR_io_dataIn_T_11 : _GEN_8; // @[intervox_transmitter.scala 402:42 403:35]
  wire [7:0] _BFR_io_dataIn_T_13 = 8'h3f - bitCntr; // @[intervox_transmitter.scala 411:69]
  wire [255:0] _BFR_io_dataIn_T_14 = 256'h0 << _BFR_io_dataIn_T_13; // @[intervox_transmitter.scala 411:60]
  wire [255:0] _BFR_io_dataIn_T_15 = _GEN_89 | _BFR_io_dataIn_T_14; // @[intervox_transmitter.scala 411:53]
  wire [255:0] _GEN_10 = _T_11 ? _BFR_io_dataIn_T_15 : 256'h0; // @[intervox_transmitter.scala 299:25 408:43 411:35]
  wire [255:0] _BFR_io_dataIn_T_18 = 256'h1 << _BFR_io_dataIn_T_13; // @[intervox_transmitter.scala 414:61]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_89 | _BFR_io_dataIn_T_18; // @[intervox_transmitter.scala 414:53]
  wire [255:0] _GEN_11 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_10; // @[intervox_transmitter.scala 413:42 414:35]
  wire [255:0] _GEN_13 = bitCntr > 8'h1f ? _GEN_9 : _GEN_11; // @[intervox_transmitter.scala 392:33]
  wire [15:0] _GEN_14 = io_BTN_L ? io_SW : left; // @[intervox_transmitter.scala 425:35 427:23 265:34]
  wire [15:0] _GEN_15 = io_BTN_L ? left : leds; // @[intervox_transmitter.scala 425:35 428:23 264:34]
  wire [15:0] _GEN_16 = io_BTN_R ? io_SW : right; // @[intervox_transmitter.scala 430:35 432:23 266:34]
  wire [15:0] _GEN_17 = io_BTN_R ? right : _GEN_15; // @[intervox_transmitter.scala 430:35 433:23]
  wire [15:0] _GEN_18 = io_BTN_C ? io_SW : dspData; // @[intervox_transmitter.scala 435:35 437:23 267:34]
  wire [15:0] _GEN_19 = io_BTN_C ? dspData : _GEN_17; // @[intervox_transmitter.scala 435:35 438:23]
  wire [63:0] _GEN_93 = {left, 48'h0}; // @[intervox_transmitter.scala 445:36]
  wire [78:0] _BFR_io_dataIn_T_20 = {{15'd0}, _GEN_93}; // @[intervox_transmitter.scala 445:36]
  wire [39:0] _GEN_94 = {right, 24'h0}; // @[intervox_transmitter.scala 445:56]
  wire [46:0] _BFR_io_dataIn_T_21 = {{7'd0}, _GEN_94}; // @[intervox_transmitter.scala 445:56]
  wire [78:0] _GEN_95 = {{32'd0}, _BFR_io_dataIn_T_21}; // @[intervox_transmitter.scala 445:47]
  wire [78:0] _BFR_io_dataIn_T_22 = _BFR_io_dataIn_T_20 | _GEN_95; // @[intervox_transmitter.scala 445:47]
  wire [255:0] _GEN_21 = io_SW == 16'h0 ? _GEN_13 : {{177'd0}, _BFR_io_dataIn_T_22}; // @[intervox_transmitter.scala 390:30 445:27]
  wire [15:0] _GEN_22 = io_SW == 16'h0 ? left : _GEN_14; // @[intervox_transmitter.scala 390:30 265:34]
  wire [15:0] _GEN_23 = io_SW == 16'h0 ? leds : _GEN_19; // @[intervox_transmitter.scala 390:30 264:34]
  wire [15:0] _GEN_24 = io_SW == 16'h0 ? right : _GEN_16; // @[intervox_transmitter.scala 390:30 266:34]
  wire [15:0] _GEN_25 = io_SW == 16'h0 ? dspData : _GEN_18; // @[intervox_transmitter.scala 390:30 267:34]
  wire  _T_18 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 448:24]
  wire [63:0] _leds_T = {{48'd0}, BFR1_io_dataOut[63:48]}; // @[intervox_transmitter.scala 464:40]
  wire [63:0] _leds_T_1 = _leds_T & 64'hffff; // @[intervox_transmitter.scala 464:49]
  wire [63:0] _GEN_26 = io_BTN_D ? _leds_T_1 : {{48'd0}, _GEN_23}; // @[intervox_transmitter.scala 462:35 464:20]
  wire [63:0] _GEN_29 = BFR_io_dataOut; // @[intervox_transmitter.scala 303:25 448:33 454:32]
  wire [255:0] _GEN_30 = bitCntr == 8'h3f ? 256'h0 : _GEN_21; // @[intervox_transmitter.scala 448:33 458:28]
  wire [63:0] _GEN_31 = bitCntr == 8'h3f ? _GEN_26 : {{48'd0}, _GEN_23}; // @[intervox_transmitter.scala 448:33]
  wire [7:0] _GEN_32 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 380:19 448:33 467:21]
  wire  _GEN_33 = BCLKEDGE_io_RISE | biPhaseEna; // @[intervox_transmitter.scala 374:39 377:23 261:34]
  wire [7:0] _GEN_34 = BCLKEDGE_io_RISE ? _GEN_32 : _GEN_6; // @[intervox_transmitter.scala 374:39]
  wire [255:0] _GEN_36 = BCLKEDGE_io_RISE ? _GEN_30 : 256'h0; // @[intervox_transmitter.scala 299:25 374:39]
  wire [15:0] _GEN_37 = BCLKEDGE_io_RISE ? _GEN_22 : left; // @[intervox_transmitter.scala 265:34 374:39]
  wire [63:0] _GEN_38 = BCLKEDGE_io_RISE ? _GEN_31 : {{48'd0}, leds}; // @[intervox_transmitter.scala 264:34 374:39]
  wire [15:0] _GEN_39 = BCLKEDGE_io_RISE ? _GEN_24 : right; // @[intervox_transmitter.scala 266:34 374:39]
  wire [15:0] _GEN_40 = BCLKEDGE_io_RISE ? _GEN_25 : dspData; // @[intervox_transmitter.scala 267:34 374:39]
  wire  _GEN_41 = BCLKEDGE_io_RISE & _T_18; // @[intervox_transmitter.scala 302:25 374:39]
  wire [63:0] _GEN_42 = BCLKEDGE_io_RISE ? _GEN_29 : BFR_io_dataOut; // @[intervox_transmitter.scala 303:25 374:39]
  wire  _GEN_44 = synced ? _GEN_33 : biPhaseEna; // @[intervox_transmitter.scala 364:29 261:34]
  wire [7:0] _GEN_45 = synced ? _GEN_34 : _GEN_6; // @[intervox_transmitter.scala 364:29]
  wire  _GEN_46 = synced & _T_8; // @[intervox_transmitter.scala 298:25 364:29]
  wire [255:0] _GEN_47 = synced ? _GEN_36 : 256'h0; // @[intervox_transmitter.scala 299:25 364:29]
  wire [15:0] _GEN_48 = synced ? _GEN_37 : left; // @[intervox_transmitter.scala 364:29 265:34]
  wire [63:0] _GEN_49 = synced ? _GEN_38 : {{48'd0}, leds}; // @[intervox_transmitter.scala 364:29 264:34]
  wire [15:0] _GEN_50 = synced ? _GEN_39 : right; // @[intervox_transmitter.scala 364:29 266:34]
  wire [15:0] _GEN_51 = synced ? _GEN_40 : dspData; // @[intervox_transmitter.scala 364:29 267:34]
  wire  _GEN_52 = synced & _GEN_41; // @[intervox_transmitter.scala 302:25 364:29]
  wire [63:0] _GEN_53 = synced ? _GEN_42 : BFR_io_dataOut; // @[intervox_transmitter.scala 303:25 364:29]
  wire [255:0] _GEN_58 = 2'h2 == currentState ? _GEN_47 : 256'h0; // @[intervox_transmitter.scala 352:23 299:25]
  wire [63:0] _GEN_60 = 2'h2 == currentState ? _GEN_49 : {{48'd0}, leds}; // @[intervox_transmitter.scala 352:23 264:34]
  wire [63:0] _GEN_64 = 2'h2 == currentState ? _GEN_53 : BFR_io_dataOut; // @[intervox_transmitter.scala 352:23 303:25]
  wire  _GEN_69 = 2'h1 == currentState ? 1'h0 : 2'h2 == currentState & _GEN_46; // @[intervox_transmitter.scala 352:23 298:25]
  wire [255:0] _GEN_70 = 2'h1 == currentState ? 256'h0 : _GEN_58; // @[intervox_transmitter.scala 352:23 299:25]
  wire [63:0] _GEN_72 = 2'h1 == currentState ? {{48'd0}, leds} : _GEN_60; // @[intervox_transmitter.scala 352:23 264:34]
  wire  _GEN_75 = 2'h1 == currentState ? 1'h0 : 2'h2 == currentState & _GEN_52; // @[intervox_transmitter.scala 352:23 302:25]
  wire [63:0] _GEN_76 = 2'h1 == currentState ? BFR_io_dataOut : _GEN_64; // @[intervox_transmitter.scala 352:23 303:25]
  wire [255:0] _GEN_82 = 2'h0 == currentState ? 256'h0 : _GEN_70; // @[intervox_transmitter.scala 352:23 299:25]
  wire [63:0] _GEN_84 = 2'h0 == currentState ? {{48'd0}, leds} : _GEN_72; // @[intervox_transmitter.scala 352:23 264:34]
  wire [63:0] _GEN_97 = reset ? 64'h0 : _GEN_84; // @[intervox_transmitter.scala 264:{34,34}]
  RWSmem BFR ( // @[intervox_transmitter.scala 275:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 276:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  biPhaseEncoder biPhaseEncoder ( // @[intervox_transmitter.scala 278:35]
    .clock(biPhaseEncoder_clock),
    .reset(biPhaseEncoder_reset),
    .io_DATA_OUT(biPhaseEncoder_io_DATA_OUT),
    .io_AUDIOINPUT(biPhaseEncoder_io_AUDIOINPUT),
    .io_DSPINPUT(biPhaseEncoder_io_DSPINPUT),
    .io_ENA(biPhaseEncoder_io_ENA),
    .io_CLK(biPhaseEncoder_io_CLK)
  );
  edgeDetector LREDGE ( // @[intervox_transmitter.scala 280:33]
    .clock(LREDGE_clock),
    .reset(LREDGE_reset),
    .io_INPUT(LREDGE_io_INPUT),
    .io_TRAIL(LREDGE_io_TRAIL),
    .io_RISE(LREDGE_io_RISE),
    .io_CHANGE(LREDGE_io_CHANGE)
  );
  edgeDetector BCLKEDGE ( // @[intervox_transmitter.scala 282:33]
    .clock(BCLKEDGE_clock),
    .reset(BCLKEDGE_reset),
    .io_INPUT(BCLKEDGE_io_INPUT),
    .io_TRAIL(BCLKEDGE_io_TRAIL),
    .io_RISE(BCLKEDGE_io_RISE),
    .io_CHANGE(BCLKEDGE_io_CHANGE)
  );
  edgeDetector DATAEDGE ( // @[intervox_transmitter.scala 284:33]
    .clock(DATAEDGE_clock),
    .reset(DATAEDGE_reset),
    .io_INPUT(DATAEDGE_io_INPUT),
    .io_TRAIL(DATAEDGE_io_TRAIL),
    .io_RISE(DATAEDGE_io_RISE),
    .io_CHANGE(DATAEDGE_io_CHANGE)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 289:25]
  assign io_DATA_O = biPhaseEncoder_io_DATA_OUT; // @[intervox_transmitter.scala 288:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 291:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 290:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 292:25]
  assign io_NXT_FRAME = BCLKEDGE_io_CHANGE; // @[intervox_transmitter.scala 306:33]
  assign io_LED = leds; // @[intervox_transmitter.scala 293:25]
  assign BFR_clock = clock;
  assign BFR_io_write = 2'h0 == currentState ? 1'h0 : _GEN_69; // @[intervox_transmitter.scala 352:23 298:25]
  assign BFR_io_dataIn = _GEN_82[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = 2'h0 == currentState ? 1'h0 : _GEN_75; // @[intervox_transmitter.scala 352:23 302:25]
  assign BFR1_io_dataIn = 2'h0 == currentState ? BFR_io_dataOut : _GEN_76; // @[intervox_transmitter.scala 352:23 303:25]
  assign biPhaseEncoder_clock = clock;
  assign biPhaseEncoder_reset = reset;
  assign biPhaseEncoder_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 311:33]
  assign biPhaseEncoder_io_DSPINPUT = {{48'd0}, dspData}; // @[intervox_transmitter.scala 313:33]
  assign biPhaseEncoder_io_ENA = biPhaseEna; // @[intervox_transmitter.scala 309:33]
  assign biPhaseEncoder_io_CLK = BCLKEDGE_io_CHANGE; // @[intervox_transmitter.scala 308:33]
  assign LREDGE_clock = clock;
  assign LREDGE_reset = reset;
  assign LREDGE_io_INPUT = io_LRCLK_IN; // @[intervox_transmitter.scala 281:25]
  assign BCLKEDGE_clock = clock;
  assign BCLKEDGE_reset = reset;
  assign BCLKEDGE_io_INPUT = io_BCLK_IN; // @[intervox_transmitter.scala 283:25]
  assign DATAEDGE_clock = clock;
  assign DATAEDGE_reset = reset;
  assign DATAEDGE_io_INPUT = io_SDATA_IN; // @[intervox_transmitter.scala 285:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 257:33]
      currentState <= 2'h0; // @[intervox_transmitter.scala 257:33]
    end else if (2'h0 == currentState) begin // @[intervox_transmitter.scala 352:23]
      currentState <= 2'h2; // @[intervox_transmitter.scala 356:20]
    end else if (2'h1 == currentState) begin // @[intervox_transmitter.scala 352:23]
      currentState <= 2'h2; // @[intervox_transmitter.scala 360:20]
    end
    if (reset) begin // @[intervox_transmitter.scala 259:34]
      syncing <= 1'h0; // @[intervox_transmitter.scala 259:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 330:23]
      syncing <= _GEN_0;
    end
    if (reset) begin // @[intervox_transmitter.scala 260:34]
      synced <= 1'h0; // @[intervox_transmitter.scala 260:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 330:23]
      if (syncing) begin // @[intervox_transmitter.scala 335:27]
        synced <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 261:34]
      biPhaseEna <= 1'h0; // @[intervox_transmitter.scala 261:34]
    end else if (!(2'h0 == currentState)) begin // @[intervox_transmitter.scala 352:23]
      if (!(2'h1 == currentState)) begin // @[intervox_transmitter.scala 352:23]
        if (2'h2 == currentState) begin // @[intervox_transmitter.scala 352:23]
          biPhaseEna <= _GEN_44;
        end
      end
    end
    leds <= _GEN_97[15:0]; // @[intervox_transmitter.scala 264:{34,34}]
    if (reset) begin // @[intervox_transmitter.scala 265:34]
      left <= 16'h0; // @[intervox_transmitter.scala 265:34]
    end else if (!(2'h0 == currentState)) begin // @[intervox_transmitter.scala 352:23]
      if (!(2'h1 == currentState)) begin // @[intervox_transmitter.scala 352:23]
        if (2'h2 == currentState) begin // @[intervox_transmitter.scala 352:23]
          left <= _GEN_48;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 266:34]
      right <= 16'h0; // @[intervox_transmitter.scala 266:34]
    end else if (!(2'h0 == currentState)) begin // @[intervox_transmitter.scala 352:23]
      if (!(2'h1 == currentState)) begin // @[intervox_transmitter.scala 352:23]
        if (2'h2 == currentState) begin // @[intervox_transmitter.scala 352:23]
          right <= _GEN_50;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 267:34]
      dspData <= 16'h0; // @[intervox_transmitter.scala 267:34]
    end else if (!(2'h0 == currentState)) begin // @[intervox_transmitter.scala 352:23]
      if (!(2'h1 == currentState)) begin // @[intervox_transmitter.scala 352:23]
        if (2'h2 == currentState) begin // @[intervox_transmitter.scala 352:23]
          dspData <= _GEN_51;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 273:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 273:34]
    end else if (2'h0 == currentState) begin // @[intervox_transmitter.scala 352:23]
      bitCntr <= _GEN_6;
    end else if (2'h1 == currentState) begin // @[intervox_transmitter.scala 352:23]
      bitCntr <= _GEN_6;
    end else if (2'h2 == currentState) begin // @[intervox_transmitter.scala 352:23]
      bitCntr <= _GEN_45;
    end else begin
      bitCntr <= _GEN_6;
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
  currentState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  syncing = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  synced = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  biPhaseEna = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  leds = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  left = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  right = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  dspData = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  bitCntr = _RAND_8[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
