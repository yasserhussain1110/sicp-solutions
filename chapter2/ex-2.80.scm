(load "packages.scm")
(load "math-op.scm")

;;(load "rational-number-package.scm")
;;(load "complex-number-package.scm")

(define (install-is-zero-for-ordinary-rational-complex)

  (put '=zero? '(scheme-number) (lambda (x) (= x 0)))

  (define (numer x) (car x))
  
  (define (denom x) (cdr x))
  
  (put '=zero? '(rational) (lambda (x) (= 0 (numer x))))


  (put '=zero? '(complex) (lambda (x) (and (= (real-part x) 0)
                                           (= (imag-part x) 0))))

  'done)


(install-is-zero-for-ordinary-rational-complex)


(define (square x) (* x x))

;;(=zero? 0)
;;(=zero? (make-complex-from-mag-ang 0 90))
;;(=zero? (make-complex-from-real-imag 0 0))
;;(=zero? (make-rational-number 0 16))