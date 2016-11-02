(define (make-monitored f)
  (let ((counter 0))
    (lambda (arg)
      (cond ((eq? arg 'reset-count) (set! counter 0))
            ((eq? arg 'how-many-calls?) counter)
            (else (set! counter (+ counter 1)) (f arg))))))



;; Test

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
(s 'reset-count)
(s 30)
(s 25)
(s 'how-many-calls?)