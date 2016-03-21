(define (reverse list1)
  (define (add-inverted-l1-to-l2 l1 l2)
    (if (null? l1)
	l2
	(add-inverted-l1-to-l2 (cdr l1) (cons (car l1) l2))))
  (add-inverted-l1-to-l2 list1 '()))
