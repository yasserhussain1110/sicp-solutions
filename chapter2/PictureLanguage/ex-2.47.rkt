#lang racket

(provide (all-defined-out))

;origin-frame

;edge1-frame

;edge2-frame

(define (make-frame-1 origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame-1 frame)
  (car frame))

(define (edge1-frame-1 frame)
  (cadr frame))

(define (edge2-frame-1 frame)
  (caddr frame))

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-2 frame)
  (car frame))

(define (edge1-frame-2 frame)
  (cadr frame))

(define (edge2-frame-2 frame)
  (cddr frame))
