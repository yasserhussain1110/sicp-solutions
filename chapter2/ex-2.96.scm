
;; a

(define (pseudoremainder-terms a b)
  (cdr (div-terms
        (let ((i (integerizing-factor a b)))
          (map (lambda (each-term)
                 (make-term (order each-term)
                            (* i (coeff each-term))))
               a))
        b)))

(define (integerizing-factor a b)
  (let ((t1 (first-term a))
        (t2 (first-term b)))
    (let ((c (coeff t2)))
      (expt c (+ 1 (order t1) (order t2))))))

;; b

(define (gcd-terms a b)
  (define (gcd-terms-recur a b)
    (if (empty-termlist? b)
        a
        (gcd-terms-recur b (pseudoremainder-terms a b))))
  
  (remove-common-factors (gcd-terms-recur a b)))

(define (remove-common-factors a)
  (let ((common (apply gcd (map coeff a))))
    (map (lambda (each-term)
           (make-term (order each-term)
                      (/ (coeff each-term) common))))
    a))
