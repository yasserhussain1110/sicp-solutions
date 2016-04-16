#lang racket

(require (only-in sicp-pict paint))
(require (only-in sicp-pict frame-coord-map))
(require "ex-2.48.rkt")
(require "ex-2.46.rkt")
(require graphics/graphics)
(open-graphics)
(define vp (open-viewport "A Picture Language" 200 200))

(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))

(provide (all-defined-out))

;need a wrapper function so that the graphics library works with my code...
(define (vector-to-posn v)
  (make-posn (xcor-vect v) (ycor-vect v)))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (let ((mapper (frame-coord-map frame)))
                  (line
                   (vector-to-posn (mapper (start-segment segment)))
                   (vector-to-posn (mapper (end-segment segment))))))
              segment-list)))

;(define segment1 (make-segment (make-vect 0.5 0.5) (make-vect 1 1)))
;(define segment2 (make-segment (make-vect 0 0) (make-vect 1 1)))
;(define segment3 (make-segment (make-vect 0.11 0.23) (make-vect 0.54 0.65)))
;(paint (segments->painter (list segment1 segment2 segment3)))