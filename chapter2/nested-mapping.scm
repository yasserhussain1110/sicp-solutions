(load "enumerate-interval.scm")
(load "accumulate.scm")
(load "../chapter1/prime.scm")

(define n 6)

(define t1 (accumulate append '() 
		       (map (lambda (x)
			      (map (lambda (y) (list x y)) (enumerate-interval 1 (- x 1))))
			    (enumerate-interval 1 n))))


(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define t2 (flatmap (lambda (x)
		      (map (lambda (y) (list x y)) (enumerate-interval 1 (- x 1))))
		    (enumerate-interval 1 n)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? 
	       (flatmap (lambda (x)
			  (map (lambda (y) (list x y)) (enumerate-interval 1 (- x 1))))
			(enumerate-interval 1 n)))))


