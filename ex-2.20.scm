(load "ex-2.18.scm")
(define (same-parity a . z)
  (define (is-parity-same? v) (equal? (even? a) (even? v)))
  (define (append-same-parity-vals list1 res)
    (if
     (null? list1)
     res
     (if (is-parity-same? (car list1))
	 (append-same-parity-vals (cdr list1) (cons (car list1) res))
	 (append-same-parity-vals (cdr list1) res))))
  (reverse (append-same-parity-vals (cons a z) '())))
