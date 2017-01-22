(define (make-node prev val next)
  (list prev val next))

(define (prev node)
  (car node))

(define (set-prev! node new-prev)
  (set-car! node new-prev))

(define (next node)
  (caddr node))

(define (set-next! node new-next)
  (set-car! (cddr node) new-next))

(define (val node)
  (cadr node))

(define (set-val! node new-val)
  (set-car! (cdr node) new-val))

(define (make-deque)
  (cons '() '()))

(define (empty-deque? q)
  (or (null? (car q)) (null? (cdr q))))

(define (front-deque q)
  (if (empty-deque? q)
      (error "Deque Empty" q)
      (val (car q))))

(define (rear-deque q)
  (if (empty-deque? q)
      (error "Deque Empty" q)
      (val (cdr q))))

(define (front-insert-deque! q new-val)
  (let ((new-node (make-node '() new-val '()))
        (old-first-node (car q)))
    (if (empty-deque? q)
        (begin (set-car! q new-node)
               (set-cdr! q new-node)
               q)
        (begin (set-prev! old-first-node new-node)
               (set-next! new-node old-first-node)
               (set-car! q new-node)
               q))))

(define (rear-insert-deque! q new-val)
  (let ((new-node (make-node '() new-val '()))
        (old-last-node (cdr q)))
    (if (empty-deque? q)
        (begin (set-car! q new-node)
               (set-cdr! q new-node)
               q)
        (begin (set-next! old-last-node new-node)
               (set-prev! new-node old-last-node)
               (set-cdr! q new-node)
               q))))

(define (front-delete-deque! q)
  (if (empty-deque? q)
      (error "Deque Empty" q)
      (let ((first-node (car q))
            (second-node (next (car q))))
        (if (null? second-node)
            (begin
              (set-car! q '())
              q)
            (begin
              (set-prev! second-node '())
              (set-car! q second-node)
              q)))))

(define (rear-delete-deque! q)
  (if (empty-deque? q)
      (error "Deque Empty" q)
      (let ((last-node (cdr q))
            (second-last-node (prev (cdr q))))
        (if (null? second-last-node)
            (begin
              (set-cdr! q '())
              q)
            (begin
              (set-next! second-last-node '())
              (set-cdr! q second-last-node)
              q)))))

(define q (make-deque))
q
(front-insert-deque! q 5)
(front-insert-deque! q 7)
(front-insert-deque! q 9)
(front-insert-deque! q 12)
(rear-insert-deque! q 100)
(rear-insert-deque! q 200)

(val (car q))
(val (cdr q))
(front-delete-deque! q)
(val (car q))
(val (cdr q))

(rear-delete-deque! q)
(val (car q))
(val (cdr q))

(front-delete-deque! q)
(val (car q))
(val (cdr q))
