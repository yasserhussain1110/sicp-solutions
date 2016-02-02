(define (get-element a b) (cond ((or (< a 1) (< b 1) (> b a)) -1)
                                ((or (= b 1) (= b a)) 1)
                                (else (+ (get-element (- a 1) (- b 1)) (get-element (- a 1) b)))))
