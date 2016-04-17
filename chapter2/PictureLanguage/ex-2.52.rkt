#lang racket
(require sicp-pict)
(require "ex-2.44.rkt")

; einstein
(define wave (load-painter (string->path "wave.gif")))
(define rogers (load-painter (string->path "rogers.gif")))

(define (corner-split-mod painter n)
  (if (= n 0)
      painter
      (let ((top (beside (up-split painter (- n 1)) (corner-split painter (- n 1))))
            (bottom (beside painter (right-split painter (- n 1)))))
        (below bottom top))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((transform (square-of-four flip-horiz identity rotate180 flip-vert)))
    (transform (corner-split (flip-horiz painter) n))))



(define (square-limit-2 painter n) 
  (let ((combine4 (square-of-four flip-vert rotate180 
                                  identity flip-horiz))) 
    (combine4 (corner-split painter n))))

;(paint (corner-split-mod einstein 2))
(paint (square-limit rogers 2))
(paint (square-limit-2 rogers 2))