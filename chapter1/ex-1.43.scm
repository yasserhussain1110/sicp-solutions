(load "ex-1.42.scm")

(define (repeated f n)
  (define (f-to-f n)
    (if (= n 1)
	f
	(compose f (f-to-f (- n 1)))))
  (f-to-f n))
