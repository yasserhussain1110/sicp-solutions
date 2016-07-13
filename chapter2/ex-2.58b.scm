(load "deriv.scm")
(load "flatmap.scm")
(load "deriv.scm")

(define (same-variable? var1 var2)
  (and (variable? var1) (variable? var2) (eq? var1 var2)))

(define (variable? expr)
  (symbol? expr))

(define (=number? expr n)
  (and (number? expr) (= n expr)))

(define (sum? expr)
  (and (pair? expr)
       (not (eq? false (memq '+ expr)))))

(define (addend expr)
  (let ((part (part-of-list-upto-symbol '+ expr)))
    (if (= 1 (length part))
	(car part)
	part)))

(define (augend expr)
  (let ((trail-exp (cdr (memq '+ expr))))
    (if (= (length trail-exp) 1)
	(car trail-exp)
	trail-exp)))

(define (make-sum expr1 expr2)
  (cond ((=number? expr1 0) expr2)
	((=number? expr2 0) expr1)
	((and (number? expr1) (number? expr2)) (+ expr1 expr2))
	(else (flatten (append '() (list expr1) (list '+) (list expr2))))))

(define (product? expr)
  (and (pair? expr)
       (not (sum? expr))
       (not (eq? false (memq '* expr)))))

(define (multiplier expr)
  (let ((part (part-of-list-upto-symbol '* expr)))
    (if (= 1 (length part))
	(car part)
	part)))

(define (multiplicand expr)
  (let ((trail-exp (cdr (memq '* expr))))
    (if (= (length trail-exp) 1)
	(car trail-exp)
	trail-exp)))

(define (make-product expr1 expr2)
  (cond ((or (=number? expr1 0) (=number? expr2 0)) 0)
	((=number? expr1 1) expr2)
	((=number? expr2 1) expr1)
	((and (number? expr1) (number? expr2)) (* expr1 expr2))

	((and (prod? expr1) (prod? expr2)) (flatten (append '() (list expr1) (list '*) (list expr2))))
	((and (prod? expr1) (single? expr2)) (flatten (append '() (list expr1) (list '*) (list expr2))))
	((and (single? expr1) (prod? expr2)) (flatten (append '() (list expr1) (list '*) (list expr2))))

	((and (prod? expr1) (sum? expr2)) (append '() expr1 (list '*) (list expr2)))
	((and (sum? expr1) (prod? expr2)) (append '() (list expr1) (list '*) expr2))

	(else (append '() (list expr1) (list '*) (list expr2)))))

;; convenience methods

(define (single? x)
  (or (symbol? x) (number? x)))

(define (part-of-list-upto-symbol sym l)
  (if (eq? (car l) sym)
      '()
      (cons (car l) (part-of-list-upto-symbol sym (cdr l)))))

(define (flatten l)
(flatmap (lambda (x)
	   (if (pair? x) x (list x))) l))
