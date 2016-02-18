(define (cont-frac-i n d k)
  (define (compute-kth-part k-part next-k-part)
    (/ (n k-part) (+ (d k-part) next-k-part)))
  (define (calculate-frac k next-val)
    (if (= k 0) next-val (calculate-frac (- k 1) (compute-kth-part k next-val))))
  (calculate-frac k 0))

(define (cont-frac-r n d k)
  (define (compute-ith-term i)
    (if (> i k) 0
	(/ (n i) (+ (d i) (compute-ith-term (+ i 1))))))
  (compute-ith-term 1))
  
