(define (stream-limit s limit)
  (let ((first (stream-car s))
        (second (stream-car (stream-cdr s))))
    (if
      (< (abs (- first second)) limit)
      second
      (stream-limit (stream-cdr s) limit))))
