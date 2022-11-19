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
        val NEXT_FRAME  = Output (UInt(1.W))
    })

    // 100MHz MasterClock / Incoming (upto) 6.144 MHz = 16.27 CLK_CYCLES / Incoming Clock.
    // Ie. 16x oversampling should be possible.    
    val expected_cycles_syncword = (16.U * 4.U) - 1.U   // Syncword is 4 bit, hence * 4. 
    val expected_cycles_zero = 32.U - 1.U               // A transmitted zero will be sent @ BCLK = 3072MHz = ~sysclk/32.
    val expected_cycles_one = 16.U - 1.U                // A transmitted one will be sent @ BCLK*2 = 6144MHz = ~sysclk/16.
    val expected_nr_of_incoming_bits = 64.U - 1.U
    val oversampling_factor = 16.U - 1.U

    val clkCntr     = RegInit(0.U(8.W))
    val clkCntr1    = RegInit(0.U(8.W))
    val pllCntr     = RegInit(0.U(8.W))
    val bufCntr     = RegInit(0.U(8.W))
    val bitIn       = RegInit(0.U(16.W))
    val bitInBuf    = RegInit(0.U(16.W))
    val bitCntr     = RegInit(0.U(8.W))
    
    val outReg      = RegInit(0.U(1.W))
    val dataOut     = RegInit(0.U(1.W)) 
    val sync_lo     = RegInit(0.U(1.W))
    val sync_hi     = RegInit(0.U(1.W))
    val bitsReady   = RegInit(0.U(1.W))
    val change      = RegInit(0.U(1.W))
    val enaBuf      = RegInit(0.U(1.W))

    io.CLK_OUT      := outReg
    io.DATA_OUT     := change
    io.NEXT_FRAME   := 0.U

    // PLL Testing: 
    /*
        pllCntr := pllCntr + 1.U
        when(pllCntr === 7.U){      // (pllCntr === 3.U) = PLL_MCLK = 6.143 MHz | (pllCntr === 15.U) = PLL_MCLK = x... | (pllCntr === 7.U) = PLL_MCLK = 3.071 MHz
            outReg := ~outReg
            pllCntr := 0.U
        }
    */
    clkCntr := clkCntr + 1.U
    // Reset clkCntr, as a minimum, whenever a syncword periode (the longest periode) has elapsed.
    when(clkCntr === expected_cycles_syncword){
        clkCntr := 0.U
    }
    // Detect Syncword:
    when(bitCntr === 0.U){

        when(io.DATA_IN === 0.U){
            clkCntr1 := clkCntr1 + 1.U
            // When we've been low for three bit-periodes, we must have hit a syncWord.
            when(clkCntr1 === (expected_cycles_one * 3.U)){
                sync_lo := 1.U
            }
        }
        when(sync_lo === 1.U){
            clkCntr1 := clkCntr1 + 1.U
            // When we've been high for 1 bit-periodes, we must have hit the end of the syncWord.
            when(clkCntr1 === expected_cycles_syncword){
                sync_hi := 1.U
                clkCntr1 := 0.U
            }        
        }
    }

    // Wrap the bitCounter, once all expected bits are recieved.
    when(bitCntr === expected_nr_of_incoming_bits){
        bitCntr := 0.U
    }

    // Detect Changes in incoming data:
    when((sync_lo === 1.U) & (sync_hi === 1.U)){
        
        clkCntr1 := clkCntr1 + 1.U
        
        // Oversampling time!
        when(io.DATA_IN === 1.U){
            bitIn := bitIn | (1.U << (clkCntr1))
        }        

        // Wrap the counter and enable readout from the buffer.
        when(clkCntr1 === oversampling_factor){
            enaBuf      := 1.U
            clkCntr1    := 0.U
            // We don't want the buffer to be empty:
            when((bitIn <= 32512.U) & (bitIn > 0.U)){
                bitInBuf := bitIn
            }
            // Reset the incoming data register:
            bitIn       := 0.U
        }
        
        // Begin readout of buffer and then start to 
        // determine changes in the incoming data.
        when(enaBuf === 1.U){
            bufCntr := bufCntr + 1.U
            // Detect change in buffer bits:
            when(bitInBuf(bufCntr) =/= bitInBuf(bufCntr - 1.U)){
                outReg := ~outReg
            }
            when(bufCntr === expected_cycles_one){
                bufCntr := 0.U

                // Determine if zero or one: 
                when(bitIn(3.U) =/= bitIn(12.U)){
                    change := 1.U
                }.otherwise{
                    change := 0.U
                }
            }
        }
    }
    
    // Recovery flow: 
    /*
        Detect syncword (DATA_IN for x cycles)
        Through 8 cycles check for HI/LO on DATA_IN > Store this in a UINT
        Check for changes in each "bit" > use to determine when to flip the clockBit
    */

}


class interVox_Reciever() extends Module {
  val io = IO(new Bundle {
    val INTERVOX_IN = Input(UInt(1.W))
    val CLK_REC     = Output (UInt(1.W))
    val DATA_OUT    = Output (UInt(1.W))
    val NEXT_FRAME  = Output (UInt(1.W))
    val DBUG        = Output (UInt(1.W))
    val DBUG1       = Output (UInt(1.W))
  })

    val clockRec = Module(new clock_Recovery())

    clockRec.io.DATA_IN := io.INTERVOX_IN
    io.DATA_OUT         := clockRec.io.DATA_OUT
    io.NEXT_FRAME       := clockRec.io.NEXT_FRAME
    io.DBUG             := clockRec.io.CLK_OUT

    // Instantiate blackboxed PLL.
    val pll = Module(new clk_wiz_0_clk_wiz)   

    // Connect recovered clock reg to PLL input.
    pll.io.PLL_IN := clockRec.io.CLK_OUT

    // Once PLL is locked
    when(pll.io.locked === 1.U){
        io.CLK_REC := pll.io.PLL_MCLK
        io.DBUG1   := 1.U
    }
    .otherwise{
        io.CLK_REC := 0.U
        io.DBUG1   := 0.U
    }

    /*
  // Clock recovery

    // Should be a mux.. : 
    // Detect syncword
    when(intervox_in === 0)
        cycles++

    // Count sys-clk cycles between each rising edge
    when(intervox_in === 1)
        cycles++ 

    // When we've exceeded the amount of cycles expected for a syncword
    when (cycles > expected_periode_syncw)
        bit_cntr    := 0.U
        cycles      := 0.U

    // Determine if 1 | 0
    when(cycles >= expected_periode_0)

        when(cycles <  expected_periode_0){ 
            decoded_nxt := 1 
            bit_cntr++
        }
        when(cycles >= expected_periode_0){
            decoded_nxt := 0 
            bit_cntr++
        }

    when(bit_cntr === (64-4)) // (absolute framewidth) - (syncword width)
        ready_process := 1.U

  // Data extraction

    when(ready_process === 1.U){

        // Extract audio left and right data -> I2S transmitter
        // Extract CTRL_DATA. -> control logic.
        ready_process := 0.U
    }

    */
}

object HelloMain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new interVox_Reciever())
}
