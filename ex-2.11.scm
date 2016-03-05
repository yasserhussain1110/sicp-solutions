(load "ex-2.7.scm")

(define (mul-interval x y)
  (let ((a (lower-bound x))
	(b (upper-bound x))
	(c (lower-bound y))
	(d (upper-bound y)))
    (cond 
     ; Cond 1
     ((and (positive? a) (positive? b) (positive? c) (positive? d))  (make-interval (* a c) (* b d)))
     ; Cond 2
     ((and (negative? a) (negative? b) (positive? c) (positive? d))  (make-interval (* a d) (* b c)))
     ; Cond 3
     ((and (negative? a) (positive? b) (positive? c) (positive? d))  (make-interval (* a d) (* b d)))
     ; Cond 4
     ((and (positive? a) (positive? b) (negative? c) (negative? d))  (make-interval (* b c) (* a d)))
     ; Cond 5
     ((and (negative? a) (negative? b) (negative? c) (negative? d))  (make-interval (* b d) (* a c)))
     ; Cond 6
     ((and (negative? a) (positive? b) (negative? c) (negative? d))  (make-interval (* b c) (* a c)))
     ; Cond 7
     ((and (positive? a) (positive? b) (negative? c) (positive? d))  (make-interval (* b c) (* b d)))
     ; Cond 8
     ((and (negative? a) (negative? b) (negative? c) (positive? d))  (make-interval (* a d) (* a c)))
     ; Cond 9
     ((and (negative? a) (positive? b) (negative? c) (positive? d))  (let ((p1 (* a d)) (p2 (* b c))
									   (p3 (* a c)) (p4 (* b d)))
								       (make-interval (min p1 p2)
										      (max p3 p4)))))))
