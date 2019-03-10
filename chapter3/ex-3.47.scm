(load "mutex.scm")

; a>

(define (make-semaphore-mut n)
  (let ((global-mutex (make-mutex))
        (clients 0))
    
    (define (semaphore m)
      (cond ((eq? m 'acquire)
             (global-mutex 'acquire)
             (if (< clients n)
                 (begin
                   (set! clients (+ clients 1))
                   (global-mutex 'release))
                 (begin
                   (global-mutex 'release)
                   (semaphore m))))
            ((eq? m 'release)
             (global-mutex 'acquire)
             (set! clients (- clients 1))
             (global-mutex 'release))))
    semaphore))


; b>

(define (make-semaphore-test-set n)
  (let ((cell (list false))
        (clients 0))
    
    (define (semaphore m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (semaphore m)
                 (if (< clients n)
                     (begin
                       (set! clients (+ clients 1))
                       (clear! cell))
                     (begin
                       (clear! cell)
                       (semaphore m)))))
            ((eq? m 'release)
             (if (test-and-set! cell)
                 (semaphore m)
                 (begin
                   (set! clients (- clients 1))
                   (clear! cell))))))
    semaphore))
