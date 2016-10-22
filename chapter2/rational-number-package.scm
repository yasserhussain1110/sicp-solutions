(load "op-type-table.scm")

(define (install-rational-package)
  
  (define (make-rat x y) (let ((g (gcd x y)))
                           (cons (/ x g) (/ y g))))
  
  
  (define (numer x) (car x))
  
  (define (denom x) (cdr x))
  
  (define (add-rat x y) 
    (make-rat
     (+ (* (numer x) (denom y))
        (* (numer y) (denom x)))
     (* (denom x) (denom y))))
  
  (define (sub-rat x y) 
    (make-rat
     (- (* (numer x) (denom y))
        (* (numer y) (denom x)))
     (* (denom x) (denom y))))
  
  (define (mul-rat x y) 
    (make-rat
     (* (numer x) (numer y))
     (* (denom x) (denom y))))
  
  (define (div-rat x y) 
    (make-rat
     (* (numer x) (denom y))
     (* (denom x) (numer y))))

  (define (tag x) (attach-tag 'rational x))

  (put 'add '(rational rational) (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational) (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational) (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational) (lambda (x y) (tag (div-rat x y))))

  (put 'make 'rational (lambda (x y) (tag (make-rat x y))))

  'done)

(install-rational-package)

(define (make-rational-number x y)
  ((get 'make 'rational) x y))

(define (numer x) (car x))
(define (denom x) (cdr x))

