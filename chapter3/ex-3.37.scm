(define (c- a b)
  (let ((d (make-connector)))
    (adder b d a)
    d))

(define (c* a b)
  (let ((p (make-connector)))
    (mulitplier a b p)
    p))

(define (c/ a b)
  (let ((div (make-connector)))
    (multiplier div b a)
    div))

(define (cv a)
  (let ((c (make-connector)))
    (constant a c)
    c))