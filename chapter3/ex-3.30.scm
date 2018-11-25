(load "basic-gates.scm")

(define (logical-xor a b)
  (cond ((and (= a 0) (= b 0)) 0)
        ((and (= a 0) (= b 1)) 1)
        ((and (= a 1) (= b 0)) 1)
        ((and (= a 1) (= b 1)) 0)
        (else (error "Invalid Signal" a b))))

(define xor (make-two-in-one-out-gate or-propogation-time logical-xor))