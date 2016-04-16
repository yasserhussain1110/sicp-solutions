#lang racket
(require sicp-pict)
(require graphics/graphics)

(define outline->painter
  (let
      ((left (make-segment (make-vect 0 0) (make-vect 0 1)))
       (bottom (make-segment (make-vect 0 0) (make-vect 1 0)))
       (right (make-segment (make-vect 1 0) (make-vect 1 1)))
       (top (make-segment (make-vect 0 1) (make-vect 1 1))))
    (segments->painter (list left bottom right top))))

(define x->painter
  (let
      ((bottom-left (make-segment (make-vect 0 0) (make-vect 1 1)))
       (top-left (make-segment (make-vect 0 1) (make-vect 1 0))))
    (segments->painter (list bottom-left top-left))))

(define diamond->painter
  (let
      ((part-1 (make-segment (make-vect 0.5 0) (make-vect 0 0.5)))
       (part-2 (make-segment (make-vect 0 0.5) (make-vect 0.5 1)))
       (part-3 (make-segment (make-vect 0.5 1) (make-vect 1 0.5)))
       (part-4 (make-segment (make-vect 1 0.5) (make-vect 0.5 0))))
    (segments->painter (list part-1 part-2 part-3 part-4))))