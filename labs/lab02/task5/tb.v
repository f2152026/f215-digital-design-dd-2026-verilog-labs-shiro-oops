module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  integer exp_result;
  integer errors, total;
  integer i;

  alu DUT (.a(t_a), .b(t_b), .op(t_op), .result(t_result));

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

    t_a = 4'd6; t_b = 4'd3;
    t_op = 0; #5;
    total = total + 1;
    exp_result = (t_a + t_b) & 4'hF;
    if (t_result !== exp_result[3:0]) begin
      $display("FAIL(add,fixed-operands) A=%0d B=%0d got=%0d exp=%0d", t_a, t_b, t_result, exp_result);
      errors = errors + 1;
    end

    t_op = 1; #5;
    total = total + 1;
    exp_result = (t_a - t_b) & 4'hF;
    if (t_result !== exp_result[3:0]) begin
      $display("FAIL(sub,fixed-operands) A=%0d B=%0d got=%0d exp=%0d", t_a, t_b, t_result, exp_result);
      errors = errors + 1;
    end

    for (i = 0; i < 8; i = i + 1) begin
      t_a  = i;
      t_b  = i + 1;
      t_op = 0;
      #5;
      total = total + 1;
      exp_result = (t_a + t_b) & 4'hF;
      if (t_result !== exp_result[3:0]) begin
        $display("FAIL(add) A=%0d B=%0d got=%0d exp=%0d", t_a, t_b, t_result, exp_result);
        errors = errors + 1;
      end

      t_op = 1;
      #5;
      total = total + 1;
      exp_result = (t_a - t_b) & 4'hF;
      if (t_result !== exp_result[3:0]) begin
        $display("FAIL(sub) A=%0d B=%0d got=%0d exp=%0d", t_a, t_b, t_result, exp_result);
        errors = errors + 1;
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