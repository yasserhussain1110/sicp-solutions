(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? val1 val2) (< (abs (- val1 val2)) tolerance))
  (define (try-again guess)
    ;(display "guess was - ")
    ;(display guess)
    ;(display "\n")
    (let ((next (f guess)))
      (if (close-enough? next guess)
	  next
	  (try-again next))))
  (try-again first-guess))
