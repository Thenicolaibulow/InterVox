import chisel3._
import chisel3.util._

  /*
    The main encoder is a state machine which initialises the interVox clients,
    and encodes I2S data into the interVox format. - A bi-phase mark encoded signal,
    which carries both (up to) 24-bit audio, along side DSP control data.
  */
 
class RWSmem extends Module {
  val io = IO(new Bundle {
    val enable    = Input(Bool())
    val write     = Input(Bool())
    val addr      = Input(UInt(1.W))
    val dataIn    = Input(UInt(64.W))
    val dataOut   = Output(UInt(64.W))
  })

  val mem = SyncReadMem(1, UInt(64.W))

  io.dataOut := DontCare
  
  when(io.enable) {
    val rdwrPort = mem(io.addr)
    when (io.write) { rdwrPort := io.dataIn }
      .otherwise    { io.dataOut := rdwrPort }
  }
}

class bi_phase_encoder() extends Module {
  val io = IO(new Bundle {
    val DATA_OUT   = Output(UInt(1.W))
    val AUDIOINPUT = Input (UInt(64.W))
    val DSPINPUT   = Input (UInt(64.W))
    val TICK       = Input (UInt(1.W))
    val NEXT       = Output(UInt(1.W))
  })
    val outReg        = RegInit(0.U(1.W))
    val next          = RegInit(0.U(1.W))
    val stereoData    = RegInit(0.U(64.W))
    val dspData       = RegInit(0.U(16.W))
    val bitCntr       = RegInit(0.U(8.W))
    val hasNone       = RegInit(0.U(1.W))
    val dataIndex     = RegInit(0.U(6.W))

    io.DATA_OUT := outReg
    // Every new frame, dump data into the Audio register. 
    stereoData := io.AUDIOINPUT
    dspData := 0.U
    io.NEXT := next

      when(io.TICK === 1.U){
          // Count bits
          bitCntr := bitCntr + 1.U
          when(bitCntr % 2.U === 1.U){
            dataIndex := dataIndex + 1.U
          }

          // Hard code header bits
          when(bitCntr < 7.U) {
            next := 0.U

            when(bitCntr < 6.U)
            {
              outReg := 0.U
            }
            .otherwise{
              // Otherwise, flip
              outReg := 1.U
            }
          }
          // Append audio data
          when((bitCntr > 7.U)){
            
            // Up to 64 bits
            when(bitCntr < 127.U){

              when((stereoData((dataIndex - 4.U)))  === 0.U) {
                // Then don't change for one cycle
                hasNone := 1.U
              }

            } // Append DSP data
            when(bitCntr > 127.U){

                when((dspData((dataIndex - 4.U)))  === 0.U) {
                // Then don't change for one cycle
                hasNone := 1.U
              }

            }
            when(hasNone === 1.U){
              outReg := outReg
              hasNone := 0.U
            }
            .otherwise{
              // Otherwise, flip
              outReg := ~outReg
            }
          }

          when(bitCntr === 255.U){
            bitCntr := 0.U
            stereoData := 0.U
            next := 1.U
          }
        }
      }

class interVox_Encoder(width: UInt) extends Module {
  val io = IO(new Bundle {
    val MCLK_IN   = Input (Clock())     // 256 x fs
    val MCLK_O    = Output(Clock())  
    val BCLK_IN   = Input (UInt(1.W))   //  64 x fs
    val LRCLK_IN  = Input (UInt(1.W))   //       fs  
    val SDATA_IN  = Input (UInt(1.W))
    val DATA_O    = Output(UInt(1.W))
    val LRCLK_O   = Output(UInt(1.W))    
    val BCLK_O    = Output(UInt(1.W))  
    val SDATA_O   = Output(UInt(1.W))
    val NXT_FRAME = Output(UInt(1.W))      
  })

  // Define state enum.. case sentitive!
  val state_Reset :: state_Setup :: state_Transmit :: Nil = Enum(3)
  val current_state     = RegInit(state_Reset)  
  // Bi-phase clock counter register.
  val BiPhase_CLK_CNTR  = RegInit(0.U(8.W))
  // Output register
  val DATA_OUT_REG_1B   = RegInit(0.U(1.W)) 
  // Frame register. Notifies the Bi_phase_encoder
  val FirstFrame        = RegInit(0.U(1.W))   
  // Instantiate bi-phase encoder
  val bi_phase_enc      = Module(new bi_phase_encoder())

  val bitCntr           = RegInit(0.U(8.W))
  val LR                = RegInit(0.U(1.W))
  val tick              = RegInit(0.U(1.W))
  val PROCESSED         = RegInit(0.U(1.W))
  
  
  val BFR               = Module(new RWSmem())
  val BFR1              = Module(new RWSmem())

  // Assign pins. 
  io.DATA_O             := DATA_OUT_REG_1B
  io.MCLK_O             := io.MCLK_IN
  io.BCLK_O             := io.BCLK_IN 
  io.LRCLK_O            := io.LRCLK_IN 
  io.SDATA_O            := io.SDATA_IN
  BFR.io.addr           := 1.U
  BFR.io.enable         := 1.U
  BFR.io.write          := 0.U
  BFR.io.dataIn         := 0.U
  BFR1.io.addr          := 1.U
  BFR1.io.enable        := 1.U
  BFR1.io.write         := 0.U
  BFR1.io.dataIn        := 0.U
  io.NXT_FRAME          := bi_phase_enc.io.TICK

  // Get the bi-phase encoder ready
  bi_phase_enc.io.TICK        := 0.U
  bi_phase_enc.io.AUDIOINPUT  := BFR1.io.dataOut
  bi_phase_enc.io.DSPINPUT    := 0.U
  // Recieve encoded data, and clock it out on data_out
  DATA_OUT_REG_1B := bi_phase_enc.io.DATA_OUT

  // Clock internal logic off of the external I2S MCLK, to keep everything synced.
  withClock(io.MCLK_IN){

    /*
      For every frame (ie. LRCLK = ~LRCLK)
      Populate a 32b register with the incoming sdata (offset adequitely). 
      Pad this register with header and DSP data

      { {HEADER + L_CH 24B} + {R_CH 24B + DSP} }
    */

  switch(current_state){
          
    is(state_Reset){
      current_state := state_Transmit
    }
    is(state_Setup){
      current_state := state_Transmit
    }
    is(state_Transmit){ 
      
      BiPhase_CLK_CNTR := BiPhase_CLK_CNTR + 1.U

      when( BiPhase_CLK_CNTR === 1.U | 
            BiPhase_CLK_CNTR === 3.U |
            BiPhase_CLK_CNTR === 5.U |
            BiPhase_CLK_CNTR === 7.U ){
        bi_phase_enc.io.TICK := 1.U
      }

      when(BiPhase_CLK_CNTR === 7.U){

        // Count bits
        bitCntr := bitCntr + 1.U

        // For each bit, assign it the appropriate bit in DATA_OUT_REG_WIDTH
        // Effectively 'repackaging' the I2S Serial data for use with intervox.          
        
        when(bitCntr > 40.U){
          // Truncate the last 8 bits of a 32 bit word. 
          // Limits the incoming data to 24 bit, purposely. 
          when(io.SDATA_IN === 0.U) {
            // We always write to adress 1.
            BFR.io.write      := 1.U
            BFR.io.dataIn     := BFR.io.dataOut + (0.U << (bitCntr - 16.U))
          }

          when(io.SDATA_IN === 1.U){
            // We always write to adress 1.
            BFR.io.write      := 1.U
            BFR.io.dataIn     := BFR.io.dataOut + (1.U << (bitCntr - 16.U))
          }
        }.otherwise{
          when(io.SDATA_IN === 0.U) {
            // We always write to adress 1.
            BFR.io.write      := 1.U
            BFR.io.dataIn     := BFR.io.dataOut + (0.U << (bitCntr))
          }

          when(io.SDATA_IN === 1.U){
            // We always write to adress 1.
            BFR.io.write      := 1.U
            BFR.io.dataIn     := BFR.io.dataOut + (1.U << (bitCntr))
          }          
        }
        when(bitCntr === 63.U){
          // Allows for one sample delay. 
          // Dump BFR into BFR1
          BFR1.io.write     := 1.U
          BFR1.io.dataIn    := BFR.io.dataOut
          // Clear Buffers. 
          BFR.io.write      := 1.U
          BFR.io.dataIn     := 0.U

          when(bi_phase_enc.io.NEXT === 1.U){
            BFR1.io.write   := 1.U
            BFR1.io.dataIn  := 0.U
          }
          bitCntr          := 0.U
        }
        
        BiPhase_CLK_CNTR := 0.U
      }
    }
  }
  }
}

object HelloMain extends App {
  println(".. I will now generate the Verilog file!")
  emitVerilog(new interVox_Encoder(32.U))
}
