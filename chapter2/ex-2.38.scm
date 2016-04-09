(load "accumulate.scm")

(define fold-right accumulate)

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
	result
	(iter (op result (car rest))
	      (cdr rest))))
  (iter initial sequence))

;;
;; 1. 3/2
;; 2. 1/6
;; 3. (1 (2 (3 ())))
;; 4. (((() 1) 2) 3)
;; 5. associative and commutative
