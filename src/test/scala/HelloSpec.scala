import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import chisel3._
import chisel3.util._
import org.scalatest.{Matchers, FlatSpec}


class I2S_Periph_spec extends AnyFlatSpec with ChiselScalatestTester {
  val bitdepth = 32 
  "I2S_Transmitter" should "pass" in {
    test(new I2S_Transmitter(bitdepth.U))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut => 
    
      dut.clock.setTimeout(0)
      println("Testing I2S transmitter!")

      for (i <- 0 until 65540) {
        //dut.io.sw.poke(((16 + 7) + ((16 + 7) << (bitdepth / 2))).U)
        dut.io.sw.poke(0.S)
        dut.clock.step()
        println("i: " + i)
      }
    }
  } 
}
/*
class I2S_trans_spec extends AnyFlatSpec with ChiselScalatestTester {
  val bitdepth = 32       
  "I2S_Transmitter" should "pass" in {
    test(new I2S_Transmitter(bitdepth.U))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.clock.setTimeout(0)
      println("Testing I2S transmitter!")


      for (i <- 0 until (bitdepth*4)) {
      
        // Assign arbitrary value to input vector.
        val state = dut.io.State_o.peek().litValue

        dut.io.tick.poke(1.U)

        if (state === 1){
          val cntr = (dut.io.BitCntr.peek().litValue).toInt

          dut.io.Tx.poke(((128 + 16 + 7) + ((128 + 16 + 7) << (bitdepth / 2))).U)

          println("BitCntr: " + cntr)
          println("Data: "+ (dut.io.DATA.peek().litValue))
        }               

        if ((state === 0)) {
          println("Reset State")   
        } 
        else if ((state === 1)) {
          println("Transmit State")   
        }
        // What about LRCLK?
        println("WS?: " + dut.io.LRCLK.peek().litValue) 
        // Next Clock
        dut.clock.step()
      }
    }
  }
}
*/