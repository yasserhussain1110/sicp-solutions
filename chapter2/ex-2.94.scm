(load "math-op.scm")
(load "ex-2.91.scm")
(load "scheme-number-package.scm")
(load "mod-op-type-table.scm")

(define (same-variable? x y)
  (and (symbol? x) (symbol? y) (eq? x y)))

(define (make-poly variable term-list)
  (cons variable term-list))

(define (variable poly)
  (car poly))

(define (term-list poly)
  (cdr poly))

(define (add-poly poly1 poly2)
  (if (same-variable? (variable poly1) (variable poly2))
      (make-poly (variable poly1) (add-terms (term-list poly1)
                                             (term-list poly2)))
      
      (error "Polys not in same var -- ADD-POLY" (list poly1 poly2))))

(define (mul-poly poly1 poly2)
  (if (same-variable? (variable poly1) (variable poly2))
      (make-poly (variable poly1) (mul-terms (term-list poly1)
                                             (term-list poly2)))
      
      (error "Polys not in same var -- MUL-POLY" (list poly1 poly2))))

(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else
         (let ((t1 (first-term L1)) (t2 (first-term L2)))
           (cond ((> (order t1) (order t2))
                  (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                 ((< (order t1) (order t2))
                  (adjoin-term t2 (add-terms L1 (rest-terms L2))))
                 (else
                  (adjoin-term
                   (make-term (order t1)
                              (add (coeff t1) (coeff t2)))
                   (add-terms (rest-terms L1) (rest-terms L2)))))))))


(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term (make-term (+ (order t1) (order t2))
                                (mul (coeff t1) (coeff t2)))
                     (mul-term-by-all-terms t1 (rest-terms L))))))

(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

(define (the-empty-termlist) '())

(define (first-term term-list) (car term-list))

(define (rest-terms term-list) (cdr term-list))

(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))

(define (order term) (car term))

(define (coeff term) (cadr term))

(define (tag p) (attach-tag 'polynomial p))


(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))


(define (remainder-terms a b)
  (cdr (div-terms a b)))


(define (gcd-poly p1 p2)
  (make-poly
   (variable p1)
   (gcd-terms (term-list p1) (term-list p2))))


(install-scheme-number-package)

(define p1 (make-poly 'x '((4 1) (3 -1) (2 -1) (1 2))))
(define p2 (make-poly 'x '((3 1) (1 -1))))
;(gcd-poly p1 p2)