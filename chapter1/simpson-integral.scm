(load "series-sum.scm")
(define (simpson-integral f a b n)
        (define h (/ (- b a) n))
        (define (add-h x) (+ x h))
        (define (add-double-h x) (+ x h h))
        (define raw-sum (+
        (f a)
        (* 2 (sum (+ a h) (- b h) f add-h))
        (* 2 (sum (+ a h) (- b h) f add-double-h))
        (f b)
        ))
        (/ (* h raw-sum) 3.0))
