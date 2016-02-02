(load "timed-prime.scm")
(define (next-odd n) (cond 
                            ((< n 2) 3)
                            ((= 0 (remainder n 2)) (+ n 1))
                            (else n)
                           
                      )
)
(define (prime-in-range n1 n2) (prime-in-range-repeat n1 n2 (next-odd n1)))
(define (prime-in-range-repeat n1 n2 c) (if (and (>= c n1) (<= c n2)) (test-prime-and-call-next n1 n2 c)))
(define (test-prime-and-call-next n1 n2 c)
        (timed-prime-test c)
        (prime-in-range-repeat n1 n2 (+ c 2)))
