(define (my-cons x y)
  (lambda (m) (m x y)))

(define (my-car x)
  (x (lambda (p q) p)))

(define (my-cdr x)
  (x (lambda (p q) q)))
