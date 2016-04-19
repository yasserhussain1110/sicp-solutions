(load "deriv.scm")

(define (exponentiation? expr)
  (and (pair? expr) (eq? '** (car expr))))

(define (base expr)
  (cadr expr))

(define (exponent expr)
  (caddr expr))

(define (exponent-is-number? expr)
  (number? (exponent expr)))

(define (make-exponentiation base expo)
  (cond ((= expo 0) 1)
	((= expo 1) base)
	(else (list '** base expo))))

(define (deriv expr var)
  (cond ((number? expr) 0)
	((variable? expr) (if (same-variable? expr var) 1 0))
	((sum? expr)
	 (make-sum (deriv (addend expr) var) (deriv (augend expr) var)))
	((product? expr)
	 (let ((multiplier-deriv (deriv (multiplier expr) var))
	       (multiplicand-deriv (deriv (multiplicand expr) var)))
	   (make-sum
	    (make-product (multiplier expr) multiplicand-deriv)
	    (make-product (multiplicand expr) multiplier-deriv))))
	((and (exponentiation? expr) (exponent-is-number? expr))
	 (let ((exp-base (base expr))
	       (exp-expo (exponent expr)))
	   (make-product exp-expo
			 (make-product (make-exponentiation exp-base (- exp-expo 1))
				       (deriv exp-base var)))))
	(else (error "Unknown Expression" expr))
	))
