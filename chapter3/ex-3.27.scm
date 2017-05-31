
(load "ex-3.26.scm")

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previous-value (lookup-single x table)))
        (or previous-value
            (let ((new-val (f x)))
              (insert-single! x new-val table)
              new-val))))))


;; Because the memoized fib calculates a fibonacci value for a number only once.
;; No. It wont.
