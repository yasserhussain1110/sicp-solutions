(load "op-type-table.scm")
(load "type-coercion-table.scm")
(load "scheme-number-package.scm")
(load "rational-number-package.scm")
(load "complex-number-package.scm")


(define (apply-generic op . args)

  (define (get-proc-for-arg-types args)
    (let ((type-tags (map type-tag args)))
      (get op type-tags)))

  (let ((proc-first-attempt (get-proc-for-arg-types args)))
    (if proc-first-attempt
        (apply proc-first-attempt args)
        (let ((coerced-args (coerce-args args)))
          (let ((proc-second-attempt (get-proc-for-arg-types coerced-args)))
            (if proc-second-attempt
                (apply proc-second-attempt args)
                (error "No method for these types"
                                (list op args))))))))

(define (coerce-args arg-list)
  (define (coerce-an-arg-for-all arg the-list)
    (if (null? the-list)
        arg
        (let ((type-val (type-tag arg)) (type-top-of-list (type-tag (car the-list))))
          (let ((coerce-proc (get-coercion type-val type-top-of-list)))
            (if coerce-proc
                (coerce-an-arg-for-all (coerce-proc arg) (cdr the-list))
                (coerce-an-arg-for-all arg (cdr the-list)))))))

  (define (coerce-all list-of-args)
    (if (null? list-of-args)
        '()
        (cons (coerce-an-arg-for-all (car list-of-args) arg-list)
              (coerce-all (cdr list-of-args)))))
    (coerce-all arg-list))



(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(put-coercion 'scheme-number 'rational (lambda (x) (make-rational-number (contents x) 1)))
(put-coercion 'scheme-number 'complex (lambda (x) (make-complex-from-real-imag (contents x) 0)))
(put-coercion 'rational 'complex (lambda (x)
                                   (let ((number (contents x)))
                                     (make-complex-from-real-imag
                                      (/ (numer number) (denom number))
                                      0))))

(define a (make-scheme-number 1))
(define b (make-rational-number 2 7))
(define c (make-complex-from-mag-ang 20 45))
(coerce-args (list a b c))


(put 'awesome-op '(complex complex) (lambda (x y) (make-complex-from-mag-ang 1234561 0)))
(define (awesome-op x y) (apply-generic 'awesome-op x y))

(awesome-op b c)

#|

   This is operation is not sufficiently general
   Ex. 1 - op1 for 'complex 'complex
   For arg types 'scheme-number 'scheme-number, op1 will not be invoked.


   Ex. 2 - op2 for 'rational 'complex
   For arg types 'scheme-number 'complex, op2 will not be invoked.

|#


