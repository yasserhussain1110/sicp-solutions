(load "op-type-table.scm")
(load "poly.scm")

(define (install-zero?-for-polynomials)


  (define (first-term term-list) (car term-list))

  (define (rest-term term-list) (cdr term-list))

  (define (empty-termlist? term-list) (null? term-list))

  (define (order term) (car term))

  (define (coeff term) (cadr term))


  (define (poly-zero? poly)

    (define (termlist-zero? L)
      (if (empty-termlist? L)
          #t
          (let ((t1 (first-term L)))
            (if (=zero? (coeff t1))
                (termlist-zero (rest-terms L))
                #f))))

    (termlist-zero? (term-list poly)))

  (put '=zero? '(polynomial) poly-zero?)

  'done)

(install-zero?-for-polynomials)