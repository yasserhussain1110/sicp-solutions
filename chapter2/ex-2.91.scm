(load "math-op.scm")
(load "scheme-number-package.scm")
(load "poly.scm")


(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (let ((t1-dividend (first-term L1))
            (t1-divisor (first-term L2)))
        (let ((coeff-t1-dividend (coeff t1-dividend))
              (order-t1-dividend (order t1-dividend))
              (coeff-t1-divisor (coeff t1-divisor))
              (order-t1-divisor (order t1-divisor)))
          (if (< order-t1-dividend order-t1-divisor)
              (list (the-empty-termlist) L1)
              (let ((order-new (- order-t1-dividend order-t1-divisor))
                    (coeff-new (div coeff-t1-dividend coeff-t1-divisor)))
                (let ((quotient (make-term order-new coeff-new)))
                  (let ((remainder (sub-terms L1 (mul-quotient-to-all-terms quotient L2))))
                    (let ((rest-of-result (div-terms remainder L2)))
                      (list (cons quotient (car rest-of-result)) (cadr rest-of-result)))))))))))



(define (mul-quotient-to-all-terms quotient all-terms)
  (map (lambda (each-term) (make-term (+ (order quotient) (order each-term))
                                      (mul (coeff quotient) (coeff each-term))))
       all-terms))

