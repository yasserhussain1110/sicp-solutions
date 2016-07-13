(load "flatmap")
(load "enumerate-interval")

(define (make-pos row col)
  (list row col))

(define (row pos)
  (car pos))

(define (col pos)
  (cadr pos))

(define (adjoin-position sol pos)
  (append (list pos) sol))


(define (generate-all-points col board-size)
  (map (lambda (x)
	 (make-pos x col))
       (enumerate-interval 0 (- board-size 1))))

(define (queens-pos-attack p1 p2)
  (or
   (= (row p1) (row p2))
   (= (col p1) (col p2))
   (= (abs (- (row p1) (row p2))) (abs (- (col p1) (col p2))))))

(define (safe? soln)
  (define (safe-iter? k-queen-pos rest-queens)
    (if (null? rest-queens)
	true
	(let ((k-prev-queen-pos (car rest-queens)))
	  (if (queens-pos-attack k-queen-pos k-prev-queen-pos) false (safe-iter? k-queen-pos (cdr rest-queens))))))
  (safe-iter? (car soln) (cdr soln)))

(define (queens n)
  (define (queen-iter sol col)
    (if (= n col)
	sol
	(queen-iter
	 (filter safe?
		 (extend-soln sol n col))
	 (+ col 1))))
  (queen-iter (list '()) 0))

(define (extend-soln sol board-size col)
  (flatmap (lambda (each_sol)
	     (map (lambda (each_point)
		    (adjoin-position each_sol each_point))
		  (generate-all-points col board-size)))
	   sol))
