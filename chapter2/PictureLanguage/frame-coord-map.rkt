#lang racket

(require "ex-2.46.rkt")
(require "ex-2.47.rkt")

(provide (all-defined-out))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect (origin-frame-1 frame)
              (add-vect
               (scale-vect (xcor-vect v)
                          (edge1-frame-1 frame))
               (scale-vect (ycor-vect v)
                          (edge2-frame-1 frame))))))
              