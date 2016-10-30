(load "ex-2.96.scm")
(load "ex-2.91.scm")
(load "mod-op-type-table.scm")


;; a

(define (remove-common-factors n d)
  (let ((g (apply
            gcd
            (append
             (map coeff n)
             (map coeff d)))))
    
    (list (divide-all-terms n g) (divide-all-terms d g))))

(define (divide-all-terms factor terms)
  (map (lambda (each-term)
         (make-term (order each-term)
                    (/ factor (coeff each-term))))
       terms))

(define (multiply-all-terms factor terms)
  (map (lambda (each-term)
         (make-term (order each-term)
                    (* factor (coeff each-term))))
       terms))


(define (integerizing-factor g n d)
  (let ((max-order (apply
                    max
                    (append
                    (map order n)
                    (map order d)))))
    (expt (coeff g) (+ 1 (- max-order (order g))))))

(define (reduce-terms n d)
  (let (g ((gcd-terms n d)))
    (let ((i (integerizing-factor g n d)))
      (let ((mul-n (multiply-all-terms i n))
            (mul-d (multiply-all-terms i d)))
        (let ((red-n (div-terms mul-n g))
              (red-d (div-terms mul-d g)))
          (remove-common-factors red-n red-d))))))


(define (reduce-poly n d)
  (if (not (same-variable? (variable n) (variable d)))
      (error "Variable are not same" (list n d))
      (let ((reduced (reduce-terms (term-list n) (term-list d))))
        (list
         (make-polynomial (variable n) (car reduced))
         (make-polynomial (variable n) (cadr reduced))))))




;; b

(define (reduce-integers n d)
  (let ((g (gcd n d)))
    (list (/ n g) (/ d g))))


(put 'reduce '(polynomial polynomial) reduce-poly)
(put 'reduce '(scheme-number scheme-number) reduce-integers)

(define (reduce a b) (apply-generic 'reduce a b))

(define (make-rat x y) (let ((r (reduce x y)))
                         (cons (car r) (cadr r))))


