(load "continued-f.scm")

(define (multiple? num base) (= 0 (remainder num base)))

(define (euler-f i) (let ((pos (- i 2))) (if (multiple? pos 3) (* (+ (/ pos 3) 1) 2) 1)))

(+ (cont-frac-i (lambda (i) 1.0) euler-f 5) 2)
