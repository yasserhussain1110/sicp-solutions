(define (my-for-each f items)
  (cond ((null? items) true)
	(else (f (car items))
	      (my-for-each f (cdr items)))))
  
