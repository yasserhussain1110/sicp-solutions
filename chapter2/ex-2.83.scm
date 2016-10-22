(load "complex-number-package.scm")
(load "rational-number-package.scm")
(load "real-number-package.scm")
(load "math-op.scm")

(define (install-raise-module)

  (put 'raise '(integer) (lambda (x) (make-rational-number x 1)))

  (put 'raise '(rational) (lambda (x) (make-real-number (/ (numer x) (denom x)))))

  (put 'raise '(real) (lambda (x) (make-complex-from-real-imag x 0)))


  'done)


(define (raise num) (apply-generic 'raise num))

; For testing

(install-rational-package)
(install-complex-package)
(install-real-package)
(install-raise-module)


(define (attach-tag type-tag contents)
  (cond ((eq? type-tag 'integer) contents)
        (else (cons type-tag contents))))

(define (type-tag datum)
  (cond ((integer? datum) 'integer)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((integer? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))




(raise  2)
(raise (make-rational-number 2 3))
(raise (make-real-number 1.5))