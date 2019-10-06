(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((first '()) (rest '()))
      (begin
        (set! first (eval (first-operand exps)))
        (set! rest (list-of-values (rest-operands exps) env))
        (cons first rest)))))


(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((first '()) (rest '()))
      (begin
        (set! rest (list-of-values (rest-operands exps) env))
        (set! first (eval (first-operand exps)))
        (cons first rest)))))
