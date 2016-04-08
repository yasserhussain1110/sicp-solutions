(define (fact-iter num)
    (define (iter product counter) (if (> counter num)
                                       product
                                       (iter (* product counter) (+ counter 1))))
    (iter 1 1))
