#lang racket
(require sicp-pict)

(provide (all-defined-out))

; einstein
(define wave (load-painter (string->path "wave.gif")))
(define rogers (load-painter (string->path "rogers.gif")))


(define (flip-horiz painter)
  ((transform-painter (make-vect 1 0)
                      (make-vect 0 0)
                      (make-vect 1 1))
   painter))

(define (rotate180 painter)
  ((transform-painter (make-vect 1 1)
                      (make-vect 0 1)
                      (make-vect 1 0))
   painter))

(define (rotatecounter270 painter)
  ((transform-painter (make-vect 0 1)
                      (make-vect 0 0)
                      (make-vect 1 1))
   painter))

;(define test (flip-horiz einstein))
;(paint test)

;(define test2 (rotate180 einstein))
;(paint test2)

;(define test3 (rotatecounter270 einstein))
;(paint test3)