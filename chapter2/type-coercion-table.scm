(define coercion-table '())

(define (put-coercion type1 type2 func)
  (set! coercion-table (cons (list type1 type2 func) coercion-table)))

(define (get-coercion type1 type2)
  (define (search-coercion table)
    (if (null? table)
        #f
        (let ((top-element (car table)))
          (if (and (eq? (car top-element) type1)
                   (eq? (cadr top-element) type2))
              (caddr top-element)
              (search-coercion (cdr table))))))
  (search-coercion coercion-table))