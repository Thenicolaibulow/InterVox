import chisel3._
import chisel3.util._

class edgeDetector() extends Module {
  val io = IO(new Bundle{
    val INPUT   = Input(UInt(1.W))
    val TRAIL   = Output(UInt(1.W))
    val RISE    = Output(UInt(1.W))
    val CHANGE  = Output(UInt(1.W))
  })

  val inBufr            = RegInit(0.U(2.W))
  val inBufrPrev        = RegInit(0.U(2.W))
  val trailing          = RegInit(0.U(1.W))  
  val rising            = RegInit(0.U(1.W))
  val change            = RegInit(0.U(1.W))
  val changed           = RegInit(0.U(1.W))

    /*
        EDGE DETECTION
    */  
    switch(io.INPUT){
      is(1.U){
        when(inBufr < 2.U){ // Rising  _/ = inBufr b01 -> b11
            // When rising, incriment inBufr.. looks like: 00 [Rising] 01
            inBufr      := inBufr + 1.U
            inBufrPrev  := inBufr
        }
      }
      is(0.U){
        when(inBufr > 0.U){ // Trailing  \_ = inBufr b10 -> b00
            // When trailing, decrment inBufr.. looks like: 11 [Trailing] 10
            inBufr      := inBufr - 1.U
            inBufrPrev  := inBufr
        }
      }        
    }

    when((inBufrPrev === 0.U) & (inBufr === 1.U)){ // Rising
      trailing  := 0.U
      rising    := 1.U
      change    := 1.U
    }

    when((inBufrPrev === 2.U) & (inBufr === 1.U)){ // Trailing
      trailing  := 1.U
      rising    := 0.U
      change    := 1.U
    }

    when(trailing === 1.U) {trailing := 0.U}
    when(rising === 1.U)   {rising   := 0.U}  
    when(change === 1.U)   {change   := 0.U}
    
    io.CHANGE := change
    io.TRAIL  := trailing
    io.RISE   := rising
}

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

class clock_Recovery() extends Module {
    val io = IO(new Bundle{
        val DATA_IN     = Input  (UInt(1.W))
        val CLK_OUT     = Output (UInt(1.W))
        val DATA_OUT    = Output (UInt(1.W))
        val DBUG        = Output (UInt(1.W))
        val DBUG1       = Output (UInt(1.W))
        val LED         = Output (UInt(16.W))
        val SW          = Input  (UInt(16.W))
        val DATAREG     = Output (UInt(64.W))
        val BTN_C       = Input  (UInt(1.W))        
    })
    
    // Define buffer default behaviour.
    val BFR         = Module(new RWSmem())
    BFR.io.enable         := 1.U
    BFR.io.addr           := 1.U
    BFR.io.write          := 0.U
    BFR.io.dataIn         := 0.U
    val BFR1         = Module(new RWSmem())
    BFR1.io.enable         := 1.U
    BFR1.io.addr           := 1.U
    BFR1.io.write          := 0.U
    BFR1.io.dataIn         := 0.U    

    val zero :: puls :: one :: Nil = Enum(3)

    val rising      = RegInit(zero)
    val trailing    = RegInit(zero)
    val lastOne     = RegInit(15.U(8.W))
    val leds        = RegInit(0.U(16.W))
    val overSampleCntr= RegInit(0.U(4.W))
    val inBufr      = RegInit(0.U(2.W))
    val deltaCntr   = RegInit(0.U(8.W))
    val bitCntr     = RegInit(0.U(7.W))
    val clkRec      = RegInit(0.U(1.W))
    val written     = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val dataOut     = RegInit(0.U(1.W))
    val syncWord    = RegInit(0.U(1.W))
    val zeroFlipped = RegInit(0.U(1.W))
    val syncFlipped = RegInit(0.U(1.W))
    val syncFlipped1= RegInit(0.U(1.W))
    val syncFlipped2= RegInit(0.U(1.W))

    
    io.DATA_OUT     := dataOut
    io.DBUG1        := syncWord
    io.LED          := leds

    deltaCntr    := deltaCntr + 1.U    

    val CLKEDGE             = Module(new edgeDetector())
        CLKEDGE.io.INPUT    := clkRec

    io.CLK_OUT      := clkRec
    io.DATAREG      := BFR1.io.dataOut
    io.DBUG         := change


    /*
        EDGE DETECTION
    */  
    switch(io.DATA_IN){
        is(1.U){
            when(inBufr < 3.U){ // Rising  _/ = inBufr b01 -> b11
                // When rising, incriment inBufr.. looks like: 00 [Rising] 01
                inBufr := inBufr + 1.U
            }
        }
        is(0.U){
            when(inBufr > 0.U){ // Trailing  \_ = inBufr b10 -> b00
                // When trailing, decrment inBufr.. looks like: 11 [Trailing] 10
                inBufr := inBufr - 1.U
            }
        }        
    }
    when((inBufr(0)) ^ (inBufr(1))){    // Difference in input buffer? - Must be change. 
        change := 1.U
    }

    /*
        WHENEVER A CHANGE IS REGISTERED:
    */
    when(change === 1.U){
        change := 0.U
        // FLip the clock recovery register
        clkRec          := ~clkRec
        // Reset the delta counter (cycles since last change)
        deltaCntr       := 0.U        
        // Prepare for clock recovery during the coming zeros, and syncwords:
        zeroFlipped     := 0.U
        syncFlipped     := 0.U
        syncFlipped1    := 0.U
    }

    when(syncWord === 1.U){
        syncWord    := 0.U
        bitCntr     := 0.U
        // Clear input buffer
        BFR.io.write   := 1.U
        BFR.io.dataIn  := 0.U
    }    
    
    when(CLKEDGE.io.RISE === 1.U){
        bitCntr := bitCntr + 1.U
        // Enable buffer write
        BFR.io.write      := 1.U                // 64 (Reverse MSB/LSB)
        when(dataOut === 1.U){
            BFR.io.dataIn     := BFR.io.dataOut | (1.U << (63.U - bitCntr))    
        }.otherwise{
            BFR.io.dataIn     := BFR.io.dataOut & (0.U << (63.U - (bitCntr)))
        }

    }

    /*
        DETECT A INCOMING 1
    */
    when((deltaCntr <= (lastOne))){
        // We always assume the in coming data to be a 1 bit.
        // We are only sure if in incoming bit is infact a 1,
        when(change === 1.U){
            // If a change is present, whilst the deltacounter is smaller than
            // or equal to, our expected 1 cycles (lastOne) + 1.U (slack)            
            dataOut := 1.U
        }
    }

    /*
        DETECT A INCOMING 0
    */
    when((deltaCntr > (lastOne)) & (deltaCntr < ((lastOne * 2.U)))){
        // If the deltaCounter has surpassed the reference for a 1 bit.
        // Then we must have a zero.
        // Change data output.
        dataOut := 0.U    

        when(zeroFlipped === 0.U){
        // And will have to flip the clock register by an approximation.
            // Flip Clock register, only once for this bit.   
            clkRec := ~clkRec
            zeroFlipped := 1.U
        }
    }

    /*
        DETECT A SYNCWORD (header-bits)
          \ __ __ /\ / ^
    */

    when((deltaCntr >= ((lastOne * 2.U)))){
        
        // \ _|_ __ /\ / ^           , where | is time at which the above is true.

        // If this is true, the deltaCounter has surpassed the reference
        // of an incoming zero. As such it must be a syncword:
    
        when(syncFlipped === 0.U){
            // Flip clk once
            clkRec := ~clkRec
            syncFlipped := 1.U
        }                    
    }    
    when((deltaCntr >= ((lastOne * 3.U)))){ 

        // \ __|__ /\ / ^          , where | is time at which the above is true.

        // One more clock reg flip is necessary inbetweeen syncWord detect,
        // and the incoming hardcoded 1 bit, in the syncWord / header-bits.

        syncWord := 1.U
        when(syncFlipped1 === 0.U){
            // Flip clk once
            clkRec := ~clkRec
            syncFlipped1 := 1.U
            // Reset bit counter, prepare for next incoming package
            bitCntr := 0.U    

            // Dump BFR0 into BFR1
            BFR1.io.write   := 1.U
            BFR1.io.dataIn  := BFR.io.dataOut            
            // 46.U -> to not show the header bits, but rather the left channel data
            leds    := (BFR1.io.dataOut >> 46.U) & (65535.U)
        }
    }      

    // Change lastOne reference on the fly with switches.
    when(io.SW > 0.U){
        when(io.BTN_C === 1.U){
            lastOne := io.SW
            leds    := io.SW
        }
    }    
}

class i2s_Transmitter() extends Module{
     val io = IO(new Bundle{
        val CLK_IN  = Input (UInt(1.W))
        val DATA_IN = Input (UInt(64.W))
        val NEXT    = Input (UInt(1.W))
        val LRCLK   = Output(UInt(1.W))
        val SDATA   = Output(UInt(1.W))
    })       

    val bitCntrTrans = RegInit(0.U(8.W))
    val lrclk   = RegInit(0.U(1.W))
    val sdataO  = RegInit(0.U(1.W))

    io.LRCLK    := lrclk
    io.SDATA    := sdataO

    val CLK1EDGE             = Module(new edgeDetector())
        CLK1EDGE.io.INPUT    := io.CLK_IN

    // On syncword detect, reset bit counter.
    when(io.NEXT === 1.U){
        bitCntrTrans := 0.U
    }

    when(CLK1EDGE.io.RISE === 1.U){
        // Count BCLK cycles
        bitCntrTrans := bitCntrTrans + 1.U        

        when(bitCntrTrans === 0.U){
            // Set LRCLK high on bit 0
            lrclk := 1.U
        }
        when(bitCntrTrans > 31.U){
            // Set LRCLK low on bit 32
            lrclk := 0.U
        }                       
        when((bitCntrTrans <= 24.U)){
            // Write 24 left channel bits
            sdataO := 1.U & io.DATA_IN(60.U - bitCntrTrans)
        }
        when((bitCntrTrans > 24.U) & (bitCntrTrans <= 31.U)){
            // Fill with zeros until right channel
            sdataO := 0.U
        }
        when((bitCntrTrans <= 56.U) & (bitCntrTrans > 31.U)){
            // Write 24 right channel bits
            sdataO := 1.U & io.DATA_IN(36.U - (bitCntrTrans + 31.U))
        }
        when((bitCntrTrans > 56.U)){
            // Fill until frame is done.
            sdataO := 0.U
        }   
    }
}

class interVox_Receiver() extends Module {
  val io = IO(new Bundle {
    val INTERVOX_IN = Input(UInt(1.W))
    val CLK_REC     = Output (UInt(1.W))
    val DATA_OUT    = Output (UInt(1.W))
    val CLK_DBUG    = Output (UInt(1.W))
    val DBUG        = Output (UInt(1.W))
    val DBUG1       = Output (UInt(1.W))
    val LED         = Output (UInt(16.W))
    val SW          = Input  (UInt(16.W))
    val BCLK        = Output (UInt(1.W))
    val LRCLK       = Output (UInt(1.W))
    val SDATA       = Output (UInt(1.W))
    val BTN_C       = Input (UInt(1.W))
    val BTN_D       = Input (UInt(1.W))
    val BTN_L       = Input (UInt(1.W))
    val BTN_R       = Input (UInt(1.W))        
  })
 
    val clockRec    = Module(new clock_Recovery())
        clockRec.io.DATA_IN := io.INTERVOX_IN
        clockRec.io.SW      := io.SW
        clockRec.io.BTN_C   := io.BTN_C
        io.LED      := clockRec.io.LED
        io.DATA_OUT := clockRec.io.DATA_OUT
        io.CLK_DBUG := 0.U
        io.CLK_REC  := 0.U
        io.DBUG1    := clockRec.io.DBUG1
        io.DBUG     := clockRec.io.DBUG

    val i2sTrans    = Module(new i2s_Transmitter())
        i2sTrans.io.CLK_IN  := clockRec.io.CLK_OUT
        i2sTrans.io.DATA_IN := clockRec.io.DATAREG
        i2sTrans.io.NEXT    := clockRec.io.DBUG1
        io.BCLK     := clockRec.io.CLK_OUT  
        io.SDATA    := i2sTrans.io.SDATA
        io.LRCLK    := i2sTrans.io.LRCLK    
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Receiver())
}
