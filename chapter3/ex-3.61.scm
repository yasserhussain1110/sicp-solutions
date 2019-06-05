(load "ex-3.59.scm")
(load "ex-3.60.scm")

(define (invert-unit-series s)
  (cons-stream 1 (scale-stream (mul-series (stream-cdr s) (invert-unit-series s)) -1)))

(define test (mul-series cosine-series (invert-unit-series cosine-series)))
