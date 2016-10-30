(load "math-op.scm")
(load "mod-op-type-table.scm")

(define (install-scheme-number-package)

  (define (tag x) (attach-tag 'scheme-number x))

  (put 'add '(scheme-number scheme-number) (lambda (x y) (tag (+ x y))))

  (put 'sub '(scheme-number scheme-number) (lambda (x y) (tag (- x y))))

  (put 'mul '(scheme-number scheme-number) (lambda (x y) (tag (* x y))))

  (put 'div '(scheme-number scheme-number) (lambda (x y) (tag (/ x y))))

  (put '=zero? '(scheme-number) (lambda (x) (= x 0)))

  (put 'make 'scheme-number (lambda (x) (tag x)))

  'done)

(install-scheme-number-package)


(define (make-scheme-number x)
  ((get 'make 'scheme-number) x))