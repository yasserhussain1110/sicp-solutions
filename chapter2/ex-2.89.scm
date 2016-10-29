(define (adjoin-term term term-list)

  (define (pad-term-list-with-zeros number-of-zeros)
    (if (= 0 number-of-zeros)
        term-list
        (cons 0 (pad-term-list-with-zeros (- number-of-zeros 1)))))
      
  
  (let ((c (coeff term)) (o (order term)))
    (if (=zero? c)
        term-list
        (cons c (pad-term-list-with-zeros (- o (length term-list)))))))

(define (the-empty-termlist) '())

(define (order-first-term term-list) (- (length term-list) 1))

(define (first-term term-list) (list (order-first-term term-list) (car term-list)))

(define (rest-terms term-list) (cdr term-list))

(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))

(define (order term) (car term))

(define (coeff term) (cadr term))