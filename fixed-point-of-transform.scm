(load "fixed-point.scm")
(define (fixed-point-of-transform f transform guess)
  (fixed-point (transform f) guess))
