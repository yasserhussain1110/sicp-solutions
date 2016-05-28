(load "sets-unordered.scm")

(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else
	 (let ((elem1 (car set1)))
	   (if (element-of-set? elem1 set2)
	       (union-set (cdr set1) set2)
	       (cons elem1 (union-set (cdr set1) set2)))))))
