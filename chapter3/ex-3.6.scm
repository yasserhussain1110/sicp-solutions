(define rand
  (let ((x 123))
    (lambda (command)
      (cond ((eq? command 'update)
             (lambda (new-val)
               (set! x new-val)))
            ((eq? command 'generate)
             (set! x (rand-update x))
             x)))))