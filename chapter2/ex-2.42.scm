(load "flatmap.scm")
(load "enumerate-interval.scm")

(define empty-board '())

(define (make-pos row col)
  (list row col))

(define (row pos)
  (car pos))

(define (col pos)
  (cadr pos))

(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list (make-pos new-row k))))

(define (do-queens-attack? p1 p2)
  (or
   (= (row p1) (row p2))
   (= (col p1) (col p2))
   (= (abs (- (row p1) (row p2))) (abs (- (col p1) (col p2))))))


(define (safe? k soln)
  (define (is-safe-iter? index rest-soln k-th-pos)
    (if (= k index)
	true
	(if (do-queens-attack? (car rest-soln) k-th-pos) false (is-safe-iter? (+ index 1) (cdr rest-soln) k-th-pos))))

  (is-safe-iter? 1 soln (get-k-th-element soln k)))

(define (get-k-th-element soln k)
  (if (= k 1)
      (car soln)
      (get-k-th-element (cdr soln) (- k 1))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
	(list empty-board)
	(filter
	 (lambda (positions) (safe? k positions))
	 (flatmap
	  (lambda (rest-of-queens)
	    (map (lambda (new-row)
		   (adjoin-position new-row k rest-of-queens))
		 (enumerate-interval 1 board-size)))
	  (queen-cols (- k 1))))))
  (queen-cols board-size))
