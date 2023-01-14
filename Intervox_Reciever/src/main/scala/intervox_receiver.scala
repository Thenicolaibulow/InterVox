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



    io.CLK_OUT      := clkRec
    io.DATA_OUT     := dataOut
    io.DBUG         := change
    io.DBUG1        := syncWord
    io.LEDS         := lastOne

    deltaCntr    := deltaCntr + 1.U    

    // Edge detection.

    switch(io.DATA_IN){
        is(0.U){
            when(inBufr > 0.U){ // Trailing  \_ = inBufr b10 -> b00
                inBufr := inBufr - 1.U
            }
        }
        is(1.U){
            when(inBufr < 3.U){ // Rising  _/ = inBufr b01 -> b11
                inBufr := inBufr + 1.U
            }
        }
    }
    when((inBufr(0)) ^ (inBufr(1))){    // Difference in bits? - Must be change. 
        change := 1.U
    }


    when(change === 1.U){
        change := RegNext(RegNext(0.U, 0.U(1.W)), 0.U(1.W))
        clkRec      := ~clkRec
        deltaCntr   := 0.U        
        zeroFlipped := 0.U
        syncFlipped := 0.U
        syncFlipped1:= 0.U
    }
    
    // Data 1 Detect:
    when((deltaCntr <= (lastOne + 2.U))){
        syncWord := 0.U
        when(change === 1.U){
            dataOut := 1.U
        }
    }

    // Data 0 Detect:
    when((deltaCntr > (lastOne + 2.U)) & (deltaCntr < (lastOne * 2.U))){
        when(zeroFlipped === 0.U){
            // Flip clk and latch
            clkRec := ~clkRec
            zeroFlipped := 1.U
        }
        dataOut := 0.U
    }        



    // Syncword detection:
    when(change === 0.U){ // \ __ __ /\_/
        // Syncword clockRec edge-case
        when((deltaCntr > ((lastOne * 2.U) + 2.U)) & (deltaCntr < ((lastOne * 3.U) - 2.U))){
            when(syncFlipped === 0.U){
                // Flip clk and latch
                clkRec := ~clkRec
                syncFlipped := 1.U
            }
        }
        when(deltaCntr > (lastOne * 3.U)){
            syncWord := 1.U
            when(syncFlipped1 === 0.U){
                // Flip clk and latch
                clkRec := ~clkRec
                syncFlipped1 := 1.U
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
  })

    val clockRec = Module(new clock_Recovery())

    clockRec.io.DATA_IN := io.INTERVOX_IN

    io.LEDS             := clockRec.io.LEDS
    io.DATA_OUT         := clockRec.io.DATA_OUT
    io.CLK_DBUG         := clockRec.io.CLK_OUT
    io.DBUG1            := clockRec.io.DBUG1
    io.DBUG             := clockRec.io.DBUG

    // Instantiate blackboxed MMCM.
    // Input: 3.072 MHz, Output 6.144MHz, but configured as: 12.288MHz and 24.576 MHz.
    
    val pll = Module(new clk_wiz_0_clk_wiz)   

    // Connect recovered clock reg to PLL input.
    pll.io.CLK_IN := clockRec.io.CLK_OUT

    io.CLK_REC := pll.io.CLK_OUT 
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
