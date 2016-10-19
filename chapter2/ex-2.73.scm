(load "op-type-table.scm")

;; common stuff

(define (make-sum addend augend)
  (list '+ addend augend))

(define (addend exp)
  (car exp))

(define (augend exp)
  (cadr exp))

(define (make-product multiplier multiplicand)
  (list '* multiplier multiplicand))

(define (multiplier exp)
  (car exp))

(define (multiplicand exp)
  (cadr exp))

(define (exponent exp)
  (cadr exp))

(define (base exp)
  (car exp))

(define (make-power base exp)
  (list '^ base exp))



;; package definitions

(define (install-power-package)
  (define (deriv-power exp var)
    (let ((b (base exp)) (e (exponent exp)))
      (make-product (make-product e (make-power b (- e 1)))
                    (deriv b var))))

  (put 'deriv '^ deriv-power)
  'done)

(define (install-product-package)
  (define (deriv-product exp var)
    (make-sum
     (make-product (multiplier exp)
                   (deriv (multiplicand exp) var))
     (make-product (deriv (multiplier exp) var)
                   (multiplicand exp))))

  (put 'deriv '* deriv-product)
  'done)

(define (install-sum-package)
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))

  (put 'deriv '+ deriv-sum)
  'done)


;; Test Cases Here

;; First Install packages

(install-sum-package)
(install-product-package)
(install-power-package)

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operand exp) var))))

(define (same-variable? var1 var2)
  (and (variable? var1) (variable? var2) (eq? var1 var2)))

(define (variable? expr)
  (symbol? expr))

(define (operator exp) (car exp))

(define (operand exp) (cdr exp))

(deriv (list '+ 1 (list '+ 3 2)) 'x)

(deriv (list '+ 1 (list '+ 3 2)) 'x)

(deriv '(+ 1 (+ 3 2)) 'x)

(deriv '(* 1 2) 'x)

(deriv '(^ x 1) 'x)