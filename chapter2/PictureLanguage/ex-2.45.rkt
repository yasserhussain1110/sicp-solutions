#lang racket
(require sicp-pict)

(provide (all-defined-out))

; einstein
(define wave (load-painter (string->path "wave.gif")))
(define rogers (load-painter (string->path "rogers.gif")))

(define (split action1 action2)
  (define (split-as-spec painter n)
    (if (= n 0)
        painter
        (let ((prev-painter (split-as-spec painter (- n 1))))
          (action1 painter (action2 prev-painter prev-painter)))))
  split-as-spec)
