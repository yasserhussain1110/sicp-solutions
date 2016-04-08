(load "accumulate.scm")
(define (count-leaves t)
  (accumulate + 0
	      (map (lambda (x)
		     (cond ((not (pair? x)) 1)
			   (else (count-leaves x)))) t)))
