(load "queue.scm")

(define (print-queue queue)
  (define (print-list l)
    (if (null? l)
        (newline)
        (begin
          (display (car l))
          (display " ")
          (print-list (cdr l)))))
  (print-list (front-ptr queue)))

(define q (make-queue))
(insert-queue! q 2)
(insert-queue! q 5)
(print-queue q)