(define (smooth stream)
  (let ((first (stream-car stream)) (second (stream-car (stream-car stream))))
    (cons-stream (/ (+ first second) 2) (smooth (stream-cdr stream)))))

(define (zero-crossing-detector sense-data)
  (let ((smoothed-data (smooth sense-data)))
    (stream-map sign-change-detector smoothed-data (cons-stream 0 smoothed-data))))
