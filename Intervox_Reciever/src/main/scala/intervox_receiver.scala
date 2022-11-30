import chisel3._
import chisel3.util._

// Include blackboxed PLL from vivado:
class clk_wiz_0_clk_wiz extends BlackBox with HasBlackBoxResource {
  // Class should have same name, as module in blackbox!
  val io = IO(new Bundle {
    val PLL_MCLK  = Output(UInt(1.W))
    val locked    = Output(UInt(1.W))
    val PLL_IN    = Input (UInt(1.W))
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
    val lastOne     = RegInit(16.U(8.W)) // Initially 8 (*2) (roughly 100MHz / 12.288MHz) - will be adjusted live, accordingly.
    val inBufr      = RegInit(0.U(2.W))
    val inBufrPrev  = RegInit(0.U(2.W))
    val whatChange  = RegInit(0.U(2.W))
 
    val outReg      = RegInit(0.U(1.W))
    val clkRec      = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val changed     = RegInit(0.U(1.W))
    val changedOne  = RegInit(0.U(1.W))
    val dataOut     = RegInit(0.U(1.W))
    val zeroPeriode = RegInit(0.U(1.W))
    val syncWord    = RegInit(0.U(1.W))
    val zeroClkFlp  = RegInit(0.U(1.W))

    io.CLK_OUT      := clkRec
    io.DATA_OUT     := dataOut
    io.DBUG         := zeroPeriode
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
        // Now signal is high, bitshift such that := 10
        when((inBufr < 2.U) & (inBufr > 0.U)){
            // And store previous state := 01
            inBufrPrev := inBufr
            inBufr := inBufr << 1.U
        }
        when(inBufr === 2.U){
            // Store previous when max value 10 has been reached.
            inBufrPrev := inBufr
        }

    }
    when(io.DATA_IN === 0.U){
        
        // Now in low periode, if > 0
        when(inBufr > 0.U){
            // Save current to previous state
            inBufrPrev := inBufr
            // Bitshit, such that:  10 > 01
            inBufr := inBufr >> 1.U
        }
        when(inBufr === 0.U){
            // Store previous when min≤ value 00 has been reached.
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
        //deltaCntr   := 0.U                
    }

    /* Detect trailing as: 
        Previous    :  10
        Current     :    01
    */    
    when((inBufrPrev === 2.U) & (inBufr === 1.U)){
        // On trailing edge
        change      := 1.U
        //deltaCntr   := 0.U

    }
    // Slam change reg back to zero, such that it is just a pulse.
    when(change === 1.U){
        change      := 0.U
        changed     := 0.U
    }

    when(change === 1.U){
        
        // On first change
        when(changedOne === 0.U){
            // Ensure this only happens once, for every 0 | 1
            changedOne  := 1.U
            // Reset delta counter
            deltaCntr   := 0.U
            // Reset syncWord detection
            syncWord    := 0.U                        
        } 

        // Detect a one, if it's been x < LastOne cycles since last change.
        when((deltaCntr <= lastOne) & (changedOne === 1.U)){
            /*
                DATA DETECT 1
            */
            // Set data output            
            dataOut     := 1.U            
            // Expect it to be a 1
            zeroPeriode := 0.U            
            // Store the number of cycles since last change (live adjust expected cycles of a 1)
            //lastOne     := deltaCntr
            // Get ready for next 1
            changedOne  := 0.U     
            // Reset delta counter   
            deltaCntr   := 0.U
        }
    }

    // If the delta clock counter is above what is expected of a 1:
    when((deltaCntr > (lastOne))){
        /*
            DATA DETECT 0
        */
        // Set data output
        dataOut         := 0.U
        // Note that we're now in a zero-periode, and thus need clk-regeneration.
        zeroPeriode     := 1.U
        // We're not in a syncWord
        syncWord        := 0.U
        // Get ready for next 0 | 1
        changedOne      := 0.U
    }

    when((deltaCntr > (lastOne * 2.U))){
        // Detect syncword.
        syncWord := 1.U
    }


    /*
        Clock Regeneration
    */


    // Whenever we're receiving ones, flip the clock-register
    //  on every change, as these are aligned to the wanted clock:
    when((change === 1.U)){
        clkRec  := ~clkRec
    }

    // Whenever we're in a zero-periode, we can't rely on rising/trailing edges. 
    // Thus we rely on the last one-cycle cyclecounter, and incoming changes, 
    // to approximate when to flip the clk-register.
    when((deltaCntr >= lastOne) & (changed === 0.U) & (change =/= 1.U)){
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

    // Instantiate blackboxed PLL.
    val pll = Module(new clk_wiz_0_clk_wiz)   

    // Connect recovered clock reg to PLL input.
    pll.io.PLL_IN := clockRec.io.CLK_OUT

    // Once PLL is locked
    when(pll.io.locked === 1.U){
        io.CLK_REC := pll.io.PLL_MCLK
    }
    .otherwise{
        io.CLK_REC := 0.U
    }

}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
