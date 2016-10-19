;; This is the op type table used for data directed programming.
;; Peeked ahead a little bit and found `set!`, which helped create this.



(define table '())

(define (put op type item)
  (set! table (cons (list op type item) table))
  'added)

(define (get op type)
  (define (find-in-table table op type)
    (cond
      ((null? table)
       false)
      (else
       (let ((an-entry (car table)))
         (if
          (and (eq? op (car an-entry)) (type-eq? type (cadr an-entry)))
          (caddr an-entry)
          (find-in-table (cdr table) op type))))))
  (find-in-table table op type))


(define (type-eq? op1 op2)
  (cond ((and (not (pair? op1)) (not (pair? op2)))
         (eq? op1 op2))
        ((and (pair? op1) (pair? op2))
         (lists-equal? op1 op2))
        (else false)))


(define (lists-equal? list1 list2)
  (cond ((and (null? list1) (null? list2)) true)
        ((and (not (null? list1)) (not (null? list2)))
         (if (eq? (car list1) (car list2))
             (lists-equal? (cdr list1) (cdr list2))
             false))
        (else false)))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

