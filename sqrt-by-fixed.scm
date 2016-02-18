(load "fixed-point.scm")
(define (sqrt x)
  (define (average a b) (/ (+ a b) 2))
  (fixed-point (lambda (y) (average (/ x y) y)) 1.0))
