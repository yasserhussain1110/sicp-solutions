(load "packages.scm")
(load "math-op.scm")

;;(load "rational-number-package.scm")
;;(load "complex-number-package.scm")

(define (install-eq-for-ordinary-rational-complex)

  (put 'equ? '(scheme-number scheme-number) =)

  (define (numer x) (car x))
  
  (define (denom x) (cdr x))

  (put 'equ? '(real real) =)
  
  (put 'equ? '(rational rational) (lambda (x y) (=
                                                 (* (numer x) (denom y))
                                                 (* (denom x) (numer x)))))


  (put 'equ? '(complex complex) (lambda (x y) (and (= (real-part x) (real-part y))
                                                   (= (imag-part x) (imag-part y)))))

  'done)


;;(install-eq-for-ordinary-rational-complex)
;;(equ? (make-rational-number 1 2) (make-rational-number 2 4))
;;(equ? (make-complex-from-real-imag 1 2) (make-complex-from-real-imag 1 2))