(load "continued-f.scm")

(define (tan-cf x k)

  (define (n-generator i) (if (= i 1) x (- (* x x))))

  (define (d-generator i) (- (* 2 i) 1.0))

  (cont-frac-i n-generator d-generator k))
