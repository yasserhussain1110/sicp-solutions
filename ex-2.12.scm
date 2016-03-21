(load "center-width-interval.scm")

(define (make-center-tolerance center percentage-tolerance)
  (make-center-width center (* (/ percentage-tolerance 100) center)))

(define (tolerance interval)
  (let ((w (width interval)) (c (center interval)))
    (* (/ w c) 100)))
