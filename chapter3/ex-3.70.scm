(load "stream-commons.scm")

(define (merge-weighted s1 s2 weight)
  (if (stream-null? s1)
      s2
      (let ((top-s1 (stream-car s1)) (top-s2 (stream-car s2)))
        (let ((w1 (weight (car top-s1) (cadr top-s1))) (w2 (weight (car top-s2) (cadr top-s2))))
          (if (<= w1 w2)
              (cons-stream top-s1 (merge-weighted (stream-cdr s1) s2 weight))
              (cons-stream top-s2 (merge-weighted s1 (stream-cdr s2) weight)))))))

(define (pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

(define (is-divisible? x y) (= 0 (remainder x y)))

; a.

(define a (pairs integers integers (lambda (x y) (+ x y))))

; b.

(define b (stream-filter
            (lambda (pair)
              (let ((x (car pair)) (y (cadr pair)))
                (not (or (is-divisible? x 2) (is-divisible? x 3) (is-divisible? x 5)
                  (is-divisible? y 2) (is-divisible? y 3) (is-divisible? y 5)))))
            (pairs integers integers (lambda (x y) (+ (* 2 x) (* 3 y) (* 5 x y))))))
