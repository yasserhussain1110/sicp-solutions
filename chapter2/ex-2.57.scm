(load "ex-2.56.scm")

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
	((and (not (pair? expr1)) (sum? expr2)) (cons '+ (cons expr1 (cdr expr2))))
	((and (not (pair? expr2)) (sum? expr1)) (append expr1 (list expr2)))
	((and (sum? expr1) (sum? expr2)) (append '(+) (cdr expr1) (cdr expr2)))
	(else (list '+ expr1 expr2))))

(define (addend expr)
  (cadr expr))

(define (augend expr)
  (let ((rest-of-list (cddr expr)))
    (if (= 1 (length rest-of-list))
	(car rest-of-list)
	(cons '+ rest-of-list))))

(define (product? expr)
  (and (pair? expr) (eq? (car expr) '*)))

(define (make-product expr1 expr2)
  (cond ((or (=number? expr1 0) (=number? expr2 0)) 0)
	((=number? expr1 1) expr2)
	((=number? expr2 1) expr1)
	((and (number? expr1) (number? expr2)) (* expr1 expr2))
	((and (not (pair? expr1)) (product? expr2)) (cons '* (cons expr1 (cdr expr2))))
	((and (not (pair? expr2)) (product? expr1)) (append expr1 (list expr2)))
	((and (product? expr1) (product? expr2)) (append '(*) (cdr expr1) (cdr expr2)))
	(else (list '* expr1 expr2))))

(define (multiplier expr)
  (cadr expr))

(define (multiplicand expr)
  (let ((rest-of-list (cddr expr)))
    (if (= 1 (length rest-of-list))
	(car rest-of-list)
	(cons '* rest-of-list))))
