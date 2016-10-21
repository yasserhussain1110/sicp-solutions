(load "packages.scm")
(load "math-op.scm")

(define (install-eq-for-ordinary-rational-complex)

  (put 'equ? '(scheme-number scheme-number) =)

  (define (numer x) (car x))
  
  (define (denom x) (cdr x))
  
  (put 'equ? '(rational rational) (lambda (x y) (=
                                                 (* (numer x) (denom y))
                                                 (* (denom x) (numer x)))))


  (put 'equ? '(complex complex) (lambda (x y) (if (eq? (type-tag x) (type-tag y))
                                                  (equ? x y)
                                                  (and
                                                   (= (real-part x) (real-part y))
                                                   (= (imag-part x) (imag-part y))))))

  'done)


(define (install-eq-for-complex)
  (put 'equ? '(rectangular rectangular) (lambda (x y)
                                          (and
                                           (= (real-part x) (real-part y))
                                           (= (imag-part x) (imag-part y)))))
  
  (put 'equ? '(polar polar) (lambda (x y)
                              (and
                               (= (magnitude x) (magnitude y))
                               (= (angle x) (angle y)))))

  'done)


(install-eq-for-complex)
(install-eq-for-ordinary-rational-complex)