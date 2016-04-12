(load "flatmap.scm")
(load "enumerate-interval")
(load "../chapter1/prime")
(define (unique-pairs n)
(flatmap (lambda (x)
	   (map (lambda (y)
		  (list y x)) (enumerate-interval 1 (- x 1)))) (enumerate-interval 1 n)))


(define (prime-sum-pairs n)
  (filter (lambda (x) (prime? (+ (car x) (cadr x)))) (unique-pairs n)))
