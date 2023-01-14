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

    when((rising === 1.U) | (trailing === 1.U)){ // Change
      change    := 1.U
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

    when(trailing === 1.U){trailing := 0.U}
    when(rising === 1.U)  {rising   := 0.U}  
    
    when(change === 1.U){
      change   := RegNext(0.U)
    }

  io.CHANGE := change
  io.TRAIL  := trailing
  io.RISE   := rising
}

class clock_Recovery() extends Module {
    val io = IO(new Bundle{
        val DATA_IN     = Input (UInt(1.W))
        val CLK_OUT     = Output (UInt(1.W))
        val DATA_OUT    = Output (UInt(1.W))
        val DBUG        = Output (UInt(1.W))
        val DBUG1       = Output (UInt(1.W))
        val LEDS        = Output (UInt(16.W))
    })

    val zero :: puls :: one :: Nil = Enum(3)

    val rising      = RegInit(zero)
    val trailing    = RegInit(zero)
    val lastOne     = RegInit(15.U(8.W))
    val overSampleCntr= RegInit(0.U(4.W))
    val inBufr      = RegInit(0.U(2.W))
    val deltaCntr   = RegInit(0.U(8.W))   
    val clkRec      = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val dataOut     = RegInit(0.U(1.W))
    val syncWord    = RegInit(0.U(1.W))
    val zeroFlipped = RegInit(0.U(1.W))
    val syncFlipped = RegInit(0.U(1.W))
    val syncFlipped1= RegInit(0.U(1.W))
    val syncFlipped2= RegInit(0.U(1.W))

    io.CLK_OUT      := clkRec
    io.DATA_OUT     := dataOut
    io.DBUG         := change
    io.DBUG1        := syncWord
    io.LEDS         := lastOne

    deltaCntr    := deltaCntr + 1.U    

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
        // Ensure that 'change' will go low, two cycles from now.
        change := RegNext(RegNext(0.U, 0.U(1.W)), 0.U(1.W))
        // FLip the clock recovery register
        clkRec      := ~clkRec
        // Reset the delta counter (cycles since last change)
        deltaCntr   := 0.U        
        // Prepare for clock recovery during the coming zeros, and syncwords:
        zeroFlipped := 0.U
        syncFlipped := 0.U
        syncFlipped1:= 0.U
        syncWord := 0.U
    }
    
    /*
        DETECT A INCOMING 1
    */
    when((deltaCntr <= (lastOne + 1.U))){
        // We always assume the in coming data to be a 1 bit.
        // We are only sure if in incoming bit is infact a 1,
        when(change === 1.U){
            // If a change is present, whilst the deltacounter is smaller than
            // or equal to, our expected 1 cycles (lastOne) + 1.U (slack)
            dataOut := 1.U
            
            // Bring back lastOne := deltaCntr? ie. Dynamic 1 bit reference.
            //lastOne := deltaCntr
        }
    }

    /*
        DETECT A INCOMING 0
    */
    when((deltaCntr > (lastOne + 1.U)) & (deltaCntr < ((lastOne * 2.U) + 2.U))){
        // If the deltaCounter has surpassed the reference for a 1 bit.
        // Then we must have a zero.
        when(zeroFlipped === 0.U){
        // And will have to flip the clock register by an approximation.
            // Flip Clock register, only once for this bit.   
            clkRec := ~clkRec
            zeroFlipped := 1.U
        }
        // Change data output.
        dataOut := 0.U
    }

    /*
        DETECT A SYNCWORD (header-bits)
          \ __ __ /\ _ /
    */
    when(change === 0.U){

        when(deltaCntr === ((lastOne * 2.U) + 2.U)){
            
            // \ _|_ __ /\ _ /          , where | is time at which the above is true.

            // If this is true, the deltaCounter has surpassed the reference
            // of an incoming zero. As such it must be a syncword:
            
            when(syncFlipped === 0.U){
                // Flip clk once
                clkRec := ~clkRec
                syncFlipped := 1.U
            }                    
        }    
        when(deltaCntr === ((lastOne * 3.U))){ 

            // \ __|__ /\ _ /          , where | is time at which the above is true.

            // One more clock reg flip is necessary inbetweeen syncWord detect,
            // and the incoming hardcoded 1 bit, in the syncWord / header-bits.

            syncWord := 1.U

            when(syncFlipped1 === 0.U){
                // Flip clk once
                clkRec := ~clkRec
                syncFlipped1 := 1.U
            }
        }
        when((deltaCntr === (lastOne * 4.U)) & (change === 0.U)){ 

            // \ __ __|/\ _ /          , where | is time at which the above is true.

            // One more clock reg flip is necessary inbetweeen syncWord detect,
            // and the incoming hardcoded 1 bit, in the syncWord / header-bits.

            when(syncFlipped2 === 0.U){
                // Flip clk once
                clkRec := ~clkRec
                syncFlipped2 := 1.U
            }
        }        
    }
}

class i2s_Transmitter() extends Module{
     val io = IO(new Bundle{
        val CLK_IN  = Input (UInt(1.W))
        val DATA_IN = Input (UInt(1.W))
        val NEXT    = Input (UInt(1.W))
        val BCLK    = Output(UInt(1.W))
        val LRCLK   = Output(UInt(1.W))
        val SDATA   = Output(UInt(1.W))
    })

    val enable  = RegInit(0.U(1.W))
    val bitCntr = RegInit(0.U(6.W))
    val lrclk   = RegInit(0.U(1.W))
    val bclk    = RegInit(0.U(1.W))
    val sdata   = RegInit(0.U(1.W))

    io.BCLK     := bclk
    io.LRCLK    := lrclk
    io.SDATA    := sdata
    io.BCLK     := io.CLK_IN

    val BCLKEDGE            = Module(new edgeDetector())
        BCLKEDGE.io.INPUT     := io.BCLK

    when(io.NEXT === 1.U){
        enable  := 1.U
        bitCntr := 0.U
    }

    when(enable === 1.U){
        // Count BCLK cycles
        when(BCLKEDGE.io.RISE === 1.U){
            // Count bits
            bitCntr := bitCntr + 1.U        
            // Set LRCLK high on bit 0
            when(bitCntr === 0.U){
                lrclk := 1.U
            }
            // Set LRCLK low on bit 32
            when(bitCntr === 31.U){
                lrclk := 0.U
            }
            // Set LRCLK low on bit 32
            when(bitCntr === 63.U){
                enable := 0.U
                bitCntr := 0.U
            }            
            // Toggle SDATA
            when(io.DATA_IN === 1.U){
                sdata := 1.U
            }.otherwise{
                sdata := 0.U
            }
        }
    }

}

class interVox_Reciever() extends Module {
  val io = IO(new Bundle {
    val INTERVOX_IN = Input(UInt(1.W))
    val CLK_REC     = Output (UInt(1.W))
    val DATA_OUT    = Output (UInt(1.W))
    val CLK_DBUG    = Output (UInt(1.W))
    val DBUG        = Output (UInt(1.W))
    val DBUG1       = Output (UInt(1.W))
    val LEDS        = Output (UInt(16.W))
    val BCLK        = Output (UInt(1.W))
    val LRCLK       = Output (UInt(1.W))
    val SDATA       = Output (UInt(1.W))    
  })
 
    val clockRec    = Module(new clock_Recovery())
        clockRec.io.DATA_IN := io.INTERVOX_IN
        io.LEDS     := clockRec.io.LEDS
        io.DATA_OUT := clockRec.io.DATA_OUT
        io.CLK_DBUG := 0.U
        io.CLK_REC  := 0.U
        io.DBUG1    := clockRec.io.DBUG1
        io.DBUG     := clockRec.io.DBUG

    val i2sTrans    = Module(new i2s_Transmitter())
        i2sTrans.io.CLK_IN  := clockRec.io.CLK_OUT
        i2sTrans.io.DATA_IN := clockRec.io.DATA_OUT
        i2sTrans.io.NEXT    := clockRec.io.DBUG1
        io.BCLK     := i2sTrans.io.BCLK    
        io.SDATA    := i2sTrans.io.SDATA
        io.LRCLK    := i2sTrans.io.LRCLK    
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
