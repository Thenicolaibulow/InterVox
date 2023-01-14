module bi_phase_encoder(
  input         clock,
  input         reset,
  output        io_DATA_OUT,
  input  [63:0] io_AUDIOINPUT,
  input         io_ENA,
  input         io_TICK
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
  reg [63:0] stereoData; // @[intervox_transmitter.scala 39:32]
  reg [7:0] bitCntr_enc; // @[intervox_transmitter.scala 41:32]
  reg  hasNone; // @[intervox_transmitter.scala 42:32]
  reg [5:0] dataIndex; // @[intervox_transmitter.scala 43:32]
  reg  ndexR; // @[intervox_transmitter.scala 50:32]
  wire  _outReg_T = ~outReg; // @[intervox_transmitter.scala 66:23]
  wire  _GEN_0 = bitCntr_enc == 8'h3 ? ~outReg : outReg; // @[intervox_transmitter.scala 65:36 66:20 38:32]
  wire  _GEN_1 = bitCntr_enc == 8'h4 ? _outReg_T : _GEN_0; // @[intervox_transmitter.scala 69:36 70:20]
  wire  _GEN_2 = bitCntr_enc == 8'h4 ? 1'h0 : hasNone; // @[intervox_transmitter.scala 69:36 72:21 42:32]
  wire  _ndexR_T = ~ndexR; // @[intervox_transmitter.scala 84:22]
  wire [5:0] _dataIndex_T_1 = dataIndex + 6'h1; // @[intervox_transmitter.scala 87:38]
  wire [5:0] _GEN_3 = _ndexR_T ? _dataIndex_T_1 : dataIndex; // @[intervox_transmitter.scala 85:32 87:25 43:32]
  wire [6:0] _GEN_27 = {{1'd0}, _dataIndex_T_1}; // @[intervox_transmitter.scala 96:37]
  wire [6:0] _T_10 = 7'h40 - _GEN_27; // @[intervox_transmitter.scala 96:37]
  wire [63:0] _T_11 = stereoData >> _T_10; // @[intervox_transmitter.scala 96:31]
  wire  _GEN_4 = ~_T_11[0] | _GEN_2; // @[intervox_transmitter.scala 96:68 98:25]
  wire  _GEN_5 = bitCntr_enc <= 8'h35 ? _GEN_4 : _GEN_2; // @[intervox_transmitter.scala 94:38]
  wire [5:0] _T_18 = dataIndex - 6'h17; // @[intervox_transmitter.scala 108:51]
  wire [6:0] _GEN_28 = {{1'd0}, _T_18}; // @[intervox_transmitter.scala 108:38]
  wire [6:0] _T_20 = 7'h40 - _GEN_28; // @[intervox_transmitter.scala 108:38]
  wire [63:0] _T_21 = stereoData >> _T_20; // @[intervox_transmitter.scala 108:31]
  wire  _GEN_6 = ~_T_21[0] | _GEN_5; // @[intervox_transmitter.scala 108:71 109:25]
  wire  _GEN_7 = bitCntr_enc > 8'h35 & bitCntr_enc <= 8'h65 ? _GEN_6 : _GEN_5; // @[intervox_transmitter.scala 106:64]
  wire  _GEN_8 = bitCntr_enc > 8'h65 & bitCntr_enc < 8'h7f | _GEN_7; // @[intervox_transmitter.scala 118:64 122:23]
  wire  _GEN_9 = hasNone ? outReg : _outReg_T; // @[intervox_transmitter.scala 129:34 131:22 136:22]
  wire  _GEN_10 = hasNone ? 1'h0 : _GEN_8; // @[intervox_transmitter.scala 129:34 132:23]
  wire [5:0] _GEN_12 = bitCntr_enc >= 8'h5 ? _GEN_3 : dataIndex; // @[intervox_transmitter.scala 43:32 81:37]
  wire [7:0] _bitCntr_enc_T_1 = bitCntr_enc + 8'h1; // @[intervox_transmitter.scala 141:38]
  assign io_DATA_OUT = outReg; // @[intervox_transmitter.scala 45:17]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 38:32]
      outReg <= 1'h0; // @[intervox_transmitter.scala 38:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc >= 8'h5) begin // @[intervox_transmitter.scala 81:37]
          outReg <= _GEN_9;
        end else begin
          outReg <= _GEN_1;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 39:32]
      stereoData <= 64'h0; // @[intervox_transmitter.scala 39:32]
    end else begin
      stereoData <= io_AUDIOINPUT; // @[intervox_transmitter.scala 47:17]
    end
    if (reset) begin // @[intervox_transmitter.scala 41:32]
      bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 41:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 144:38]
          bitCntr_enc <= 8'h0; // @[intervox_transmitter.scala 145:25]
        end else begin
          bitCntr_enc <= _bitCntr_enc_T_1; // @[intervox_transmitter.scala 141:23]
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 42:32]
      hasNone <= 1'h0; // @[intervox_transmitter.scala 42:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc >= 8'h5) begin // @[intervox_transmitter.scala 81:37]
          hasNone <= _GEN_10;
        end else begin
          hasNone <= _GEN_2;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 43:32]
      dataIndex <= 6'h0; // @[intervox_transmitter.scala 43:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc == 8'h7f) begin // @[intervox_transmitter.scala 144:38]
          dataIndex <= 6'h0; // @[intervox_transmitter.scala 146:23]
        end else begin
          dataIndex <= _GEN_12;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 50:32]
      ndexR <= 1'h0; // @[intervox_transmitter.scala 50:32]
    end else if (io_ENA) begin // @[intervox_transmitter.scala 52:25]
      if (io_TICK) begin // @[intervox_transmitter.scala 56:28]
        if (bitCntr_enc >= 8'h5) begin // @[intervox_transmitter.scala 81:37]
          ndexR <= ~ndexR; // @[intervox_transmitter.scala 84:19]
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
  wire  bi_phase_enc_clock; // @[intervox_transmitter.scala 173:33]
  wire  bi_phase_enc_reset; // @[intervox_transmitter.scala 173:33]
  wire  bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 173:33]
  wire [63:0] bi_phase_enc_io_AUDIOINPUT; // @[intervox_transmitter.scala 173:33]
  wire  bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 173:33]
  wire  bi_phase_enc_io_TICK; // @[intervox_transmitter.scala 173:33]
  wire  BFR_clock; // @[intervox_transmitter.scala 179:33]
  wire  BFR_io_write; // @[intervox_transmitter.scala 179:33]
  wire [63:0] BFR_io_dataIn; // @[intervox_transmitter.scala 179:33]
  wire [63:0] BFR_io_dataOut; // @[intervox_transmitter.scala 179:33]
  wire  BFR1_clock; // @[intervox_transmitter.scala 180:33]
  wire  BFR1_io_write; // @[intervox_transmitter.scala 180:33]
  wire [63:0] BFR1_io_dataIn; // @[intervox_transmitter.scala 180:33]
  wire [63:0] BFR1_io_dataOut; // @[intervox_transmitter.scala 180:33]
  reg [1:0] current_state; // @[intervox_transmitter.scala 167:34]
  reg  synced; // @[intervox_transmitter.scala 169:34]
  reg  bclkR; // @[intervox_transmitter.scala 171:34]
  reg  encoderClk; // @[intervox_transmitter.scala 175:34]
  reg [7:0] bitCntr; // @[intervox_transmitter.scala 177:34]
  reg [1:0] inBufr; // @[intervox_transmitter.scala 182:34]
  reg  trailing; // @[intervox_transmitter.scala 183:34]
  wire [1:0] _inBufr_T_1 = inBufr + 2'h1; // @[intervox_transmitter.scala 238:34]
  wire [1:0] _inBufr_T_3 = inBufr - 2'h1; // @[intervox_transmitter.scala 244:34]
  wire [1:0] _GEN_1 = inBufr > 2'h0 ? _inBufr_T_3 : inBufr; // @[intervox_transmitter.scala 242:31 244:24 182:34]
  wire  _GEN_5 = ~inBufr[0] & inBufr[1] ? 1'h0 : trailing; // @[intervox_transmitter.scala 249:52 251:17 183:34]
  wire  _GEN_6 = inBufr[0] & ~inBufr[1] | _GEN_5; // @[intervox_transmitter.scala 254:52 255:17]
  wire [7:0] _bitCntr_T_1 = bitCntr + 8'h1; // @[intervox_transmitter.scala 261:30]
  wire  _GEN_8 = bitCntr == 8'h7e | synced; // @[intervox_transmitter.scala 263:30 264:19 169:34]
  wire [7:0] _GEN_9 = bitCntr == 8'h7e ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 261:19 263:30 265:19]
  wire [7:0] _GEN_10 = trailing ? _GEN_9 : bitCntr; // @[intervox_transmitter.scala 259:27 177:34]
  wire [7:0] _GEN_15 = ~synced ? _GEN_10 : bitCntr; // @[intervox_transmitter.scala 228:23 177:34]
  wire  _GEN_17 = io_BCLK_IN ? ~bclkR : bclkR; // @[intervox_transmitter.scala 301:33 302:17 171:34]
  wire  _T_25 = ~io_SDATA_IN; // @[intervox_transmitter.scala 327:30]
  wire [7:0] _BFR_io_dataIn_T_1 = 8'h48 - bitCntr; // @[intervox_transmitter.scala 329:67]
  wire [255:0] _BFR_io_dataIn_T_2 = 256'h0 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 329:58]
  wire [255:0] _GEN_70 = {{192'd0}, BFR_io_dataOut}; // @[intervox_transmitter.scala 329:51]
  wire [255:0] _BFR_io_dataIn_T_4 = _GEN_70 + _BFR_io_dataIn_T_2; // @[intervox_transmitter.scala 329:51]
  wire [255:0] _GEN_20 = ~io_SDATA_IN ? _BFR_io_dataIn_T_4 : 256'h0; // @[intervox_transmitter.scala 327:38 329:33]
  wire [255:0] _BFR_io_dataIn_T_7 = 256'h1 << _BFR_io_dataIn_T_1; // @[intervox_transmitter.scala 333:58]
  wire [255:0] _BFR_io_dataIn_T_9 = _GEN_70 + _BFR_io_dataIn_T_7; // @[intervox_transmitter.scala 333:51]
  wire [255:0] _GEN_21 = io_SDATA_IN ? _BFR_io_dataIn_T_9 : _GEN_20; // @[intervox_transmitter.scala 332:38 333:33]
  wire [7:0] _BFR_io_dataIn_T_11 = 8'h40 - bitCntr; // @[intervox_transmitter.scala 343:67]
  wire [255:0] _BFR_io_dataIn_T_12 = 256'h0 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 343:58]
  wire [255:0] _BFR_io_dataIn_T_14 = _GEN_70 + _BFR_io_dataIn_T_12; // @[intervox_transmitter.scala 343:51]
  wire [255:0] _GEN_22 = _T_25 ? _BFR_io_dataIn_T_14 : 256'h0; // @[intervox_transmitter.scala 341:39 343:33]
  wire [255:0] _BFR_io_dataIn_T_17 = 256'h1 << _BFR_io_dataIn_T_11; // @[intervox_transmitter.scala 347:58]
  wire [255:0] _BFR_io_dataIn_T_19 = _GEN_70 + _BFR_io_dataIn_T_17; // @[intervox_transmitter.scala 347:51]
  wire [255:0] _GEN_23 = io_SDATA_IN ? _BFR_io_dataIn_T_19 : _GEN_22; // @[intervox_transmitter.scala 346:38 347:33]
  wire [255:0] _GEN_25 = bitCntr > 8'h1f ? _GEN_21 : _GEN_23; // @[intervox_transmitter.scala 320:31]
  wire  _T_29 = bitCntr == 8'h3f; // @[intervox_transmitter.scala 351:24]
  wire [63:0] _GEN_28 = BFR_io_dataOut; // @[intervox_transmitter.scala 201:25 351:33 356:31]
  wire [255:0] _GEN_29 = bitCntr == 8'h3f ? 256'h0 : _GEN_25; // @[intervox_transmitter.scala 351:33 360:28]
  wire [7:0] _GEN_30 = bitCntr == 8'h3f ? 8'h0 : _bitCntr_T_1; // @[intervox_transmitter.scala 309:19 351:33 362:21]
  wire [7:0] _GEN_31 = bclkR ? _GEN_30 : _GEN_15; // @[intervox_transmitter.scala 306:28]
  wire [255:0] _GEN_33 = bclkR ? _GEN_29 : 256'h0; // @[intervox_transmitter.scala 197:25 306:28]
  wire  _GEN_34 = bclkR & _T_29; // @[intervox_transmitter.scala 200:25 306:28]
  wire [63:0] _GEN_35 = bclkR ? _GEN_28 : BFR_io_dataOut; // @[intervox_transmitter.scala 201:25 306:28]
  wire  _GEN_37 = synced ? ~encoderClk : encoderClk; // @[intervox_transmitter.scala 289:27 299:20 175:34]
  wire  _GEN_38 = synced ? _GEN_17 : bclkR; // @[intervox_transmitter.scala 289:27 171:34]
  wire [7:0] _GEN_39 = synced ? _GEN_31 : _GEN_15; // @[intervox_transmitter.scala 289:27]
  wire  _GEN_40 = synced & bclkR; // @[intervox_transmitter.scala 196:25 289:27]
  wire [255:0] _GEN_41 = synced ? _GEN_33 : 256'h0; // @[intervox_transmitter.scala 197:25 289:27]
  wire  _GEN_42 = synced & _GEN_34; // @[intervox_transmitter.scala 200:25 289:27]
  wire [63:0] _GEN_43 = synced ? _GEN_35 : BFR_io_dataOut; // @[intervox_transmitter.scala 201:25 289:27]
  wire  _GEN_46 = 2'h2 == current_state ? _GEN_38 : bclkR; // @[intervox_transmitter.scala 277:24 171:34]
  wire [255:0] _GEN_49 = 2'h2 == current_state ? _GEN_41 : 256'h0; // @[intervox_transmitter.scala 277:24 197:25]
  wire [63:0] _GEN_51 = 2'h2 == current_state ? _GEN_43 : BFR_io_dataOut; // @[intervox_transmitter.scala 277:24 201:25]
  wire  _GEN_53 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & synced; // @[intervox_transmitter.scala 277:24 207:31]
  wire  _GEN_55 = 2'h1 == current_state ? bclkR : _GEN_46; // @[intervox_transmitter.scala 277:24 171:34]
  wire  _GEN_57 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_40; // @[intervox_transmitter.scala 277:24 196:25]
  wire [255:0] _GEN_58 = 2'h1 == current_state ? 256'h0 : _GEN_49; // @[intervox_transmitter.scala 277:24 197:25]
  wire  _GEN_59 = 2'h1 == current_state ? 1'h0 : 2'h2 == current_state & _GEN_42; // @[intervox_transmitter.scala 277:24 200:25]
  wire [63:0] _GEN_60 = 2'h1 == current_state ? BFR_io_dataOut : _GEN_51; // @[intervox_transmitter.scala 277:24 201:25]
  wire  _GEN_64 = 2'h0 == current_state ? bclkR : _GEN_55; // @[intervox_transmitter.scala 277:24 171:34]
  wire [255:0] _GEN_67 = 2'h0 == current_state ? 256'h0 : _GEN_58; // @[intervox_transmitter.scala 277:24 197:25]
  bi_phase_encoder bi_phase_enc ( // @[intervox_transmitter.scala 173:33]
    .clock(bi_phase_enc_clock),
    .reset(bi_phase_enc_reset),
    .io_DATA_OUT(bi_phase_enc_io_DATA_OUT),
    .io_AUDIOINPUT(bi_phase_enc_io_AUDIOINPUT),
    .io_ENA(bi_phase_enc_io_ENA),
    .io_TICK(bi_phase_enc_io_TICK)
  );
  RWSmem BFR ( // @[intervox_transmitter.scala 179:33]
    .clock(BFR_clock),
    .io_write(BFR_io_write),
    .io_dataIn(BFR_io_dataIn),
    .io_dataOut(BFR_io_dataOut)
  );
  RWSmem BFR1 ( // @[intervox_transmitter.scala 180:33]
    .clock(BFR1_clock),
    .io_write(BFR1_io_write),
    .io_dataIn(BFR1_io_dataIn),
    .io_dataOut(BFR1_io_dataOut)
  );
  assign io_MCLK_O = clock; // @[intervox_transmitter.scala 188:25]
  assign io_DATA_O = bi_phase_enc_io_DATA_OUT; // @[intervox_transmitter.scala 187:25]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 190:25]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 189:25]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 191:25]
  assign io_NXT_FRAME = bi_phase_enc_io_ENA; // @[intervox_transmitter.scala 204:31]
  assign bi_phase_enc_clock = clock;
  assign bi_phase_enc_reset = reset;
  assign bi_phase_enc_io_AUDIOINPUT = BFR1_io_dataOut; // @[intervox_transmitter.scala 209:31]
  assign bi_phase_enc_io_ENA = 2'h0 == current_state ? 1'h0 : _GEN_53; // @[intervox_transmitter.scala 277:24 207:31]
  assign bi_phase_enc_io_TICK = encoderClk; // @[intervox_transmitter.scala 206:31]
  assign BFR_clock = clock;
  assign BFR_io_write = 2'h0 == current_state ? 1'h0 : _GEN_57; // @[intervox_transmitter.scala 277:24 196:25]
  assign BFR_io_dataIn = _GEN_67[63:0];
  assign BFR1_clock = clock;
  assign BFR1_io_write = 2'h0 == current_state ? 1'h0 : _GEN_59; // @[intervox_transmitter.scala 277:24 200:25]
  assign BFR1_io_dataIn = 2'h0 == current_state ? BFR_io_dataOut : _GEN_60; // @[intervox_transmitter.scala 277:24 201:25]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 167:34]
      current_state <= 2'h0; // @[intervox_transmitter.scala 167:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 277:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 281:21]
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 277:24]
      current_state <= 2'h2; // @[intervox_transmitter.scala 285:21]
    end
    if (reset) begin // @[intervox_transmitter.scala 169:34]
      synced <= 1'h0; // @[intervox_transmitter.scala 169:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 228:23]
      if (trailing) begin // @[intervox_transmitter.scala 259:27]
        synced <= _GEN_8;
      end
    end
    bclkR <= reset | _GEN_64; // @[intervox_transmitter.scala 171:{34,34}]
    if (reset) begin // @[intervox_transmitter.scala 175:34]
      encoderClk <= 1'h0; // @[intervox_transmitter.scala 175:34]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 277:24]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 277:24]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 277:24]
          encoderClk <= _GEN_37;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 177:34]
      bitCntr <= 8'h0; // @[intervox_transmitter.scala 177:34]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 277:24]
      bitCntr <= _GEN_15;
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 277:24]
      bitCntr <= _GEN_15;
    end else if (2'h2 == current_state) begin // @[intervox_transmitter.scala 277:24]
      bitCntr <= _GEN_39;
    end else begin
      bitCntr <= _GEN_15;
    end
    if (reset) begin // @[intervox_transmitter.scala 182:34]
      inBufr <= 2'h0; // @[intervox_transmitter.scala 182:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 228:23]
      if (io_LRCLK_IN) begin // @[intervox_transmitter.scala 234:24]
        if (inBufr < 2'h3) begin // @[intervox_transmitter.scala 236:31]
          inBufr <= _inBufr_T_1; // @[intervox_transmitter.scala 238:24]
        end
      end else if (~io_LRCLK_IN) begin // @[intervox_transmitter.scala 234:24]
        inBufr <= _GEN_1;
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 183:34]
      trailing <= 1'h0; // @[intervox_transmitter.scala 183:34]
    end else if (~synced) begin // @[intervox_transmitter.scala 228:23]
      trailing <= _GEN_6;
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
  synced = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  bclkR = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  encoderClk = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  bitCntr = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  inBufr = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  trailing = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
