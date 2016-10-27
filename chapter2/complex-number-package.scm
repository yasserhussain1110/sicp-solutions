(load "op-type-table.scm")
(load "packages.scm")

(define (install-complex-package)

  (install-rectangular-package)
  (install-polar-package)

  (define (make-from-real-imag x y) ((get 'make-from-real-imag 'rectangular) x y))

  (define (make-from-mag-ang x y) ((get 'make-from-mag-ang 'polar) x y))

  (define (add x y) (make-from-real-imag
                     (+ (real-part x) (real-part y))
                     (+ (imag-part x) (imag-part y))))

  (define (sub x y) (make-from-real-imag
                     (- (real-part x) (real-part y))
                     (- (imag-part x) (imag-part y))))

  (define (mul x y) (make-from-mag-ang
                     (* (magnitude x) (magnitude y))
                     (+ (angle x) (angle y))))

  (define (div x y) (make-from-mag-ang
                     (/ (magnitude x) (magnitude y))
                     (- (angle x) (angle y))))

  (define (tag x) (attach-tag 'complex x))

  (put 'make-from-real-imag 'complex (lambda (x y) (tag (make-from-real-imag x y))))

  (put 'make-from-mag-ang 'complex (lambda (x y) (tag (make-from-mag-ang x y))))

  (put 'add '(complex complex) (lambda (x y) (tag (add x y))))

  (put 'sub '(complex complex) (lambda (x y) (tag (sub x y))))

  (put 'mul '(complex complex) (lambda (x y) (tag (mul x y))))

  (put 'div '(complex complex) (lambda (x y) (tag (div x y))))

  (put 'real-part '(complex) (lambda (x) (real-part x)))

  (put 'imag-part '(complex) (lambda (x) (imag-part x)))

  (put 'magnitude '(complex) (lambda (x) (magnitude x)))

  (put 'angle '(complex) (lambda (x) (angle x)))

  'done)

(install-complex-package)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang x y)
  ((get 'make-from-mag-ang 'complex) x y))
