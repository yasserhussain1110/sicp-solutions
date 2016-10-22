(load "complex-number-package.scm")
(load "rational-number-package.scm")
(load "math-op.scm")

(define (install-raise)

  (put 'raise '(integer) (lambda (x) (make-rational-number x 1)))

  (put 'raise '(rational) (lambda (x) (/ (/ (numer x) 1.0) (denom x))))

  (put 'raise '(real) (lambda (x) (make-complex-from-real-imag x 0)))


  'done)


(define (raise num) (apply-generic 'raise num))

; For testing

(install-rational-package)
(install-complex-package)
(install-raise)


(define (attach-tag type-tag contents)
  (cond ((eq? type-tag 'real) contents)
        ((eq? type-tag 'integer) contents)
        (else (cons type-tag contents))))

(define (type-tag datum)
  (cond ((integer? datum) 'integer)
        ((real? datum) 'real)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((integer? datum) datum)
        ((real? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))




(raise  2)
(raise (make-rational-number 2 3))
(raise 1.5)