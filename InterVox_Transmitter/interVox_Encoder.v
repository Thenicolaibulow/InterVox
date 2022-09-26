module interVox_Encoder(
  input   clock,
  input   reset,
  input   io_MCLK_IN,
  input   io_BCLK_IN,
  input   io_LRCLK_IN,
  input   io_SDATA_IN,
  output  io_DATA_O
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] current_state; // @[intervox_transmitter.scala 22:30]
  reg [7:0] BiPhase_CLK_CNTR; // @[intervox_transmitter.scala 24:33]
  reg  DATA_OUT_REG; // @[intervox_transmitter.scala 26:29]
  wire [7:0] _BiPhase_CLK_CNTR_T_1 = BiPhase_CLK_CNTR + 8'h1; // @[intervox_transmitter.scala 33:42]
  wire  _GEN_0 = ~io_SDATA_IN ? ~DATA_OUT_REG : DATA_OUT_REG ^ io_SDATA_IN; // @[intervox_transmitter.scala 47:39 49:28 53:28]
  wire  _GEN_1 = BiPhase_CLK_CNTR == 8'h2 ? _GEN_0 : DATA_OUT_REG; // @[intervox_transmitter.scala 26:29 45:42]
  wire [7:0] _GEN_2 = BiPhase_CLK_CNTR == 8'h2 ? 8'h0 : _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 33:22 45:42 56:28]
  assign io_DATA_O = DATA_OUT_REG; // @[intervox_transmitter.scala 27:13]
  always @(posedge clock) begin
    if (reset) begin // @[intervox_transmitter.scala 22:30]
      current_state <= 2'h0; // @[intervox_transmitter.scala 22:30]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 35:29]
      current_state <= 2'h2; // @[intervox_transmitter.scala 38:25]
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 35:29]
      current_state <= 2'h2; // @[intervox_transmitter.scala 41:25]
    end
    if (reset) begin // @[intervox_transmitter.scala 24:33]
      BiPhase_CLK_CNTR <= 8'h0; // @[intervox_transmitter.scala 24:33]
    end else if (2'h0 == current_state) begin // @[intervox_transmitter.scala 35:29]
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 33:22]
    end else if (2'h1 == current_state) begin // @[intervox_transmitter.scala 35:29]
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 33:22]
    end else if (2'h2 == current_state) begin // @[intervox_transmitter.scala 35:29]
      BiPhase_CLK_CNTR <= _GEN_2;
    end else begin
      BiPhase_CLK_CNTR <= _BiPhase_CLK_CNTR_T_1; // @[intervox_transmitter.scala 33:22]
    end
    if (reset) begin // @[intervox_transmitter.scala 26:29]
      DATA_OUT_REG <= 1'h0; // @[intervox_transmitter.scala 26:29]
    end else if (!(2'h0 == current_state)) begin // @[intervox_transmitter.scala 35:29]
      if (!(2'h1 == current_state)) begin // @[intervox_transmitter.scala 35:29]
        if (2'h2 == current_state) begin // @[intervox_transmitter.scala 35:29]
          DATA_OUT_REG <= _GEN_1;
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
  DATA_OUT_REG = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
