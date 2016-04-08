(load "fixed-point.scm")
(load "damp.scm")
(define (sqrt x)
  (fixed-point (damp (lambda (y) (/ x y))) 1.0))
