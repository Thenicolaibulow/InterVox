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
`endif // RANDOMIZE_REG_INIT
  reg  outReg; // @[intervox_transmitter.scala 38:32]
  reg [63:0] stereoData; // @[intervox_transmitter.scala 40:32]
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 43:32]
  reg  hasNone; // @[intervox_transmitter.scala 44:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 45:32]
  reg  ndexR; // @[intervox_transmitter.scala 54:32]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 60:36]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 66:34]
  wire  _T_3 = bitCntr_enc < 8'h6; // @[intervox_transmitter.scala 73:28]
  wire  _GEN_1 = _T_3 ? 1'h0 : 1'h1; // @[intervox_transmitter.scala 74:11 75:20 79:20]
  wire [5:0] _T_7 = dataIndex - 6'h3; // @[intervox_transmitter.scala 88:48]
  wire [6:0] _GEN_21 = {{1'd0}, _T_7}; // @[intervox_transmitter.scala 88:35]
  wire [6:0] _T_9 = 7'h40 - _GEN_21; // @[intervox_transmitter.scala 88:35]
  wire [63:0] _T_10 = stereoData >> _T_9; // @[intervox_transmitter.scala 88:29]
  wire  _GEN_3 = ~_T_10[0] | hasNone; // @[intervox_transmitter.scala 88:67 90:23 44:32]
  wire  _GEN_4 = bitCntr_enc < 8'h37 ? _GEN_3 : hasNone; // @[intervox_transmitter.scala 44:32 86:35]
  wire [5:0] _T_17 = dataIndex - 6'h1b; // @[intervox_transmitter.scala 95:49]
  wire [6:0] _GEN_22 = {{1'd0}, _T_17}; // @[intervox_transmitter.scala 95:36]
  wire [6:0] _T_19 = 7'h40 - _GEN_22; // @[intervox_transmitter.scala 95:36]
  wire [63:0] _T_20 = stereoData >> _T_19; // @[intervox_transmitter.scala 95:29]
  wire  _GEN_5 = ~_T_20[0] | _GEN_4; // @[intervox_transmitter.scala 95:70 97:23]
  wire  _GEN_6 = bitCntr_enc >= 8'h37 & bitCntr_enc < 8'h67 ? _GEN_5 : _GEN_4; // @[intervox_transmitter.scala 93:62]
  wire [5:0] _T_27 = dataIndex - 6'h34; // @[intervox_transmitter.scala 105:40]
  wire [15:0] _T_28 = 16'h0 >> _T_27; // @[intervox_transmitter.scala 105:28]
  wire  _GEN_7 = ~_T_28[0] | _GEN_6; // @[intervox_transmitter.scala 105:60 107:23]
  wire  _GEN_8 = bitCntr_enc >= 8'h67 & bitCntr_enc < 8'h7f ? _GEN_7 : _GEN_6; // @[intervox_transmitter.scala 101:63]
  wire [6:0] _GEN_23 = {{1'd0}, dataIndex}; // @[intervox_transmitter.scala 115:41]
  wire [6:0] _T_35 = _GEN_23 - 7'h40; // @[intervox_transmitter.scala 115:41]
  wire [63:0] _T_36 = 64'h0 >> _T_35; // @[intervox_transmitter.scala 115:29]
  wire  _GEN_9 = ~_T_36[0] | _GEN_8; // @[intervox_transmitter.scala 115:61 117:23]
  wire  _GEN_10 = bitCntr_enc >= 8'h7f & bitCntr_enc < 8'hff ? _GEN_9 : _GEN_8; // @[intervox_transmitter.scala 111:63]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 47:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 58:25]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 83:34]
        if (!(hasNone)) begin // @[intervox_transmitter.scala 121:32]
          outReg <= ~outReg; // @[intervox_transmitter.scala 127:20]
        end
      end else if (bitCntr_enc < 8'h7) begin // @[intervox_transmitter.scala 70:33]
        outReg <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 40:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 40:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 49:17]
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 58:25]
      if (bitCntr_enc == 8'hff) begin // @[intervox_transmitter.scala 131:36]
        bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 132:23]
      end else begin
        bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 60:21]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 44:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 44:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 58:25]
      if (bitCntr_enc > 8'h7) begin // @[intervox_transmitter.scala 83:34]
        if (hasNone) begin // @[intervox_transmitter.scala 121:32]
          hasNone <= 1'h0; // @[intervox_transmitter.scala 123:21]
        end else begin
          hasNone <= _GEN_10;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 45:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 45:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 58:25]
      if (ndexR) begin // @[intervox_transmitter.scala 64:28]
        dataIndex <= _dataIndex_T_1; // @[intervox_transmitter.scala 66:21]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 54:32]
      ndexR <= 1'h0; // @[intervox_transmitter.scala 54:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 58:25]
      ndexR <= ~ndexR; // @[intervox_transmitter.scala 63:15]
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
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 165:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 165:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 165:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 165:33]
  wire  bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 165:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 169:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 169:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 169:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 169:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 170:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 170:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 170:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 170:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 153:34]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 155:34]
  reg  synced; // @[intervox_transmitter.scala 161:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 167:34]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 216:42]
  wire [7:0] _GEN_0 = io_LRCLK_IN ? 8'h0 : bitCntr; // @[intervox_transmitter.scala 221:32 222:17 167:34]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 226:28]
  wire [7:0] _GEN_1 = bitCntr == 8'h1f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 226:17 228:31 229:19]
  wire  _GEN_2 = bitCntr == 8'h1f | synced; // @[intervox_transmitter.scala 228:31 230:18 161:34]
  wire [7:0] _GEN_3 = ~io_LRCLK_IN ? _GEN_1 : _GEN_0; // @[intervox_transmitter.scala 225:32]
  wire [7:0] _GEN_5 = BiPhase_CLK_CNTR == 8'h3 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 216:22 218:35 219:24]
  wire [7:0] _GEN_6 = BiPhase_CLK_CNTR == 8'h3 ? _GEN_3 : bitCntr; // @[intervox_transmitter.scala 167:34 218:35]
  wire [7:0] _GEN_8 = ~synced ? _GEN_5 : BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 214:23 155:34]
  wire [7:0] _GEN_9 = ~synced ? _GEN_6 : bitCntr; // @[intervox_transmitter.scala 214:23 167:34]
  wire  _T_9 = BiPhase_CLK_CNTR == 8'h1; // @[intervox_transmitter.scala 264:31]
  wire  _T_12 = ~io_SDATA_IN; // @[intervox_transmitter.scala 285:30]
  wire [7:0] _BFR_io_dataIn_T_1 = 8'h48 - bitCntr; // @[intervox_transmitter.scala 287:67]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 287:58]
  wire [255:0] _GEN_61 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 287:51]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_61 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 287:51]
  wire [255:0] _GEN_13 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 285:38 287:33]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 291:58]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_61 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 291:51]
  wire [255:0] _GEN_14 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_13; // @[intervox_transmitter.scala 290:38 291:33]
  wire [7:0] _BFR_io_dataIn_T_11 = 8'h40 - bitCntr; // @[intervox_transmitter.scala 301:67]
  wire [255:0] _BFR_io_dataIn_T_12 = 256'h0 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 301:58]
  wire [255:0] _BFR_io_dataIn_T_14 = _GEN_61 + _BFR_io_dataIn_T_12; // @[intervox_transmitter.scala 301:51]
  wire [255:0] _GEN_15 = _T_12 ? _BFR_io_dataIn_T_14 : 256'h0; // @[intervox_transmitter.scala 299:39 301:33]
  wire [255:0] _BFR_io_dataIn_T_17 = 256'h1 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 305:58]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_61 + _BFR_io_dataIn_T_17; // @[intervox_transmitter.scala 305:51]
  wire [255:0] _GEN_16 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_15; // @[intervox_transmitter.scala 304:38 305:33]
  wire [255:0] _GEN_18 = bitCntr > 8'h1f ? _GEN_14 : _GEN_16; // @[intervox_transmitter.scala 278:31]
  wire  _T_16 = bitCntr == 8'h7f; // @[intervox_transmitter.scala 309:24]
  wire [63:0] _GEN_21 = BFR_io_dataOut; // @[intervox_transmitter.scala 187:25 309:34 314:31]
  wire [255:0] _GEN_22 = bitCntr == 8'h7f ? 256'h0 : _GEN_18; // @[intervox_transmitter.scala 309:34 318:28]
  wire [7:0] _GEN_23 = bitCntr == 8'h7f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 268:19 309:34 320:21]
  wire [7:0] _GEN_24 = BiPhase_CLK_CNTR == 8'h1 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 258:26 264:39 265:28]
  wire [7:0] _GEN_25 = BiPhase_CLK_CNTR == 8'h1 ? _GEN_23 : _GEN_9; // @[intervox_transmitter.scala 264:39]
  wire [255:0] _GEN_27 = BiPhase_CLK_CNTR == 8'h1 ? _GEN_22 : 256'h0; // @[intervox_transmitter.scala 183:25 264:39]
  wire  _GEN_28 = BiPhase_CLK_CNTR == 8'h1 & _T_16; // @[intervox_transmitter.scala 186:25 264:39]
  wire [63:0] _GEN_29 = BiPhase_CLK_CNTR == 8'h1 ? _GEN_21 : BFR_io_dataOut; // @[intervox_transmitter.scala 187:25 264:39]
  wire [7:0] _GEN_31 = 2'h2 == current_state ? _GEN_24 : _GEN_8; // @[intervox_transmitter.scala 244:26]
  wire [7:0] _GEN_32 = 2'h2 == current_state ? _GEN_25 : _GEN_9; // @[intervox_transmitter.scala 244:26]
  wire [255:0] _GEN_34 = 2'h2 == current_state ? _GEN_27 : 256'h0; // @[intervox_transmitter.scala 183:25 244:26]
  wire [63:0] _GEN_36 = 2'h2 == current_state ? _GEN_29 : BFR_io_dataOut; // @[intervox_transmitter.scala 187:25 244:26]
  wire  _GEN_38 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state; // @[intervox_transmitter.scala 244:26 193:31]
  wire  _GEN_41 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _T_9; // @[intervox_transmitter.scala 182:25 244:26]
  wire [255:0] _GEN_42 = 2'h1 == current_state ? 256'h0 : _GEN_34; // @[intervox_transmitter.scala 183:25 244:26]
  wire  _GEN_43 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_28; // @[intervox_transmitter.scala 186:25 244:26]
  wire [63:0] _GEN_44 = 2'h1 == current_state ? BFR_io_dataOut : _GEN_36; // @[intervox_transmitter.scala 187:25 244:26]
  wire  _GEN_46 = 2'h0 == current_state ? 1'h0 : _GEN_38; // @[intervox_transmitter.scala 244:26 193:31]
  wire  _GEN_49 = 2'h0 == current_state ? 1'h0 : _GEN_41; // @[intervox_transmitter.scala 182:25 244:26]
  wire [255:0] _GEN_50 = 2'h0 == current_state ? 256'h0 : _GEN_42; // @[intervox_transmitter.scala 183:25 244:26]
  wire  _GEN_51 = 2'h0 == current_state ? 1'h0 : _GEN_43; // @[intervox_transmitter.scala 186:25 244:26]
  wire [63:0] _GEN_52 = 2'h0 == current_state ? BFR_io_dataOut : _GEN_44; // @[intervox_transmitter.scala 187:25 244:26]
  wire [255:0] _GEN_58 = synced ? _GEN_50 : 256'h0; // @[intervox_transmitter.scala 242:23 183:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 165:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_ENA(bi_phase_enc_io_ENA)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 169:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 170:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 174:25]
  assign io_DATA_O = bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 173:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 176:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 175:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 177:25]
  assign io_NXT_FRAME = bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 190:31]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 195:31]
  assign bi_phase_enc_io_ENA = synced & _GEN_46; // @[intervox_transmitter.scala 242:23 193:31]
  assign BFR_clock = clock;
  assign BFR_io_write = synced & _GEN_49; // @[intervox_transmitter.scala 242:23 182:25]
  assign BFR_io_dataIn = _GEN_58[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = synced & _GEN_51; // @[intervox_transmitter.scala 242:23 186:25]
  assign BFR1_io_dataIn = synced ? _GEN_52 : BFR_io_dataOut; // @[intervox_transmitter.scala 242:23 187:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 153:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 153:34]
    end else if (synced) begin // @[intervox_transmitter.scala 242:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 244:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 248:23]
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 244:26]
        current_state <= 2'h2; // @[intervox_transmitter.scala 252:23]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 155:34]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 155:34]
    end else if (synced) begin // @[intervox_transmitter.scala 242:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 244:26]
        BiPhase_CLK_CNTR <= _GEN_8;
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 244:26]
        BiPhase_CLK_CNTR <= _GEN_8;
      end else begin
        BiPhase_CLK_CNTR <= _GEN_31;
      end
    end else begin
      BiPhase_CLK_CNTR <= _GEN_8;
    end
    if (reset) begin // @[intervox_transmitter.scala 161:34]
      synced <= 1'h0; // @[intervox_transmitter.scala 161:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 214:23]
      if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 218:35]
        if (~io_LRCLK_IN) begin // @[intervox_transmitter.scala 225:32]
          synced <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 167:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 167:34]
    end else if (synced) begin // @[intervox_transmitter.scala 242:23]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 244:26]
        bitCntr <= _GEN_9;
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 244:26]
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
