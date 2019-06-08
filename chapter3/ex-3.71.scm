(load "ex-3.70.scm")

(define (cube x) (* x x x))

(define (r-weight x y) (+ (cube x) (cube y))) 

(define (ramanjun-numbers s)
  (let ((p1 (stream-ref s 0))
        (p2 (stream-ref s 1)))
    (let ((w1 (r-weight (car p1) (cadr p1)))
          (w2 (r-weight (car p2) (cadr p2))))
      (if (= w1 w2)
          (cons-stream
            (list w1 p1 p2)
            (ramanjun-numbers (stream-cdr s)))
          (ramanjun-numbers (stream-cdr s))))))

(define r (ramanjun-numbers (pairs integers integers r-weight)))
