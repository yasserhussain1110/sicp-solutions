;; These functions are available in standard mit-scheme distribution
;; but not in racket.

(define (zip . list-of-lists)
  (if (null? (car list-of-lists))
      '()
      (cons (map car list-of-lists) (apply zip (map cdr list-of-lists)))))

(define (reduce function initial list)
  (if (null? list)
      initial
      (reduce function
              (function initial (car list))
              (cdr list))))
