(define (make-mutex)
    (let ((cell (list false)))
        (define (the-mutex m)
            (cond ((eq? m 'acquire)
                    (if (test-and-set! cell)
                        (the-mutex m)))
                  ((eq? m 'release)
                   (clear! cell))))
      the-mutex))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

(define (clear! cell)
  (set-car! cell false))
