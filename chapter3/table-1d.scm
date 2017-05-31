#lang sicp

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))

(define (assoc key records)
  (if (null? records)
      #f
      (let ((record (car records)))
        (if (equal? (car record) key)
            record
            (assoc key (cdr records))))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (let ((new-record (cons (cons key value) '())))
            (set-cdr! new-record (cdr table))
            (set-cdr! table new-record)))))
                 
#|
(define table (cons '*table* (cons
                              (cons 'a 1)
                              (cons
                               (cons 'b 2)
                               (cons
                                (cons 'c 3)
                                '())))))
|#

(define table (list '*table* (cons 'a 1) (cons 'b 2) (cons 'c 3)))


(assoc 'd (cdr table))
(lookup 'a table)
(insert! 'z 9 table)
table