(load "op-type-table.scm")

(define (install-real-package)
  
  (define (make-real x) (/ x 1.0))

  (define (tag x) (attach-tag 'real x))

  (put 'add '(real real) (lambda (x y) (tag (+ x y))))
  (put 'sub '(real real) (lambda (x y) (tag (- x y))))
  (put 'mul '(real real) (lambda (x y) (tag (* x y))))
  (put 'div '(real real) (lambda (x y) (tag (/ x y))))

  (put 'make 'real (lambda (x) (tag (make-real x))))

  'done)

(install-real-package)

(define (make-real-number x)
  ((get 'make 'real) x))