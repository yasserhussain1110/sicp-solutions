(define f (let ((assigned 0) (var 0))
            (lambda (x)
              (if (= assigned 0)
                  (begin (set! assigned 1)
                         (set! var x)
                         (/ var 2))
                  (/ var 2)))))

(define f (let ((called #f) (var 0))
            (lambda (x)
              (if (not called)
                  (begin (set! called #t)
                         (set! var x)
                         0)
                  var))))

(define f (let ((called #f))
            (lambda (x)
              (if called
                  0
                  (begin (set! called #t)
                         x)))))