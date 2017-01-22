(define (has-cycle? x)
  (define (has-come-back? x y)
    (cond ((or (null? x) (null? y) (null? (cdr y))) #f)
          ((eq? x y) #t)
          (else (has-come-back? (cdr x) (cddr y)))))
  (has-come-back? x (cdr x)))

(define t1 '(a b))
(set-cdr! (cdr t1) t1)
(has-cycle? t1)

(define t1 '(a))
(set-cdr! t1 t1)
(has-cycle? t1)

(define t1 '(a b c d e))
(set-cdr! (cdddr t1) (cdr t1))
(has-cycle? t1)

(define t1 '(a b c d e))
(has-cycle? t1)