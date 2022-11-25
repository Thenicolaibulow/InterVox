module bi_phase_encoder(
  input         clock,
  input         reset,
  output        io_DATA_OUT,
  input  [63:0] io_AUDIOINPUT,
  input         io_ENA
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  outReg; // @[intervox_transmitter.scala 38:32]
  reg [63:0] stereoData; // @[intervox_transmitter.scala 40:32]
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 43:32]
  reg  hasNone; // @[intervox_transmitter.scala 44:32]
  reg  holdState; // @[intervox_transmitter.scala 45:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 46:32]
  reg  ndexR; // @[intervox_transmitter.scala 55:32]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 61:36]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 67:34]
  wire  _outReg_T = ~outReg; // @[intervox_transmitter.scala 75:23]
  wire  _GEN_1 = ~holdState | holdState; // @[intervox_transmitter.scala 73:34 74:23 45:32]
  wire  _GEN_2 = ~holdState ? ~outReg : outReg; // @[intervox_transmitter.scala 73:34 75:20 38:32]
  wire  _GEN_4 = bitCntr_enc < 8'h6 ? _GEN_2 : outReg; // @[intervox_transmitter.scala 38:32 71:32]
  wire  _GEN_5 = bitCntr_enc == 8'h6 ? _outReg_T : _GEN_4; // @[intervox_transmitter.scala 78:34 80:18]
  wire [5:0] _T_9 = dataIndex - 6'h3; // @[intervox_transmitter.scala 93:48]
  wire [6:0] _GEN_27 = {{1'd0}, _T_9}; // @[intervox_transmitter.scala 93:35]
  wire [6:0] _T_11 = 7'h40 - _GEN_27; // @[intervox_transmitter.scala 93:35]
  wire [63:0] _T_12 = stereoData >> _T_11; // @[intervox_transmitter.scala 93:29]
  wire  _GEN_7 = ~_T_12[0] | hasNone; // @[intervox_transmitter.scala 93:67 95:23 44:32]
  wire  _GEN_8 = bitCntr_enc < 8'h37 ? _GEN_7 : hasNone; // @[intervox_transmitter.scala 44:32 91:35]
  wire [5:0] _T_19 = dataIndex - 6'h1b; // @[intervox_transmitter.scala 100:49]
  wire [6:0] _GEN_28 = {{1'd0}, _T_19}; // @[intervox_transmitter.scala 100:36]
  wire [6:0] _T_21 = 7'h40 - _GEN_28; // @[intervox_transmitter.scala 100:36]
  wire [63:0] _T_22 = stereoData >> _T_21; // @[intervox_transmitter.scala 100:29]
  wire  _GEN_9 = ~_T_22[0] | _GEN_8; // @[intervox_transmitter.scala 100:70 102:23]
  wire  _GEN_10 = bitCntr_enc >= 8'h37 & bitCntr_enc < 8'h67 ? _GEN_9 : _GEN_8; // @[intervox_transmitter.scala 98:62]
  wire [5:0] _T_29 = dataIndex - 6'h34; // @[intervox_transmitter.scala 110:40]
  wire [15:0] _T_30 = 16'h0 >> _T_29; // @[intervox_transmitter.scala 110:28]
  wire  _GEN_11 = ~_T_30[0] | _GEN_10; // @[intervox_transmitter.scala 110:60 112:23]
  wire  _GEN_12 = bitCntr_enc >= 8'h67 & bitCntr_enc < 8'h7f ? _GEN_11 : _GEN_10; // @[intervox_transmitter.scala 106:63]
  wire [6:0] _GEN_29 = {{1'd0}, dataIndex}; // @[intervox_transmitter.scala 120:41]
  wire [6:0] _T_37 = _GEN_29 - 7'h40; // @[intervox_transmitter.scala 120:41]
  wire [63:0] _T_38 = 64'h0 >> _T_37; // @[intervox_transmitter.scala 120:29]
  wire  _GEN_13 = ~_T_38[0] | _GEN_12; // @[intervox_transmitter.scala 120:61 122:23]
  wire  _GEN_14 = bitCntr_enc >= 8'h7f & bitCntr_enc < 8'hff ? _GEN_13 : _GEN_12; // @[intervox_transmitter.scala 116:63]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 48:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 59:25]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 87:34]
        if (!(hasNone)) begin // @[intervox_transmitter.scala 126:32]
          outReg <= _outReg_T; // @[intervox_transmitter.scala 132:20]
        end
      end else if (bitCntr_enc == 8'h7) begin // @[intervox_transmitter.scala 82:34]
        outReg <= _outReg_T; // @[intervox_transmitter.scala 83:18]
      end else begin
        outReg <= _GEN_5;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 40:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 40:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 50:17]
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 59:25]
      if (bitCntr_enc == 8'hff) begin // @[intervox_transmitter.scala 136:36]
        bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 137:23]
      end else begin
        bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 61:21]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 44:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 44:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 59:25]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 87:34]
        if (hasNone) begin // @[intervox_transmitter.scala 126:32]
          hasNone <= 1'h0; // @[intervox_transmitter.scala 128:21]
        end else begin
          hasNone <= _GEN_14;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 45:32]
      holdState <= 1'h0; // @[intervox_transmitter.scala 45:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 59:25]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 87:34]
        holdState <= 1'h0; // @[intervox_transmitter.scala 88:21]
      end else if (bitCntr_enc < 8'h6) begin // @[intervox_transmitter.scala 71:32]
        holdState <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 46:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 46:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 59:25]
      if (ndexR) begin // @[intervox_transmitter.scala 65:28]
        dataIndex <= _dataIndex_T_1; // @[intervox_transmitter.scala 67:21]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 55:32]
      ndexR <= 1'h0; // @[intervox_transmitter.scala 55:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 59:25]
      ndexR <= ~ndexR; // @[intervox_transmitter.scala 64:15]
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
  holdState = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  dataIndex = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  ndexR = _RAND_6[0:0];
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
`endif // RANDOMIZE_REG_INIT
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 170:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 170:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 170:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 170:33]
  wire  bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 170:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 174:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 174:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 174:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 174:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 175:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 175:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 175:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 175:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 158:34]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 160:34]
  reg  synced; // @[intervox_transmitter.scala 166:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 172:34]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 221:42]
  wire [7:0] _GEN_0 = io_LRCLK_IN ? 8'h0 : bitCntr; // @[intervox_transmitter.scala 226:32 227:17 172:34]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 231:28]
  wire [7:0] _GEN_1 = bitCntr == 8'h1f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 231:17 233:31 234:19]
  wire  _GEN_2 = bitCntr == 8'h1f | synced; // @[intervox_transmitter.scala 233:31 235:18 166:34]
  wire [7:0] _GEN_3 = ~io_LRCLK_IN ? _GEN_1 : _GEN_0; // @[intervox_transmitter.scala 230:32]
  wire [7:0] _GEN_5 = BiPhase_CLK_CNTR == 8'h3 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 221:22 223:35 224:24]
  wire [7:0] _GEN_6 = BiPhase_CLK_CNTR == 8'h3 ? _GEN_3 : bitCntr; // @[intervox_transmitter.scala 172:34 223:35]
  wire [7:0] _GEN_8 = ~synced ? _GEN_5 : BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 219:23 160:34]
  wire [7:0] _GEN_9 = ~synced ? _GEN_6 : bitCntr; // @[intervox_transmitter.scala 219:23 172:34]
  wire  _T_9 = BiPhase_CLK_CNTR == 8'h1; // @[intervox_transmitter.scala 269:31]
  wire  _T_12 = ~io_SDATA_IN; // @[intervox_transmitter.scala 290:30]
  wire [7:0] _BFR_io_dataIn_T_1 = 8'h48 - bitCntr; // @[intervox_transmitter.scala 292:67]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 292:58]
  wire [255:0] _GEN_61 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 292:51]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_61 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 292:51]
  wire [255:0] _GEN_13 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 290:38 292:33]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 296:58]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_61 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 296:51]
  wire [255:0] _GEN_14 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_13; // @[intervox_transmitter.scala 295:38 296:33]
  wire [7:0] _BFR_io_dataIn_T_11 = 8'h40 - bitCntr; // @[intervox_transmitter.scala 306:67]
  wire [255:0] _BFR_io_dataIn_T_12 = 256'h0 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 306:58]
  wire [255:0] _BFR_io_dataIn_T_14 = _GEN_61 + _BFR_io_dataIn_T_12; // @[intervox_transmitter.scala 306:51]
  wire [255:0] _GEN_15 = _T_12 ? _BFR_io_dataIn_T_14 : 256'h0; // @[intervox_transmitter.scala 304:39 306:33]
  wire [255:0] _BFR_io_dataIn_T_17 = 256'h1 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 310:58]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_61 + _BFR_io_dataIn_T_17; // @[intervox_transmitter.scala 310:51]
  wire [255:0] _GEN_16 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_15; // @[intervox_transmitter.scala 309:38 310:33]
  wire [255:0] _GEN_18 = bitCntr > 8'h1f ? _GEN_14 : _GEN_16; // @[intervox_transmitter.scala 283:31]
  wire  _T_16 = bitCntr == 8'h7f; // @[intervox_transmitter.scala 314:24]
  wire [63:0] _GEN_21 = BFR_io_dataOut; // @[intervox_transmitter.scala 192:25 314:34 319:31]
  wire [255:0] _GEN_22 = bitCntr == 8'h7f ? 256'h0 : _GEN_18; // @[intervox_transmitter.scala 314:34 323:28]
  wire [7:0] _GEN_23 = bitCntr == 8'h7f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 273:19 314:34 325:21]
  wire [7:0] _GEN_24 = BiPhase_CLK_CNTR == 8'h1 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 263:26 269:39 270:28]
  wire [7:0] _GEN_25 = BiPhase_CLK_CNTR == 8'h1 ? _GEN_23 : _GEN_9; // @[intervox_transmitter.scala 269:39]
  wire [255:0] _GEN_27 = BiPhase_CLK_CNTR == 8'h1 ? _GEN_22 : 256'h0; // @[intervox_transmitter.scala 188:25 269:39]
  wire  _GEN_28 = BiPhase_CLK_CNTR == 8'h1 & _T_16; // @[intervox_transmitter.scala 191:25 269:39]
  wire [63:0] _GEN_29 = BiPhase_CLK_CNTR == 8'h1 ? _GEN_21 : BFR_io_dataOut; // @[intervox_transmitter.scala 192:25 269:39]
  wire [7:0] _GEN_31 = 2'h2 == current_state ? _GEN_24 : _GEN_8; // @[intervox_transmitter.scala 249:26]
  wire [7:0] _GEN_32 = 2'h2 == current_state ? _GEN_25 : _GEN_9; // @[intervox_transmitter.scala 249:26]
  wire [255:0] _GEN_34 = 2'h2 == current_state ? _GEN_27 : 256'h0; // @[intervox_transmitter.scala 188:25 249:26]
  wire [63:0] _GEN_36 = 2'h2 == current_state ? _GEN_29 : BFR_io_dataOut; // @[intervox_transmitter.scala 192:25 249:26]
  wire  _GEN_38 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state; // @[intervox_transmitter.scala 249:26 198:31]
  wire  _GEN_41 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _T_9; // @[intervox_transmitter.scala 187:25 249:26]
  wire [255:0] _GEN_42 = 2'h1 == current_state ? 256'h0 : _GEN_34; // @[intervox_transmitter.scala 188:25 249:26]
  wire  _GEN_43 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_28; // @[intervox_transmitter.scala 191:25 249:26]
  wire [63:0] _GEN_44 = 2'h1 == current_state ? BFR_io_dataOut : _GEN_36; // @[intervox_transmitter.scala 192:25 249:26]
  wire  _GEN_46 = 2'h0 == current_state ? 1'h0 : _GEN_38; // @[intervox_transmitter.scala 249:26 198:31]
  wire  _GEN_49 = 2'h0 == current_state ? 1'h0 : _GEN_41; // @[intervox_transmitter.scala 187:25 249:26]
  wire [255:0] _GEN_50 = 2'h0 == current_state ? 256'h0 : _GEN_42; // @[intervox_transmitter.scala 188:25 249:26]
  wire  _GEN_51 = 2'h0 == current_state ? 1'h0 : _GEN_43; // @[intervox_transmitter.scala 191:25 249:26]
  wire [63:0] _GEN_52 = 2'h0 == current_state ? BFR_io_dataOut : _GEN_44; // @[intervox_transmitter.scala 192:25 249:26]
  wire [255:0] _GEN_58 = synced ? _GEN_50 : 256'h0; // @[intervox_transmitter.scala 247:23 188:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 170:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_ENA(bi_phase_enc_io_ENA)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 174:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 175:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 179:25]
  assign io_DATA_O = bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 178:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 181:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 180:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 182:25]
  assign io_NXT_FRAME = bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 195:31]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 200:31]
  assign bi_phase_enc_io_ENA = synced & _GEN_46; // @[intervox_transmitter.scala 247:23 198:31]
  assign BFR_clock = clock;
  assign BFR_io_write = synced & _GEN_49; // @[intervox_transmitter.scala 247:23 187:25]
  assign BFR_io_dataIn = _GEN_58[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = synced & _GEN_51; // @[intervox_transmitter.scala 247:23 191:25]
  assign BFR1_io_dataIn = synced ? _GEN_52 : BFR_io_dataOut; // @[intervox_transmitter.scala 247:23 192:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 158:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 158:34]
    end else if (synced) begin // @[intervox_transmitter.scala 247:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 249:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 253:23]
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 249:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 257:23]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 160:34]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 160:34]
    end else if (synced) begin // @[intervox_transmitter.scala 247:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 249:26]
        BiPhase_CLK_CNTR <= _GEN_8;
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 249:26]
        BiPhase_CLK_CNTR <= _GEN_8;
      end else begin
        BiPhase_CLK_CNTR <= _GEN_31;
      end
    end else begin
      BiPhase_CLK_CNTR <= _GEN_8;
    end
    if (reset) begin // @[intervox_transmitter.scala 166:34]
      synced <= 1'h0; // @[intervox_transmitter.scala 166:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 219:23]
      if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 223:35]
        if (~io_LRCLK_IN) begin // @[intervox_transmitter.scala 230:32]
          synced <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 172:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 172:34]
    end else if (synced) begin // @[intervox_transmitter.scala 247:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 249:26]
        bitCntr <= _GEN_9;
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 249:26]
        bitCntr <= _GEN_9;
      end else begin
        bitCntr <= _GEN_32;
      end
    end else begin
      bitCntr <= _GEN_9;
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
  BiPhase_CLK_CNTR = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  synced = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bitCntr = _RAND_3[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
