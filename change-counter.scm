(define (cc amt no-of-kind-of-coins) (cond ((= amt 0) 1)
                                     ((or (< amt 0) (= no-of-kind-of-coins 0)) 0)
                                     (else (+ (cc amt (- no-of-kind-of-coins 1)) (cc (- amt (first-denomination no-of-kind-of-coins)) no-of-kind-of-coins)))))

(define (first-denomination no-of-kind-of-coins) (cond ((= no-of-kind-of-coins 5) 50)
                                                 ((= no-of-kind-of-coins 4) 25)
                                                 ((= no-of-kind-of-coins 3) 10)
                                                 ((= no-of-kind-of-coins 2) 5)
                                                 ((= no-of-kind-of-coins 1) 1)))

(define (count-change amt) (cc amt 5))
