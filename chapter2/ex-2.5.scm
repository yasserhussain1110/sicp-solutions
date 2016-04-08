(define (new-cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (get-index a b)
  (define (divide-by-high-powers i)
    (if (= (remainder a (expt b i)) 0) (divide-by-high-powers (+ i 1)) (- i 1)))
  (divide-by-high-powers 0))

(define (new-car x)
  (get-index x 2))

(define (new-cdr x)
  (get-index x 3))
