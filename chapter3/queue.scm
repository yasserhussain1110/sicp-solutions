
#||
;; make-queue

;; empty-queue?

;; front-queue

;; insert-queue!

;; delete-queue!
||#

(define (make-queue)
  (cons '() '()))

(define (front-ptr queue)
  (car queue))

(define (rear-ptr queue)
  (cdr queue))

(define (set-front-ptr! queue item)
  (set-car! queue item))

(define (set-rear-ptr! queue item)
  (set-cdr! queue item))

(define (empty-queue? queue)
  (null? (front-ptr queue)))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "Queue is empty" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue val)
  (let ((new-block (cons val '())))
    (if (empty-queue? queue)
        (begin (set-front-ptr! queue new-block)
               (set-rear-ptr! queue new-block)
               queue)
        (begin (set-cdr! (rear-ptr queue) new-block)
               (set-rear-ptr! queue new-block)
               queue))))

(define (delete-queue! queue)
  (if (empty-queue? queue)
      (error "Queue is empty" queue)
      (begin
        (set-front-ptr! queue (cdr (front-ptr queue)))
        queue)))