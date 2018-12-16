(define (averager a b c)
  (let ((v (make-connector))
        (w (make-connector)))
    (adder a b v)
    (constant 2 w)
    (multiplier w c v)))

; 2 * (a + b) = c => (a +b)/2 = c