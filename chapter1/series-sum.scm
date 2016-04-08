(define (sum a b term next)
        (if (< b a) 0 (+ (term a) (sum (next a) b term next))))
