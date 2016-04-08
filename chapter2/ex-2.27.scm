(define (deep-reverse l1)
  (define (add-inverted-l1-to-l2 l1 l2)
    (if (null? l1)
	l2
	(let ((first-element (car l1)))
	  (if (pair? first-element)
	      (add-inverted-l1-to-l2 (cdr l1) (cons (deep-reverse first-element) l2))
	      (add-inverted-l1-to-l2 (cdr l1) (cons first-element l2))))))
  (add-inverted-l1-to-l2 l1 '()))
