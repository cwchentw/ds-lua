--- `ds.Evaluation` class.
-- Evaluation of binary classifiers.
-- @classmod Evaluation
local Evaluation = {}
package.loaded['Evaluation'] = Evaluation

Evaluation.__index = Evaluation

--- Sensitivity.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return Sensitivity (number).
function Evaluation:sensitivity(tp, fp, tn, fn)
  return tp / (tp + fn)
end

--- Specificity.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return Specificity (number).
function Evaluation:specificity(tp, fp, tn, fn)
  return tn / (fp + tn)
end

--- Positive Predictive Value.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return Positive predictive value (number).
function Evaluation:ppv(tp, fp, tn, fn)
  return tp / (tp + fp)
end

--- Negative Predictive Value.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return Negative predictive value (number).
function Evaluation:npv(tp, fp, tn, fn)
  return tn / (tn + fn)
end

--- True Positive Rate.
-- An alias to sensitivity.
function Evaluation:tpr(tp, fp, tn, fn)
  return self:sensitivity(tp, fp, tn, fn)
end

--- True Negative Rate.
-- An alias to specificity.
function Evaluation:fnr(tp, fp, tn, fn)
  return self:specificity(tp, fp, tn, fn)
end

--- False Positive Rate.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return False positive rate (number).
function Evaluation:fpr(tp, fp, tn, fn)
  return fp / (fp + tn)
end

--- False Negative Rate.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return False negative rate (number).
function Evaluation:fnr(tp, fp, tn, fn)
  return fn / (tp + fn)
end

--- False Discovery Rate.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return False discovery rate (number).
function Evaluation:fdr(tp, fp, tn, fn)
  return fp / (tp + fp)
end

--- Precision.
-- An alias to positive predictive value.
function Evaluation:precision(tp, fp, tn, fn)
  return self:ppv(tp, fp, tn, fn)
end

--- Recall.
-- An alias to sensitivity.
function Evaluation:recall(tp, fp, tn, fn)
  return self:sensitivity(tp, fp, tn, fn)
end

--- Accuracy.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @return Accuracy (number).
function Evaluation:acc(tp, fp, tn, fn)
  return (tp + tn) / (tp + fp + fn + tn)
end

--- F score.
-- @param tp true positive
-- @param fp false positive
-- @param tn true negative
-- @param fn false negative
-- @param beta Optional.  Beta value, default to 1.
-- @return F score (number).
function Evaluation:f(tp, fp, tn, fn, beta)
  local b = 1
  if beta then
    b = beta
  end

  local precision = self:precision(tp, fp, tn, fn)
  local recall = self:recall(tp, fp, tn, fn)

  return (1 + b ^ 2) * (precision * recall) / ((b ^ 2) * precision + recall)
end

return Evaluation
