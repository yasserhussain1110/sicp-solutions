(load "iterative-improve.scm")
;;For Square Root

(define (improve-sqrt guess x)
  (average guess (/ x guess)))

(define (average a b)
  (/ (+ a b) 2))

(define (good-enough-sqrt? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define sqrt (lambda (x) ((iterative-improve good-enough-sqrt? improve-sqrt) 1.0 x)))


;;For Fixed-Point

(define (improve-fx guess f)
  (f guess))

(define tolerance-fx 0.00001)

(define (close-enough-fx? guess f)
  (< (abs (- guess (f guess))) tolerance-fx))


(define fixed-point (lambda (f guess) ((iterative-improve close-enough-fx? improve-fx) guess f)))
