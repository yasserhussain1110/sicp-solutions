(load "segment.scm")

(define (midpoint-segment segment)
  (define (average a b) (/ (+ a b) 2.0))
  (make-point (average (x-point (start-segment segment)) (x-point (end-segment segment)))
	      (average (y-point (start-segment segment)) (y-point (end-segment segment)))))
