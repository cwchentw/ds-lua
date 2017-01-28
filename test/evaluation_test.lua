local Evaluation = require "ds.Evaluation"

do
  local tp = 20
  local fp = 180
  local fn = 10
  local tn = 1820

  assert(math.abs(Evaluation:sensitivity(tp, fp, tn, fn) - 0.66) < 0.01)
  assert(math.abs(Evaluation:specificity(tp, fp, tn, fn) - 0.91) < 0.01)
  assert(math.abs(Evaluation:ppv(tp, fp, tn, fn) - 0.1) < 0.01)
  assert(math.abs(Evaluation:npv(tp, fp, tn, fn) - 0.995) < 0.01)
  assert(math.abs(Evaluation:fpr(tp, fp, tn, fn) - 0.09) < 0.01)
  assert(math.abs(Evaluation:fnr(tp, fp, tn, fn) - 0.33) < 0.01)
end
