(load "poly.scm")
(load "math-op.scm")
(load "mod-op-type-table.scm")

(define (install-rational-package)
  
  (define (make-rat x y) (cons x y))
  
  (define (numer x) (car x))
  
  (define (denom x) (cdr x))
  
  (define (add-rat x y) 
    (make-rat
     (add (mul (numer x) (denom y))
          (mul (numer y) (denom x)))
     (mul (denom x) (denom y))))
  
  (define (sub-rat x y) 
    (make-rat
     (sub (mul (numer x) (denom y))
          (mul (numer y) (denom x)))
     (mul (denom x) (denom y))))
  
  (define (mul-rat x y) 
    (make-rat
     (mul (numer x) (numer y))
     (mul (denom x) (denom y))))
  
  (define (div-rat x y) 
    (make-rat
     (mul (numer x) (denom y))
     (mul (denom x) (numer y))))

  (define (tag x) (attach-tag 'rational x))

  (put 'add '(rational rational) (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational) (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational) (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational) (lambda (x y) (tag (div-rat x y))))

  (put 'make 'rational (lambda (x y) (tag (make-rat x y))))

  'done)

(install-rational-package)
(install-polynomial-package)
(install-scheme-number-package)

(define (make-rational x y)
  ((get 'make 'rational) x y))

(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))

(define rf (make-rational p2 p1))
(define a (add rf rf))
a

