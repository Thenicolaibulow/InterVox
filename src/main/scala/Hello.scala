import chisel3._
import chisel3.util._

class I2S_Transmitter(width: UInt) extends Module {
  val io = IO(new Bundle {
    val Tx =      Input (UInt(32.W))
    val Ready =   Output(UInt(1.W))
    val LRCLK =   Output(UInt(1.W))    
    val BCLK =    Output(UInt(1.W))  
    val MCLK =    Output(UInt(1.W))  
    val DATA =    Output(UInt(32.W))
    val bDATA =   Output(UInt(1.W))      
    val State_o = Output(UInt(2.W))
    val BitCntr = Output(UInt(8.W))
    val tick =    Output (UInt(1.W))
    val sw =      Input (UInt(16.W))
    val CLKR =    Output(UInt(16.W))
  })

    /*
    def buildSineLookupTable(amp: Double, n: Int): Vec[SInt] = {
      val Pi = math.Pi
      val times = (0 until n).map(i => (i*2*Pi)/(n.toDouble - 1) - Pi)
      val inits = times.map(t => Math.round(amp * math.sin(t)).asSInt(32.W))
      VecInit(inits)
    }*/

  // Define state enum.. case sentitive!
  val state_Reset :: state_TransmitWord :: Nil = Enum(2)

  val current_state = RegInit(state_Reset)  
  val Bit_Counter   = RegInit(0.U(8.W))
  val ClkCntr       = RegInit(0.U(8.W))
  val Tckr          = RegInit(0.U(1.W))
  val BCLKTckr      = RegInit(1.U(1.W))
  val LRClkr        = RegInit(0.U(1.W))
  val MCLKTckr      = RegInit(1.U(1.W))
  val bDATA         = RegInit(0.U(1.W))
  val DATA          = RegInit(0.U(32.W))
  
  //val FRAME_NR      = RegInit(0.U(8.W))
  //val sineLUT = Module(new sinTable(0.9, 1))
  //val sineLUT = buildSineLookupTable(0.9, 10)
  //val lutOut = sineLUT(FRAME_NR)

  // Increment clock counter
  ClkCntr := ClkCntr + 1.U 

  //... very crude clock divider. 
  when( ClkCntr === 4.U   || 
        ClkCntr === 8.U   || //
        ClkCntr === 12.U  ||
        ClkCntr === 16.U  || //
        ClkCntr === 20.U  ||
        ClkCntr === 24.U  || //
        ClkCntr === 28.U  ||
        ClkCntr === 32.U  || //
        ClkCntr === 36.U  ||
        ClkCntr === 40.U  || //
        ClkCntr === 44.U  ||
        ClkCntr === 48.U  || //
        ClkCntr === 52.U  ||
        ClkCntr === 56.U  || //
        ClkCntr === 60.U  ||
        ClkCntr === 64.U  || //
        ClkCntr === 68.U  ||
        ClkCntr === 72.U) {  //

          // MCLK should be 100MHz / 4.
          MCLKTckr := ~MCLKTckr

      }

  //... very crude clock divider. 
  when( ClkCntr === 32.U || 
        ClkCntr === 64.U) {
          // BCLK should be MCLK / 4
          BCLKTckr := ~BCLKTckr

  }

  //... very crude clock divider. 
  when(ClkCntr === 64.U) {
    // FS is then BCLK / 64
    Tckr := 1.U 
    ClkCntr := 0.U
    //FRAME_NR := FRAME_NR + 1.U

  }.otherwise {
    Tckr := 0.U
  }  

  // Bind registers to output io.
  io.BitCntr  := Bit_Counter
  io.BCLK     := BCLKTckr
  io.MCLK     := MCLKTckr
  io.LRCLK    := LRClkr
  io.bDATA    := bDATA
  io.DATA     := DATA
  io.CLKR     := ClkCntr
  io.tick     := Tckr

  io.Ready    := 0.U
  io.State_o  := 0.U

  /*
  when(FRAME_NR === 25.U) {
    FRAME_NR := 0.U
  }
  */

  // Actual 'transmitter'
  when (Tckr === 1.U) {

    switch(current_state){

      is(state_Reset) {

        io.State_o  := 0.U
        io.Ready    := 0.U
        io.LRCLK    := 0.U
        io.BCLK     := 0.U
        io.MCLK     := 0.U
        io.DATA     := 0.U
        Bit_Counter := 0.U
        io.BitCntr  := 0.U
        current_state := state_TransmitWord

      }

      is(state_TransmitWord) {

        io.State_o := 1.U

        when (io.sw === 0.U) {
          // Below, ensures 1 bit delay. 
          when ((Bit_Counter === 0.U) || (Bit_Counter <= width - 1.U)){ 
            // When switches are not set, default to arbitrary test data.

            val dumb_tst_dat = (9896087).U
            bDATA := (dumb_tst_dat((width - 1.U) - Bit_Counter))
            DATA  := (dumb_tst_dat)
            //bDATA := (lutOut((width - 1.U) - Bit_Counter))
            //DATA  := (lutOut)
          }
        }.otherwise {
            // Switches represent the arbitrary test data.
            val sw_msb_lsb_16_R = io.sw << 16
            val sw_msb_lsb_16_L = io.sw
            val sw_msb_lsb_32 = (sw_msb_lsb_16_L + sw_msb_lsb_16_R)

            bDATA := (sw_msb_lsb_32((width - 1.U) - Bit_Counter))
            DATA  := io.sw
        }
        
        // If we're halfway through, flip LRCLK (ie. 2nd. channel)
        when (Bit_Counter >= ((width / 2.U) - 1.U)) {
          LRClkr := 1.U
        }
        when ((Bit_Counter < ((width / 2.U) - 1.U)) || (Bit_Counter === (width - 1.U))) {
          LRClkr := 0.U
        }       

        // Reset bit counter when a full frame has been transmitted.
        when (Bit_Counter === (width - 1.U)) {
          Bit_Counter := 0.U
          io.Ready := 1.U
        } 
        .otherwise
        {
          // Just counting the processed bits..
          Bit_Counter := Bit_Counter + 1.U    

        }
      }
    }
  }
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new I2S_Transmitter(32.U))
}
