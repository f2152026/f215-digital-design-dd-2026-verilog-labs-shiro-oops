module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  integer exp_gt, exp_lt, exp_eq;
  integer errors;
  integer total;
  integer i, j;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    total  = 0;

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;

        exp_eq = (i == j);
        exp_gt = (i > j);
        exp_lt = (i < j);

        total = total + 1;

        if ({t_gt, t_lt, t_eq} !== {exp_gt[0], exp_lt[0], exp_eq[0]}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                    $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("Summary: ");
    $write("%0d", total - errors);
    $write(" / ");
    $write("%0d", total);
    $display(" passed.");

    $finish;
  end

endmodule