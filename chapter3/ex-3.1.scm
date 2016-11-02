

(define (make-accumulator init)
  (lambda (val)
    (set! init (+ init val))
    init))


;; Test

(define A (make-accumulator 5))
(define B (make-accumulator -5))

(A 0)
(A 10)
(A 5)
(B 20)