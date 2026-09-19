// tb.v
// Starter testbench template -- YOU complete this file.
//
// Goal: apply all 8 combinations of I0, I1, S (5 time units apart) to DUT
// and observe the output. Fill in every TODO below.

module tb;

  // TODO: declare the three DUT inputs as the appropriate variable type.
  // Use exactly these names: t_i0, t_i1, t_s (needed by $monitor below).
  reg   t_i0, t_i1, t_s;
  wire  t_y;

  DUT U0 (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // TODO: instantiate DUT here, connecting t_i0, t_i1, t_s, t_y to its ports


  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U0);
    end
  end

  initial begin
    {t_i0, t_i1, t_s} = 3'b000; #5;
    {t_i0, t_i1, t_s} = 3'b001; #5;
    {t_i0, t_i1, t_s} = 3'b010; #5;
    {t_i0, t_i1, t_s} = 3'b011; #5;
    {t_i0, t_i1, t_s} = 3'b100; #5;
    {t_i0, t_i1, t_s} = 3'b101; #5;
    {t_i0, t_i1, t_s} = 3'b110; #5;
    {t_i0, t_i1, t_s} = 3'b111; #5;
    $finish;
    // TODO: apply all 8 combinations of t_i0, t_i1, t_s, 5 time units apart,
    // then $finish. (Same pattern you used in Lab 1's tb.v.)

  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule
