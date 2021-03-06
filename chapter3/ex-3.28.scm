(define or-delay 2000)

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    ((let ((new-value (logical-or (get-signal a1) (get-signal a2))))
       (after-delay or-delay
                    (lambda ()
                      (set-signal! output new-value))
                    ))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
)

(define (logical-or a b)
  (cond ((and (= a 0) (= b 0)) 0)
        ((and (= a 0) (= b 1)) 1)
        ((and (= a 1) (= b 0)) 1)
        ((and (= a 1) (= b 1)) 1)
        (else (error "Invalid Signal" a b))))