import chisel3._
import chisel3.util._


class intervox_Decoder() extends Module {
  val io = IO(new Bundle {
    val DATA_I = Input(UInt(1.W))
  })

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
}