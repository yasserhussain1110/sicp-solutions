(define (sqroot x) 
    (define (sqrt-iter num guess) (if (good-enough? num guess)
                                       guess
                                       (sqrt-iter num (improve-guess num guess))))

    (define (improve-guess num guess) (average (/ num guess) guess))

    (define (good-enough? num guess) (<= (percentage-change-in-guess guess (improve-guess num guess)) 0.001))

    (define (percentage-change-in-guess guess next-guess) (abs (/ (- guess next-guess) guess)))

    (define (average a b) (/ (+ a b) 2.0))

(sqrt-iter x 1.0))

