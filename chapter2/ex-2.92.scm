(define (convert-term-of-coeff-poly term to-var from-var from-order)
  (make-term
   (order term)
   (make-poly (list (make-term from-order (coeff term))) from-var)))


(define (convert-a-poly-to-another poly to-var)
  (let ((terms (term-list poly))
        (from-var (var poly)))
    (combine-same-order-polys
     (flatmap (lambda
                  (each-term)
                (let ((from-order (order each-term))
                      (poly-coeff (coeff each-term)))
                  (let ((to-var (var poly-coeff))
                        (poly-coeff-terms (term-list poly-coeff)))
                    (map (lambda (each-poly-term) (convert-term-of-coeff-poly each-poly-term to-var from-var
                                                                              from-order))
                         poly-coeff-terms))))
              term))))