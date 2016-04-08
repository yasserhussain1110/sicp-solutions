(define (except-first-denom denominations)
  (cdr denominations))

(define (first-denom denominations)
  (car denominations))

(define (no-more? denominations)
  (null? denominations))
