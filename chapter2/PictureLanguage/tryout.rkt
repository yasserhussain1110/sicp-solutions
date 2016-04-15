#lang racket
(#%require sicp-pict)
; einstein
(define wave (load-painter (string->path "wave.gif")))
(define roger (load-painter (string->path "roger.gif")))

(define (flipped-pair painter)
    (let ((painter2 (beside painter (flip-vert painter))))
          (below painter2 painter2)))
