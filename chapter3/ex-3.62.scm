(load "ex-3.59.scm")
(load "ex-3.60.scm")

(define (invert-series s)
  (if
    (eq? (stream-car s) 0)
    (error "Constant value must not be zero" s)
    (cons-stream (/ 1 (stream-car s)) (scale-stream (mul-series (invert-series s) (stream-cdr s)) (/ -1 (stream-car s))))))

(define test (mul-series cosine-series (invert-unit-series cosine-series)))

(define (div-series s1 s2) (mul-series s1 (invert-series s2)))

(define tangent-series (div-series sine-series cosine-series))
