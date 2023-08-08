(load "flatmap.scm")
(define (permutations set)
  (if (null? set)
      (list '())
      (flatmap (lambda (x)
		 (let ((x-removed (remove x set)))
		   (map (lambda (y)
			  (cons x y)) (permutations x-removed))))
	       set)))

(define (remove element set)
  (filter (lambda (x) (not (= element x))) set))