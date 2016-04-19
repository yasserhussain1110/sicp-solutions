(define (same-variable? var1 var2)
  (and (variable? var1) (variable? var2) (eq? var1 var2)))

(define (variable? expr)
  (symbol? expr))

(define (sum? expr)
  (and (pair? expr) (eq? (car expr) '+)))

(define (=number? expr n)
  (and (number? expr) (= n expr)))

(define (make-sum expr1 expr2)
  (cond ((=number? expr1 0) expr2)
	((=number? expr2 0) expr1)
	((and (number? expr1) (number? expr2)) (+ expr1 expr2))
	(else (list '+ expr1 expr2))))

(define (addend expr)
  (cadr expr))

(define (augend expr)
  (caddr expr))

(define (product? expr)
  (and (pair? expr) (eq? (car expr) '*)))

(define (make-product expr1 expr2)
  (cond ((or (=number? expr1 0) (=number? expr2 0)) 0)
	((=number? expr1 1) expr2)
	((=number? expr2 1) expr1)
	((and (number? expr1) (number? expr2)) (* expr1 expr2))
	(else (list '* expr1 expr2))))

(define (multiplier expr)
  (cadr expr))

(define (multiplicand expr)
  (caddr expr))

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
	(else (error "Unknown Expression" expr))
	))
