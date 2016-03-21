(define (make-mobile left right)
  (list left right))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))


(define (make-branch length structure)
  (list length structure))


(define (length branch)
  (car branch))

(define (structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (let ((l (left-branch mobile)) (r (right-branch mobile)))
    (+
     (if (pair? (structure l)) (total-weight (structure l)) (structure l))
     (if (pair? (structure r)) (total-weight (structure r)) (structure r))
     )))

; branch can have either a weight or a sub-mobile.
(define (is-weight? branch)
  (let ((struct (structure branch)))
    (not (pair? struct))))

; this function is called only for branches having a weight (and not a sub-mobile).
(define (are-balanced? left-branch right-branch)
  (= (* (structure left-branch) (length left-branch)) (* (structure right-branch) (length right-branch))))

; this function is called only for branches having a weight (and not a sub-mobile).
(define (branch-weight branch)
  (structure branch))

(define (balanced-weight mobile)
  (let ((r (right-branch mobile)) (l (left-branch mobile)))
    (let ((right-branch-mobile-weight (if (is-weight? r) (structure r) (balanced-weight (structure r))))
	  (left-branch-mobile-weight (if (is-weight? l) (structure l) (balanced-weight (structure l)))))
      (if (or (null? right-branch-mobile-weight) (null? left-branch-mobile-weight))
	  '()
	  (if (= (* right-branch-mobile-weight (length r)) (* left-branch-mobile-weight (length l)))
	      (+ right-branch-mobile-weight left-branch-mobile-weight)
	      '())))))

(define (balanced? mobile)
  (not (null? (balanced-weight mobile))))
