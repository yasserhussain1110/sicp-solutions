(define (element-of-set? x set)
  (cond ((null? set) false)
	((equal? (car set) x) true)
	(else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set) set (cons x set)))


(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
	(else (let
		  ((elem1 (car set1)))
		(if (element-of-set? elem1 set2)
		    (cons elem1 (intersection-set (cdr set1) set2))
		    (intersection-set (cdr set1) set2))))))
