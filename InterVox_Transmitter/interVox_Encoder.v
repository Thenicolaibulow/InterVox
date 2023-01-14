module bi_phase_encoder(
  input         clock,
  input         reset,
  output        io_DATA_OUT,
  input  [63:0] io_AUDIOINPUT,
  input         io_ENA,
  input         io_CLK,
  input         io_TRIG
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  outReg; // @[intervox_transmitter.scala 39:32]
  reg [63:0] stereoData; // @[intervox_transmitter.scala 40:32]
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 42:32]
  reg  hasNone; // @[intervox_transmitter.scala 43:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 44:32]
  reg  ndexR; // @[intervox_transmitter.scala 51:32]
  wire  _outReg_T = ~outReg; // @[intervox_transmitter.scala 67:23]
  wire  _GEN_0 = bitCntr_enc == 8'h3 ? ~outReg : outReg; // @[intervox_transmitter.scala 66:36 67:20 39:32]
  wire  _GEN_1 = bitCntr_enc == 8'h4 ? _outReg_T : _GEN_0; // @[intervox_transmitter.scala 70:36 71:20]
  wire  _GEN_2 = bitCntr_enc == 8'h4 ? 1'h0 : hasNone; // @[intervox_transmitter.scala 70:36 73:21 43:32]
  wire  _ndexR_T = ~ndexR; // @[intervox_transmitter.scala 85:22]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 88:38]
  wire [5:0] _GEN_3 = _ndexR_T ? _dataIndex_T_1 : dataIndex; // @[intervox_transmitter.scala 86:32 88:25 44:32]
  wire [6:0] _GEN_27 = {{1'd0}, _dataIndex_T_1}; // @[intervox_transmitter.scala 97:37]
  wire [6:0] _T_10 = 7'h40 - _GEN_27; // @[intervox_transmitter.scala 97:37]
  wire [63:0] _T_11 = stereoData >> _T_10; // @[intervox_transmitter.scala 97:31]
  wire  _GEN_4 = ~_T_11[0] | _GEN_2; // @[intervox_transmitter.scala 97:68 99:25]
  wire  _GEN_5 = bitCntr_enc <= 8'h35 ? _GEN_4 : _GEN_2; // @[intervox_transmitter.scala 95:38]
  wire [5:0] _T_18 = dataIndex - 6'h17; // @[intervox_transmitter.scala 109:51]
  wire [6:0] _GEN_28 = {{1'd0}, _T_18}; // @[intervox_transmitter.scala 109:38]
  wire [6:0] _T_20 = 7'h40 - _GEN_28; // @[intervox_transmitter.scala 109:38]
  wire [63:0] _T_21 = stereoData >> _T_20; // @[intervox_transmitter.scala 109:31]
  wire  _GEN_6 = ~_T_21[0] | _GEN_5; // @[intervox_transmitter.scala 109:71 110:25]
  wire  _GEN_7 = bitCntr_enc > 8'h35 & bitCntr_enc <= 8'h65 ? _GEN_6 : _GEN_5; // @[intervox_transmitter.scala 107:64]
  wire  _GEN_8 = bitCntr_enc > 8'h65 & bitCntr_enc < 8'h7f | _GEN_7; // @[intervox_transmitter.scala 119:64 123:23]
  wire  _GEN_9 = hasNone ? outReg : _outReg_T; // @[intervox_transmitter.scala 130:34 132:22 137:24]
  wire  _GEN_10 = hasNone ? 1'h0 : _GEN_8; // @[intervox_transmitter.scala 130:34 133:23]
  wire [5:0] _GEN_12 = bitCntr_enc >= 8'h5 ? _GEN_3 : dataIndex; // @[intervox_transmitter.scala 44:32 82:37]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 141:38]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 46:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 39:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 39:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 53:25]
      if (io_CLK) begin // @[intervox_transmitter.scala 57:27]
        if (bitCntr_enc >= 8'h5) begin // @[intervox_transmitter.scala 82:37]
          outReg <= _GEN_9;
        end else begin
          outReg <= _GEN_1;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 40:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 40:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 48:17]
    end
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 42:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 53:25]
      if (io_CLK) begin // @[intervox_transmitter.scala 57:27]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 144:38]
          bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 145:25]
        end else begin
          bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 141:23]
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 53:25]
      if (io_CLK) begin // @[intervox_transmitter.scala 57:27]
        if (bitCntr_enc >= 8'h5) begin // @[intervox_transmitter.scala 82:37]
          hasNone <= _GEN_10;
        end else begin
          hasNone <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 44:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 44:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 53:25]
      if (io_CLK) begin // @[intervox_transmitter.scala 57:27]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 144:38]
          dataIndex <= 6'h0; // @[intervox_transmitter.scala 146:23]
        end else begin
          dataIndex <= _GEN_12;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 51:32]
      ndexR <= 1'h0; // @[intervox_transmitter.scala 51:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 53:25]
      if (io_CLK) begin // @[intervox_transmitter.scala 57:27]
        if (bitCntr_enc >= 8'h5) begin // @[intervox_transmitter.scala 82:37]
          ndexR <= ~ndexR; // @[intervox_transmitter.scala 85:19]
        end
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
  outReg = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  stereoData = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  bitCntr_enc = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  hasNone = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dataIndex = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  ndexR = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
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
module edgeDetector(
  input   clock,
  input   reset,
  input   io_INPUT,
  output  io_TRAIL,
  output  io_CHANGE
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] inBufr; // @[intervox_transmitter.scala 160:34]
  reg [1:0] inBufrPrev; // @[intervox_transmitter.scala 161:34]
  reg  trailing; // @[intervox_transmitter.scala 162:34]
  reg  rising; // @[intervox_transmitter.scala 163:34]
  reg  change; // @[intervox_transmitter.scala 164:34]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_transmitter.scala 174:35]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_transmitter.scala 181:35]
  wire  _GEN_8 = rising | trailing | change; // @[intervox_transmitter.scala 187:48 188:17 164:34]
  wire  _T_8 = inBufr == 2'h1; // @[intervox_transmitter.scala 191:41]
  wire  _GEN_9 = inBufrPrev == 2'h0 & inBufr == 2'h1 ? 1'h0 : trailing; // @[intervox_transmitter.scala 191:50 192:17 162:34]
  wire  _GEN_10 = inBufrPrev == 2'h0 & inBufr == 2'h1 | rising; // @[intervox_transmitter.scala 191:50 193:17 163:34]
  wire  _GEN_11 = inBufrPrev == 2'h0 & inBufr == 2'h1 | _GEN_8; // @[intervox_transmitter.scala 191:50 194:17]
  wire  _GEN_12 = inBufrPrev == 2'h2 & _T_8 | _GEN_9; // @[intervox_transmitter.scala 197:50 198:17]
  wire  _GEN_14 = inBufrPrev == 2'h2 & _T_8 | _GEN_11; // @[intervox_transmitter.scala 197:50 200:17]
  assign io_TRAIL = trailing; // @[intervox_transmitter.scala 211:13]
  assign io_CHANGE = change; // @[intervox_transmitter.scala 210:13]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 160:34]
      inBufr <= 2'h0; // @[intervox_transmitter.scala 160:34]
    end else if (io_INPUT) begin // @[intervox_transmitter.scala 170:21]
      if (inBufr < 2'h2) begin // @[intervox_transmitter.scala 172:27]
        inBufr <= _inBufr_T_1; // @[intervox_transmitter.scala 174:25]
      end
    end else if (~io_INPUT) begin // @[intervox_transmitter.scala 170:21]
      if (inBufr > 2'h0) begin // @[intervox_transmitter.scala 179:27]
        inBufr <= _inBufr_T_3; // @[intervox_transmitter.scala 181:25]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 161:34]
      inBufrPrev <= 2'h0; // @[intervox_transmitter.scala 161:34]
    end else if (io_INPUT) begin // @[intervox_transmitter.scala 170:21]
      if (inBufr < 2'h2) begin // @[intervox_transmitter.scala 172:27]
        inBufrPrev <= inBufr; // @[intervox_transmitter.scala 175:25]
      end
    end else if (~io_INPUT) begin // @[intervox_transmitter.scala 170:21]
      if (inBufr > 2'h0) begin // @[intervox_transmitter.scala 179:27]
        inBufrPrev <= inBufr; // @[intervox_transmitter.scala 182:25]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 162:34]
      trailing <= 1'h0; // @[intervox_transmitter.scala 162:34]
    end else if (trailing) begin // @[intervox_transmitter.scala 203:27]
      trailing <= 1'h0; // @[intervox_transmitter.scala 203:37]
    end else begin
      trailing <= _GEN_12;
    end
    if (reset) begin // @[intervox_transmitter.scala 163:34]
      rising <= 1'h0; // @[intervox_transmitter.scala 163:34]
    end else if (rising) begin // @[intervox_transmitter.scala 204:27]
      rising <= 1'h0; // @[intervox_transmitter.scala 204:37]
    end else if (inBufrPrev == 2'h2 & _T_8) begin // @[intervox_transmitter.scala 197:50]
      rising <= 1'h0; // @[intervox_transmitter.scala 199:17]
    end else begin
      rising <= _GEN_10;
    end
    if (reset) begin // @[intervox_transmitter.scala 164:34]
      change <= 1'h0; // @[intervox_transmitter.scala 164:34]
    end else if (change) begin // @[intervox_transmitter.scala 206:25]
      change <= 1'h0; // @[intervox_transmitter.scala 207:16]
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
  input   clock,
  input   reset,
  output  io_MCLK_O,
  input   io_BCLK_IN,
  input   io_LRCLK_IN,
  input   io_SDATA_IN,
  output  io_DATA_O,
  output  io_LRCLK_O,
  output  io_BCLK_O,
  output  io_SDATA_O,
  output  io_NXT_FRAME
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
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 244:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 244:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 244:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 244:33]
  wire  bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 244:33]
  wire  bi_phase_enc_io_CLK; // @[intervox_transmitter.scala 244:33]
  wire  bi_phase_enc_io_TRIG; // @[intervox_transmitter.scala 244:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 250:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 250:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 250:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 250:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 251:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 251:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 251:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 251:33]
  wire  LREDGE_clock; // @[intervox_transmitter.scala 253:33]
  wire  LREDGE_reset; // @[intervox_transmitter.scala 253:33]
  wire  LREDGE_io_INPUT; // @[intervox_transmitter.scala 253:33]
  wire  LREDGE_io_TRAIL; // @[intervox_transmitter.scala 253:33]
  wire  LREDGE_io_CHANGE; // @[intervox_transmitter.scala 253:33]
  wire  BCLKEDGE_clock; // @[intervox_transmitter.scala 255:33]
  wire  BCLKEDGE_reset; // @[intervox_transmitter.scala 255:33]
  wire  BCLKEDGE_io_INPUT; // @[intervox_transmitter.scala 255:33]
  wire  BCLKEDGE_io_TRAIL; // @[intervox_transmitter.scala 255:33]
  wire  BCLKEDGE_io_CHANGE; // @[intervox_transmitter.scala 255:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 230:34]
  reg  syncing; // @[intervox_transmitter.scala 232:34]
  reg  synced; // @[intervox_transmitter.scala 233:34]
  reg [3:0] clkCntr1; // @[intervox_transmitter.scala 237:35]
  reg  fuckyou; // @[intervox_transmitter.scala 238:35]
  reg  encoderClk; // @[intervox_transmitter.scala 246:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 248:34]
  wire  _GEN_0 = LREDGE_io_TRAIL | syncing; // @[intervox_transmitter.scala 303:34 304:15 232:34]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 307:30]
  wire  _GEN_1 = bitCntr == 8'h7c | synced; // @[intervox_transmitter.scala 309:30 310:19 233:34]
  wire [7:0] _GEN_2 = bitCntr == 8'h7c ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 307:19 309:30 311:19]
  wire [7:0] _GEN_3 = syncing ? _GEN_2 : bitCntr; // @[intervox_transmitter.scala 306:27 248:34]
  wire [7:0] _GEN_6 = ~synced ? _GEN_3 : bitCntr; // @[intervox_transmitter.scala 301:23 248:34]
  wire [3:0] _clkCntr1_T_1 = clkCntr1 + 4'h1; // @[intervox_transmitter.scala 347:30]
  wire [3:0] _GEN_8 = clkCntr1 == 4'h3 ? 4'h0 : _clkCntr1_T_1; // @[intervox_transmitter.scala 347:18 348:{31,41}]
  wire  _T_9 = clkCntr1 == 4'h1; // @[intervox_transmitter.scala 350:23]
  wire  _T_12 = ~io_SDATA_IN; // @[intervox_transmitter.scala 371:30]
  wire [7:0] _BFR_io_dataIn_T_1 = 8'h48 - bitCntr; // @[intervox_transmitter.scala 373:67]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 373:58]
  wire [255:0] _GEN_68 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 373:51]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_68 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 373:51]
  wire [255:0] _GEN_11 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 371:38 373:33]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 377:58]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_68 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 377:51]
  wire [255:0] _GEN_12 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_11; // @[intervox_transmitter.scala 376:38 377:33]
  wire [7:0] _BFR_io_dataIn_T_11 = 8'h40 - bitCntr; // @[intervox_transmitter.scala 387:67]
  wire [255:0] _BFR_io_dataIn_T_12 = 256'h0 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 387:58]
  wire [255:0] _BFR_io_dataIn_T_14 = _GEN_68 + _BFR_io_dataIn_T_12; // @[intervox_transmitter.scala 387:51]
  wire [255:0] _GEN_13 = _T_12 ? _BFR_io_dataIn_T_14 : 256'h0; // @[intervox_transmitter.scala 385:39 387:33]
  wire [255:0] _BFR_io_dataIn_T_17 = 256'h1 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 391:58]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_68 + _BFR_io_dataIn_T_17; // @[intervox_transmitter.scala 391:51]
  wire [255:0] _GEN_14 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_13; // @[intervox_transmitter.scala 390:38 391:33]
  wire [255:0] _GEN_16 = bitCntr > 8'h1f ? _GEN_12 : _GEN_14; // @[intervox_transmitter.scala 364:31]
  wire  _T_16 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 410:25]
  wire [78:0] _GEN_17 = fuckyou ? 79'haaaa000000000000 : 79'haaab000000000000; // @[intervox_transmitter.scala 418:34 419:33 421:33]
  wire  _GEN_20 = bitCntr == 8'h3f ? ~fuckyou : fuckyou; // @[intervox_transmitter.scala 410:35 416:21 238:35]
  wire [78:0] _GEN_21 = bitCntr == 8'h3f ? _GEN_17 : {{15'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 273:25 410:35]
  wire [255:0] _GEN_22 = bitCntr == 8'h3f ? 256'h0 : _GEN_16; // @[intervox_transmitter.scala 410:35 428:28]
  wire [7:0] _GEN_23 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 353:19 410:35 430:21]
  wire [7:0] _GEN_24 = clkCntr1 == 4'h1 ? _GEN_23 : _GEN_6; // @[intervox_transmitter.scala 350:31]
  wire [255:0] _GEN_26 = clkCntr1 == 4'h1 ? _GEN_22 : 256'h0; // @[intervox_transmitter.scala 269:25 350:31]
  wire  _GEN_27 = clkCntr1 == 4'h1 & _T_16; // @[intervox_transmitter.scala 272:25 350:31]
  wire  _GEN_28 = clkCntr1 == 4'h1 ? _GEN_20 : fuckyou; // @[intervox_transmitter.scala 350:31 238:35]
  wire [78:0] _GEN_29 = clkCntr1 == 4'h1 ? _GEN_21 : {{15'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 273:25 350:31]
  wire  _GEN_31 = synced ? ~encoderClk : encoderClk; // @[intervox_transmitter.scala 335:27 345:20 246:34]
  wire [3:0] _GEN_32 = synced ? _GEN_8 : clkCntr1; // @[intervox_transmitter.scala 335:27 237:35]
  wire [7:0] _GEN_33 = synced ? _GEN_24 : _GEN_6; // @[intervox_transmitter.scala 335:27]
  wire  _GEN_34 = synced & _T_9; // @[intervox_transmitter.scala 268:25 335:27]
  wire [255:0] _GEN_35 = synced ? _GEN_26 : 256'h0; // @[intervox_transmitter.scala 269:25 335:27]
  wire  _GEN_36 = synced & _GEN_27; // @[intervox_transmitter.scala 272:25 335:27]
  wire  _GEN_37 = synced ? _GEN_28 : fuckyou; // @[intervox_transmitter.scala 335:27 238:35]
  wire [78:0] _GEN_38 = synced ? _GEN_29 : {{15'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 273:25 335:27]
  wire [255:0] _GEN_44 = 2'h2 == current_state ? _GEN_35 : 256'h0; // @[intervox_transmitter.scala 323:24 269:25]
  wire [78:0] _GEN_47 = 2'h2 == current_state ? _GEN_38 : {{15'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 323:24 273:25]
  wire  _GEN_49 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & synced; // @[intervox_transmitter.scala 323:24 279:31]
  wire  _GEN_53 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_34; // @[intervox_transmitter.scala 323:24 268:25]
  wire [255:0] _GEN_54 = 2'h1 == current_state ? 256'h0 : _GEN_44; // @[intervox_transmitter.scala 323:24 269:25]
  wire  _GEN_55 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_36; // @[intervox_transmitter.scala 323:24 272:25]
  wire [78:0] _GEN_57 = 2'h1 == current_state ? {{15'd0}, BFR_io_dataOut} : _GEN_47; // @[intervox_transmitter.scala 323:24 273:25]
  wire [255:0] _GEN_64 = 2'h0 == current_state ? 256'h0 : _GEN_54; // @[intervox_transmitter.scala 323:24 269:25]
  wire [78:0] _GEN_67 = 2'h0 == current_state ? {{15'd0}, BFR_io_dataOut} : _GEN_57; // @[intervox_transmitter.scala 323:24 273:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 244:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_ENA(bi_phase_enc_io_ENA),
    .io_CLK(bi_phase_enc_io_CLK),
    .io_TRIG(bi_phase_enc_io_TRIG)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 250:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 251:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  edgeDetector LREDGE ( // @[intervox_transmitter.scala 253:33]
    .clock(LREDGE_clock),
    .reset(LREDGE_reset),
    .io_INPUT(LREDGE_io_INPUT),
    .io_TRAIL(LREDGE_io_TRAIL),
    .io_CHANGE(LREDGE_io_CHANGE)
  );
  edgeDetector BCLKEDGE ( // @[intervox_transmitter.scala 255:33]
    .clock(BCLKEDGE_clock),
    .reset(BCLKEDGE_reset),
    .io_INPUT(BCLKEDGE_io_INPUT),
    .io_TRAIL(BCLKEDGE_io_TRAIL),
    .io_CHANGE(BCLKEDGE_io_CHANGE)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 260:25]
  assign io_DATA_O = bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 259:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 262:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 261:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 263:25]
  assign io_NXT_FRAME = bi_phase_enc_io_TRIG; // @[intervox_transmitter.scala 276:31]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 282:31]
  assign bi_phase_enc_io_ENA = 2'h0 == current_state ? 1'h0 : _GEN_49; // @[intervox_transmitter.scala 323:24 279:31]
  assign bi_phase_enc_io_CLK = encoderClk; // @[intervox_transmitter.scala 278:31]
  assign bi_phase_enc_io_TRIG = BCLKEDGE_io_CHANGE; // @[intervox_transmitter.scala 280:31]
  assign BFR_clock = clock;
  assign BFR_io_write = 2'h0 == current_state ? 1'h0 : _GEN_53; // @[intervox_transmitter.scala 323:24 268:25]
  assign BFR_io_dataIn = _GEN_64[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = 2'h0 == current_state ? 1'h0 : _GEN_55; // @[intervox_transmitter.scala 323:24 272:25]
  assign BFR1_io_dataIn = _GEN_67[63:0];
  assign LREDGE_clock = clock;
  assign LREDGE_reset = reset;
  assign LREDGE_io_INPUT = io_LRCLK_IN; // @[intervox_transmitter.scala 254:25]
  assign BCLKEDGE_clock = clock;
  assign BCLKEDGE_reset = reset;
  assign BCLKEDGE_io_INPUT = io_BCLK_IN; // @[intervox_transmitter.scala 256:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 230:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 230:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 323:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 327:21]
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 323:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 331:21]
    end
    if (reset) begin // @[intervox_transmitter.scala 232:34]
      syncing <= 1'h0; // @[intervox_transmitter.scala 232:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 301:23]
      syncing <= _GEN_0;
    end
    if (reset) begin // @[intervox_transmitter.scala 233:34]
      synced <= 1'h0; // @[intervox_transmitter.scala 233:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 301:23]
      if (syncing) begin // @[intervox_transmitter.scala 306:27]
        synced <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 237:35]
      clkCntr1 <= 4'h0; // @[intervox_transmitter.scala 237:35]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 323:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 323:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 323:24]
          clkCntr1 <= _GEN_32;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 238:35]
      fuckyou <= 1'h0; // @[intervox_transmitter.scala 238:35]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 323:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 323:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 323:24]
          fuckyou <= _GEN_37;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 246:34]
      encoderClk <= 1'h0; // @[intervox_transmitter.scala 246:34]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 323:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 323:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 323:24]
          encoderClk <= _GEN_31;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 248:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 248:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 323:24]
      bitCntr <= _GEN_6;
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 323:24]
      bitCntr <= _GEN_6;
    end else if (2'h2 == current_state) begin // @[intervox_transmitter.scala 323:24]
      bitCntr <= _GEN_33;
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
  current_state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  syncing = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  synced = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  clkCntr1 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  fuckyou = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  encoderClk = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  bitCntr = _RAND_6[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
