(define (fast-exp b n)
    (define (is_odd? n) (= (remainder n 2) 1))
    (define (fast-exp-iter a b n) (cond ((= n 0) a)
                                        ((is_odd? n) (fast-exp-iter (* a b) b (- n 1)))
                                        (else (fast-exp-iter a (* b b) (/ n 2)))))
    (fast-exp-iter 1 b n))