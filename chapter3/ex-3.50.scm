(define (stream-map proc . argstream)
  (if (null? (car argstream))
      '()
      (cons-stream
       (apply proc (map stream-car argstream))
       (apply stream-map (cons proc (map stream-cdr argstream))))))
