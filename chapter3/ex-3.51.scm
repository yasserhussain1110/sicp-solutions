(define (stream-enumerate-interval start end)
  (if (> start end)
      '()
      (cons-stream start (stream-enumerate-interval (+ start 1) end))))

(define (display-line x)
  (display x)
  (newline))

(define (show x)
  (display-line x)
  x)

(define x (stream-map show (stream-enumerate-interval 0 100)))

(stream-ref x 5)

(stream-ref x 7)
