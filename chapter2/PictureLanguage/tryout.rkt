#lang racket
(require sicp-pict)

(provide (all-defined-out))

; einstein
(define wave (load-painter (string->path "wave.gif")))
(define rogers (load-painter (string->path "rogers.gif")))

(define (flipped-pair painter)
    (let ((painter2 (beside painter (flip-vert painter))))
          (below painter2 painter2)))
