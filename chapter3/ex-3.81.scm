(define random-init 123)

(define (random input-stream)
  (define (random-stream input-stream old-rand)
    (let ((input (stream-car input-stream)))
      (let ((command (car input)))
        (let ((new-rand
          (cond
            ((eq? command 'generate) (rand-update old-rand))
            ((eq? command 'reset) (cadr input))
            (error "UNKNOWN COMMAND" command))))
          (cons-stream new-rand (random-stream (stream-cdr input-stream) new-rand))))))
  (random-stream input-stream random-init))
