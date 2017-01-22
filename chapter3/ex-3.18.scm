(define (has-cycle? val)
  (define (has-cycle-inner? x encountered)
    (if (not (pair? x))
        #f
        (let ((p2 (cdr x)))
          (cond ((null? p2) #f)
                ((memq p2 encountered) #t)
                ((has-cycle-inner? p2 (cons x encountered)))))))
  (has-cycle-inner? val '()))


(define t1 '(a b))
(set-cdr! (cdr t1) t1)
(has-cycle? t1)

(define t1 '(a))
(set-cdr! t1 t1)
(has-cycle? t1)

#|
(define s '(b c))
(define p2 (cons s '(d e)))
(define p1 (cons s p2))
(has-cycle? p1)
|#