(define (eval exp env)
  (define (lookup-and-eval table)
    (let ((top (car table)))
      (let ((type (car top)) (eval-proc (cadr top)))
        (cond
          ((null? type) (eval-proc exp env))
          ((eq? (car exp) type) (eval-proc exp env))
          (else (lookup-and-eval (cdr table)))))))
  (lookup-and-eval the-table))
