(load "stream-commons.scm")

; C1 - Stream of co-efficients
(define (integrate-series C1)
  (let ((integers (integers-from 1)))
    (stream-map / C1 integers)))


(define cosine-series
  (cons-stream 1 (stream-map (lambda (x) (* -1 x)) (integrate-series sine-series))))


(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
