(load "ex-3.70.scm")

(define (square-weight x y) (+ (square x) (square y))) 

(define (square-weight-numbers s)
  (let ((p1 (stream-ref s 0))
        (p2 (stream-ref s 1))
        (p3 (stream-ref s 2)))
    (let ((w1 (square-weight (car p1) (cadr p1)))
          (w2 (square-weight (car p2) (cadr p2)))
          (w3 (square-weight (car p3) (cadr p3))))
      (if (and (= w1 w2) (= w2 w3))
          (cons-stream
            (list w1 p1 p2 p3)
            (square-weight-numbers (stream-cdr s)))
          (square-weight-numbers (stream-cdr s))))))

(define sq (square-weight-numbers (pairs integers integers square-weight)))
