
(define (sum-odd-square tree)
  (cond ((null? tree) 0)
	((pair? tree) (+ (sum-odd-square (car tree)) (sum-odd-square (cdr tree))))
	(else (if (odd? tree) (square tree) 0))))

(define (fib pos)
  (define (iter-fib a b n)
    (if (= n pos)
	a
	(iter-fib b (+ a b) (+ n 1))))
  (iter-fib 0 1 0))


(define (even-fibs n)
  (define (recur-even-fibs pos)
    (if (> pos n)
	'()
	(let ((fib-val (fib pos)))
	  (if (even? fib-val)
	      (cons fib-val (recur-even-fibs (+ pos 1)))
	      (recur-even-fibs (+ pos 1))))))
  (recur-even-fibs 0))


