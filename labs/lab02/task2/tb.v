// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [2:0] t_sel;  
  wire [7:0] t_dout;
  // TODO: instantiate DUT here
  lut #(.WIDTH(8), .DEPTH(8)) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end
  
  integer j;
  initial begin
    // TODO: apply different input combinations
    for (j = 0; j < 8; j = j + 1) begin
      t_sel = j;
      #5;
      if (t_dout !== (j * j))
        $display("FAIL at time %0t: sel=%0d dout=%0d expected=%0d",
                  $time, j, t_dout, j * j);
    end
    $finish;

  end

  initial
    $monitor($time, " sel=%0d dout=%0d", t_sel, t_dout); // change as required

endmodule
