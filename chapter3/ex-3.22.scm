
#||
;; make-queue

;; empty-queue?

;; front-queue

;; insert-queue!

;; delete-queue!
||#

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    
    (define (set-front-ptr! item)
      (set! front-ptr item))
    
    (define (set-rear-ptr! item)
      (set! rear-ptr item))
    
    (define (empty-queue?)
      (null? front-ptr))
    
    (define (front-queue)
      (if (empty-queue?)
          (error "Queue is empty" front-ptr)
          (car front-ptr)))
    
    (define (insert-queue! val)
      (let ((new-block (cons val '())))
        (if (empty-queue?)
            (begin (set-front-ptr! new-block)
                   (set-rear-ptr! new-block)
                   dispatch)
            (begin (set-cdr! rear-ptr new-block)
                   (set-rear-ptr! new-block)
                   dispatch))))
    
    (define (delete-queue!)
      (if (empty-queue?)
          (error "Queue is empty" front-ptr)
          (begin
            (set-front-ptr! (cdr front-ptr))
            dispatch)))
    
    (define (dispatch message)
      (cond ((eq? message 'empty-queue?) (empty-queue?))
            ((eq? message 'front-queue) (front-queue))
            ((eq? message 'insert-queue!) insert-queue!)
            ((eq? message 'delete-queue!) (delete-queue!))
            (else (error "Corresponding method for message not found"))))
      dispatch))

(define q (make-queue))
((q 'insert-queue!) 2)
((q 'insert-queue!) 5)
((q 'insert-queue!) 7)
(q 'front-queue)
(q 'delete-queue!)
(q 'front-queue)
(q 'delete-queue!)
(q 'front-queue)
(q 'delete-queue!)
(q 'front-queue)
(q 'delete-queue!)