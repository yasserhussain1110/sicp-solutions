(define (tagged-list? exp tag)
  (and (pair? exp) (eq? (car exp) tag)))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
