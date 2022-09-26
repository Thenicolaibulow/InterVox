module interVox_Encoder(
  input   clock,
  input   reset,
  input   io_MCLK_IN,
  input   io_BCLK_IN,
  input   io_LRCLK_IN,
  input   io_SDATA_IN,
  output  io_DATA_O,
  output  io_LRCLK_O,
  output  io_BCLK_O,
  output  io_MCLK_O,
  output  io_SDATA_O
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] current_state; // @[intervox_transmitter.scala 27:30]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 29:33]
  reg  hasOne; // @[intervox_transmitter.scala 30:23]
  reg  DATA_OUT_REG; // @[intervox_transmitter.scala 32:29]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 44:42]
  wire  _GEN_0 = io_SDATA_IN | hasOne; // @[intervox_transmitter.scala 58:37 60:20 30:23]
  wire  _GEN_1 = hasOne ? DATA_OUT_REG : ~DATA_OUT_REG; // @[intervox_transmitter.scala 62:31 63:26 68:26]
  wire  _GEN_2 = hasOne ? 1'h0 : _GEN_0; // @[intervox_transmitter.scala 62:31 64:20]
  wire  _GEN_3 = 2'h2 == current_state ? _GEN_2 : hasOne; // @[intervox_transmitter.scala 30:23 47:29]
  wire  _GEN_4 = 2'h2 == current_state ? _GEN_1 : DATA_OUT_REG; // @[intervox_transmitter.scala 32:29 47:29]
  assign io_DATA_O = DATA_OUT_REG; // @[intervox_transmitter.scala 33:13]
  assign io_LRCLK_O = io_LRCLK_IN; // @[intervox_transmitter.scala 37:14]
  assign io_BCLK_O = io_BCLK_IN; // @[intervox_transmitter.scala 36:13]
  assign io_MCLK_O = io_MCLK_IN; // @[intervox_transmitter.scala 35:13]
  assign io_SDATA_O = io_SDATA_IN; // @[intervox_transmitter.scala 38:14]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 27:30]
      current_state <= 2'h0; // @[intervox_transmitter.scala 27:30]
    end else if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 45:35]
      if (2'h0 == current_state) begin // @[intervox_transmitter.scala 47:29]
        current_state <= 2'h2; // @[intervox_transmitter.scala 50:25]
      end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 47:29]
        current_state <= 2'h2; // @[intervox_transmitter.scala 53:25]
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 29:33]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 29:33]
    end else if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 45:35]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 72:22]
    end else begin
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 44:22]
    end
    if (reset) begin // @[intervox_transmitter.scala 30:23]
      hasOne <= 1'h0; // @[intervox_transmitter.scala 30:23]
    end else if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 45:35]
      if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 47:29]
        if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 47:29]
          hasOne <= _GEN_3;
        end
      end
    end
    if (reset) begin // @[intervox_transmitter.scala 32:29]
      DATA_OUT_REG <= 1'h0; // @[intervox_transmitter.scala 32:29]
    end else if (BiPhase_CLK_CNTR == 8'h3) begin // @[intervox_transmitter.scala 45:35]
      if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 47:29]
        if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 47:29]
          DATA_OUT_REG <= _GEN_4;
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
  current_state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  BiPhase_CLK_CNTR = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  hasOne = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  DATA_OUT_REG = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
