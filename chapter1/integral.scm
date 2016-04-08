(load "series-sum.scm")
(define (integral f a b dx)
        (define (add-dx a) (+ a dx))
        (* (sum (/ (+ a dx) 2.0) b f add-dx) dx))
