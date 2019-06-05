(load "stream-commons.scm")
(load "ex-3.59.scm")

; This works for infinite streams
(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams
      (scale-stream (stream-cdr s2) (stream-car s1))
      (mul-series (stream-cdr s1) s2))))

(define ones (cons-stream 1 ones))

(define twos (stream-map (lambda (x) (* x 2)) ones))

(define m (mul-series ones ones))

(define test (add-streams (mul-series sine-series sine-series) (mul-series cosine-series cosine-series)))
