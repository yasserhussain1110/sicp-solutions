(define (sqroot num)

    (define (sqrt-iter guess) (if (good-enough? guess)
                                    guess
                                    (sqrt-iter (improve-guess guess))))
    (define (square x) (* x x))

    (define (improve-guess guess) (average (/ num guess) guess))

    (define (good-enough? guess) (<= (abs (- num (square guess))) 0.001))

    (define (average a b) (/ (+ a b) 2.0))

(sqrt-iter 1.0))

