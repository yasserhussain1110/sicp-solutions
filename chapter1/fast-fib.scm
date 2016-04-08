(define (fib n)
        (define (a-transform a b p q) (+ (* b q) (* a q) (* a p)))
        (define (b-transform a b p q) (+ (* b p) (* a q)))
        (define (is-even? n) (= 0 (remainder n 2)))
        (define (double-p p q) (+ (* p p) (* q q)))
        (define (double-q p q) (+ (* q q) (* 2 p q)))

        (define (fast-fib-iter b a p q n) (cond ((= n 0) b)
                                                ((is-even? n) (fast-fib b a (double-p p q) (double-q p q) (/ n 2)))
                                                (else (fast-fib-iter (b-transform a b p q) (a-transform a b p q) p q (- n 1)))))

        (fast-fib-iter 0 1 0 1 n))
