(load "op-type-table.scm")
(load "rational-number-package.scm")

(define
  (install-negation-operator-for-ordinary-rational-complex)

  (put 'neg '(scheme-number) (lambda (x) (* -1 x)))
  (put 'neg '(rational) (lambda (x) (make-rational (neg (numer x)) (denom x))))
  (put 'neg '(complex) (lambda (x) (if (eq? 'rectangular (type-tag x))
                                       (make-complex-from-real-imag (neg (real-part x))
                                                                    (neg (imag-part x)))
                                       (make-complex-from-mag-ang (magnitude x) (+ 180 (angle x))))))

  ;; Common poly methods

  (define (variable poly)
    (car poly))

  (define (term-list poly)
    (cdr poly))

  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (define (empty-termlist? term-list) (null? term-list))

  (define (make-term order coeff) (list order coeff))

  (define (order term) (car term))

  (define (coeff term) (cadr term))

  (define (rest-terms term-list) (cdr term-list))

  ;; Implementing neg for poly


  (define (negate-poly-term-list L)
    (if (empty-termlist? L)
        L
        (let ((t1 (first-term)))
          (adjoin-term (make-term (order t1) (neg (coeff t1)))
                       (negate-poly-term-list (rest-terms L))))))

  (put 'neg '(polynomial) (lambda (x) (make-polynomial
                                       (variable x)
                                       (negate-poly-term-list (term-list x)))))

  'done)

(define (neg x) (apply-generic 'neg x))

(define (sub x y) (add x (neg y)))