#lang racket
(require sicp-pict)
(require (only-in "ex-2.50.rkt" rotatecounter270))

; einstein
(define wave (load-painter (string->path "wave.gif")))
(define rogers (load-painter (string->path "rogers.gif")))

(define (below-1 painter1 painter2)
    (let ((lower ((transform-painter (make-vect 0 0)
                                     (make-vect 1 0)
                                     (make-vect 0 0.5))
                  painter1))

          (upper ((transform-painter (make-vect 0 0.5)
                                     (make-vect 1 0.5)
                                     (make-vect 0 1))
                  painter2)))
      (lambda (frame)
	(lower frame)
	(upper frame))))

(define (below-2 painter1 painter2)
  (rotate180 (rotatecounter270
	      (beside (rotatecounter270 painter1)
		      (rotatecounter270 painter2)))))

(paint (below-1 rogers einstein))
(paint (below-2 rogers einstein))