(load "op-type-table.scm")

(define (install-generic-trig)

  (put 'sin '(real) (lambda (x) (make-real-number (sin x))))
  (put 'cos '(real) (lambda (x) (make-real-number (cos x))))
  (put 'tan '(real) (lambda (x) (make-real-number (tan x))))
  (put 'atan '(real) (lambda (x) (make-real-number (atan x))))

  (put 'sin '(integer) (lambda (x) (make-real-number (sin x))))
  (put 'cos '(integer) (lambda (x) (make-real-number (cos x))))
  (put 'tan '(integer) (lambda (x) (make-real-number (tan x))))
  (put 'atan '(integer) (lambda (x) (make-real-number (atan x))))

  (define (get-multiple-of-ten-which-removes-decimal multiple-of-ten num)
    (if (= (floor (* multiple-of-ten num)) (* multiple-of-ten num))
        multiple-of-ten
        (get-multiple-of-ten-which-removes-decimal (* multiple-of-ten 10) num)))

  (define (trig-function-for-rational trig)
    (lambda (x)
      (let ((trig-value (trig (/ (numer x) (denom x)))))
        (let ((multiple (get-multiple-of-ten-which-removes-decimal 1 trig-value)))
          (make-rational-number (trig-value * multiple) multiple)))))
    

  (put 'sin '(rational) (lambda (x) ((trig-function-for-rational sin) x)))
  (put 'cos '(rational) (lambda (x) ((trig-function-for-rational cos) x)))
  (put 'tan '(rational) (lambda (x) ((trig-function-for-rational tan) x)))
  (put 'atan '(rational) (lambda (x) ((trig-function-for-rational atan) x)))

  'done)


;; Test


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


(install-generic-trig)
(load "complex-number-package.scm")
(load "rational-number-package.scm")
(load "math-op.scm")
(load "ex-2.85.scm")
(load "ex-2.83.scm")
(load "ex-2.84.scm")

(install-complex-package)
(install-rational-package)
(install-raise-module)
(install-next-module)




;(add
;(make-complex-from-real-imag 10  20)
;(make-complex-from-real-imag (make-rational-number 1 2) (make-rational-number 2 4)))
