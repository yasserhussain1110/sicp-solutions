(define (accumulate op init sequence)
  (if (null? sequence)
      init
      (op (car sequence) (accumulate op init (cdr sequence)))))
