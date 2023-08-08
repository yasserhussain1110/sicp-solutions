(define (f-recur n) (cond ((< n 3) n)
                          (else (+ (f-recur (- n 1)) 
                                   (* 2 (f-recur (- n 2)))
                                   (* 3 (f-recur (- n 3)))))))

(define (f-iter n)
        (define (calc a b c) (+ a (* 2 b) (* 3 c)))
        (define (func-iter l ll lll count) (cond ((= 0 count) lll)
                                                 ((= 1 count) ll)
                                                 ((= 2 count) l)
                                                 (else (func-iter (calc l ll lll) l ll (- count 1)))))
        (func-iter 2 1 0 n))