(define (cuberoot num) 
    (define (cubert-iter guess) (if (good-enough? guess)
                                  guess
                                  (cubert-iter (improve-guess guess))))

    (define (improve-guess guess) (/ (+ (/ num (square guess)) (* guess 2)) 3))

    (define (good-enough? guess) (<= (percentage-change-in-guess guess (improve-guess guess)) 0.001))

    (define (percentage-change-in-guess guess next-guess) (abs (/ (- guess next-guess) guess)))

    (define (average a b) (/ (+ a b) 2.0))

    (define (square x) (* x x))

(cubert-iter 1.0))
