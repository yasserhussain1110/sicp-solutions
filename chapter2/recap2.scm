(load "accumulate.scm")
;; map and filter are provided as library functions.


(define (fib pos)
  (define (iter-fib a b n)
    (if (= n pos)
	a
	(iter-fib b (+ a b) (+ n 1))))
  (iter-fib 0 1 0))


(define (enumerate-leaves t)
  (cond ((null? t) '())
	(else
	 (let ((first-part (car t))
	       (second-part (cdr t)))
	   (cond ((not (pair? first-part)) (cons first-part (enumerate-leaves second-part)))
		 (else (append (enumerate-leaves first-part) (enumerate-leaves second-part))))))))


(define (sum-odd-square tree)
  (accumulate + 0 (map square (filter odd? (enumerate-leaves tree)))))


(define (enumerate-interval start end)
  (if (> start end)
      '()
      (cons start (enumerate-interval (+ start 1)  end))))

(define (even-fibs n)
  (accumulate cons '() (filter even? (map fib (enumerate-interval 0 n)))))

(define (list-fib-squares n)
  (accumulate cons '() (map square (map fib (enumerate-interval 0 n)))))

(define (product-of-square-of-odd-elements sequence)
  (accumulate * 1 (map square (filter odd? sequence))))

(define (salary-of-highest-paid-programmer records)
  (accumulate max 0 (map salary (filter programmer? records))))
