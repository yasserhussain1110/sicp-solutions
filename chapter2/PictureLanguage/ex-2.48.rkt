#lang racket

(provide (all-defined-out))

(define (make-segment v1 v2)
  (cons v1 v2))

(define (start-segment v)
  (car v))

(define (end-segment v)
  (cdr v))

