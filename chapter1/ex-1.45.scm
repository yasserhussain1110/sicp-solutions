(load "ex-1.43.scm")
(load "fixed-point-of-transform.scm")
(load "damp.scm")
(load "fast-power.scm")
;(define (sqrt-direct x) (fixed-point-of-transform (lambda (y) (/ x y)) damp 1.0))


(define (n-th-root x n)
  (let ((how-many-times-to-damp (floor (/ (log n) (log 2)))))
    (fixed-point-of-transform (lambda (y) (/ x (power y (- n 1)))) (repeated damp how-many-times-to-damp) 1.0)))
