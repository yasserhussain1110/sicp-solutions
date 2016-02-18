(load "deriv.scm")
(load "fixed-point.scm")
(define (newton-transform f)
  (lambda (x) (- x
		 (/ (f x)
		    ((deriv f) x)))))

(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))
