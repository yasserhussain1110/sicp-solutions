(define (my-map f items)
  (if (null? items)
      '()
      (cons (f (car items)) (my-map f (cdr items)))))
