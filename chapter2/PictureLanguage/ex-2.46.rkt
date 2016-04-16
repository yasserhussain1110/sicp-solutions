#lang racket

(provide (all-defined-out))

(define (make-vect x-cor y-cor)
  (cons x-cor y-cor))

;; xcomp for x component would be a more appropriate name
(define (xcor-vect v)
  (car v))

;; ycomp for y component would be a more appropriate name
(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vect
   (+ (xcor-vect v1) (xcor-vect v2))
   (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect
   (- (xcor-vect v1) (xcor-vect v2))
   (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect
   (* s (xcor-vect v))
   (* s (ycor-vect v))))
