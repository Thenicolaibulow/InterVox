import chisel3._
import chisel3.util._

// Include blackboxed PLL from vivado:
class clk_wiz_0_clk_wiz extends BlackBox with HasBlackBoxResource {
  // Class should have same name, as module in blackbox!
  val io = IO(new Bundle {
    val CLK_OUT  = Output(UInt(1.W))
    val locked    = Output(UInt(1.W))
    val CLK_IN    = Input (UInt(1.W))
  })
  addResource("/clk_wiz_0_clk_wiz.v")
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

    val deltaCntr   = RegInit(0.U(8.W))
    val inBufr      = RegInit(0.U(2.W))
    val lastOne     = RegInit(31.U(8.W)) // Will typically land at 7 (roughly 100MHz / 6.144MHz) - will be adjusted live, accordingly.
    val inBufrPrev  = RegInit(0.U(2.W))
 
    val clkRec      = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val changed     = RegInit(0.U(1.W)) 
    val dataOut     = RegInit(0.U(1.W))
    val zeroPeriode = RegInit(0.U(1.W))
    val syncWord    = RegInit(0.U(1.W))
    val syncFlipped = RegInit(0.U(1.W))
    val syncFlipped1 = RegInit(0.U(1.W))

    io.CLK_OUT      := clkRec
    io.DATA_OUT     := dataOut
    io.DBUG         := change
    io.DBUG1        := syncWord
    io.LEDS         := lastOne

    // Increment clock counter
    deltaCntr    := deltaCntr + 1.U    

    // Log the changes in the input buffer register:
    when(io.DATA_IN === 1.U){
        
        // On first rising edge := 01
        when(inBufr === 0.U){           
            inBufr := 1.U
        }
        // Now signal is high, bitshift such that := 0b10
        when((inBufr < 2.U) & (inBufr > 0.U)){
            // And store previous state := 01
            inBufrPrev := inBufr
            inBufr := inBufr << 1.U
        }
        when(inBufr === 2.U){
            // Store previous when max value 0b10 has been reached.
            inBufrPrev := inBufr
        }

    }
    when(io.DATA_IN === 0.U){
        
        // Now in low periode, if > 0.
        when(inBufr > 0.U){
            // Save current to previous state
            inBufrPrev := inBufr
            // Bitshift, such that:  10 > 01
            inBufr := inBufr >> 1.U
        }
        when(inBufr === 0.U){
            // Store previous when min value 00 has been reached.
            inBufrPrev := inBufr
        }
    }    

    /*
        Rising/Trailing Edge detector.
    */

    /* Detect rising as: 
        Current     :    01
        Previous    :  00
    */
    when((inBufrPrev === 0.U) & (inBufr === 1.U)){
        // On rising edge
        change      := 1.U
    }

    /* Detect trailing as: 
        Previous    :  11
        Current     :    10
    */    
    when((inBufrPrev === 2.U) & (inBufr === 1.U)){
        // On trailing edge
        change      := 1.U

    }
    
    when(change === 1.U){    
        // Slam change reg back to zero, such that it is just a pulse.
        change      := 0.U
        // Reset 0-bit clock regenerator
        changed     := 0.U
        // Always flip clock register on change.
        clkRec      := ~clkRec
        // Reset syncWord detection
        syncWord    := 0.U         
        syncFlipped := 0.U           
        syncFlipped1:= 0.U           
        // Reset delta counter
        deltaCntr   := 0.U

        // Detect a one, if it's been x < LastOne cycles since last change.
        when((deltaCntr <= lastOne + 1.U)){
            /*
                DATA DETECT 1
            */
            // Set data output            
            dataOut     := 1.U            
            // Expect it to be a 1
            zeroPeriode := 0.U            
            // Store the number of cycles since last change (live adjust expected cycles of a 1)
            lastOne     := deltaCntr
        }

    }

    // If the delta clock counter is above what is expected of a 1, and below what is expected from a syncword:
    when((deltaCntr > (lastOne + 1.U)) & (deltaCntr < ((lastOne + 1.U) * 2.U))){
        /*
            DATA DETECT 0
        */
        // Set data output
        dataOut         := 0.U
        // Note that we're now in a zero-periode, and thus need clk-regeneration.
        zeroPeriode     := 1.U
        // We're not in a syncWord
        syncWord        := 0.U
    }

    
    when((deltaCntr >= ((lastOne + 1.U) * 2.U))){
        // Detect syncword.
        syncWord := 1.U
        when(syncFlipped === 0.U){
            // Flip clock register
            clkRec  := ~clkRec
            syncFlipped := 1.U
        }
        when((deltaCntr >= ((lastOne + 1.U) * 3.U)) & (syncFlipped1 === 0.U)){
            // Flip clock register
            clkRec  := ~clkRec
            syncFlipped1 := 1.U
        }
    }


    /*
        Clock Regeneration
    */

    /*
        // Whenever we're receiving ones, flip the clock-register
        //  on every change, as these are aligned to the wanted clock:
        when((change === 1.U) & (deltaCntr >= ((lastOne * 2.U) - 5.U))){
            clkRec  := ~clkRec
        }
    */

    // Whenever we're in a zero-periode, we can't rely on rising/trailing edges. 
    // Thus we rely on the last one-cycle cyclecounter, and incoming changes, 
    // to approximate when to flip the clk-register.
    when(((deltaCntr > lastOne + 1.U) & (changed === 0.U) & (change =/= 1.U)) | ((deltaCntr > lastOne + 1.U) & (zeroPeriode === 1.U) & (changed === 0.U))){
        clkRec  := ~clkRec
        changed := 1.U
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
  })

    val clockRec = Module(new clock_Recovery())

    clockRec.io.DATA_IN := io.INTERVOX_IN

    io.LEDS             := clockRec.io.LEDS
    io.DATA_OUT         := clockRec.io.DATA_OUT
    io.CLK_DBUG         := clockRec.io.CLK_OUT
    io.DBUG1            := clockRec.io.DBUG1
    io.DBUG             := clockRec.io.DBUG


    io.CLK_REC := 0.U

    // Instantiate blackboxed MMCM.
    // Input: 3.072 MHz, Output 6.144MHz, but configured as: 12.288MHz and 24.576 MHz.
    
    val pll = Module(new clk_wiz_0_clk_wiz)   

    // Connect recovered clock reg to PLL input.
    pll.io.CLK_IN := clockRec.io.CLK_OUT

    // Once PLL is locked
    when(pll.io.locked === 1.U){
        io.CLK_REC := pll.io.CLK_OUT
    }
    .otherwise{
        io.CLK_REC := 0.U
    }
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
