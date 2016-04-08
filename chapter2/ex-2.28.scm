(define (fringe-iter items)
  (define (iterative-fringe l r)
    (cond ((null? l) r)
	  ((pair? (car l)) (iterative-fringe (cdr l) (append (fringe-iter (car l)) r)))
	  (else (iterative-fringe (cdr l) (cons (car l) r)))))
  (iterative-fringe (reverse items) '()))


(define (fringe-recur l)
  (if (null? l)
      '()
      (let ((p1 (car l)) (p2 (cdr l)))
	(if (pair? p1)
	    (append (fringe p1) (fringe p2))
	    (cons p1 (fringe p2))))))
      
