(load "stream-commons.scm")

(define ln-2-summands
  (cons-stream
    1.0
    (stream-map
      (lambda (x)
        (let ((n (/ 1 x)))
          (- (if (> n 0) (/ 1 (+ n 1)) (/ 1 (- n 1))))))
      ln-2-stream)))

(define (ln-2-summands-f start)
  (cons-stream
    (/ 1.0 start)
    (stream-map - (ln-2-summands-f (+ start 1)))))

(define ln-2-summands (ln-2-summands-f 1))

(define ln-2-stream (partial-sums ln-2-summands))

(display-stream ln-2-stream 8)

(newline)
(newline)

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                  (euler-transform (stream-cdr s)))))

(define ln-2-stream-acl (euler-transform ln-2-stream))

(display-stream ln-2-stream-acl 8)

(newline)
(newline)

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define ln-2-stream-super-acl (stream-map stream-car (make-tableau euler-transform ln-2-stream)))

(display-stream ln-2-stream-super-acl 8)
