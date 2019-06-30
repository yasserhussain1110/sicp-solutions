(define (integers-from n)
  (cons-stream n (integers-from (+ n 1))))

(define integers (integers-from 1))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream s f)
  (stream-map (lambda (x) (* f x)) s))

(define (take s n)
  (cons (stream-car s) (take (stream-cdr s) (- n 1))))

(define (partial-sums s)
  (define p (cons-stream (stream-car s) (add-streams (stream-cdr s) p)))
  p)

(define (display-stream s n)
  (if
    (eq? n 0)
		(begin
      (display "...")
      (newline))
    (begin
      (display (stream-car s))
	    (newline)
	    (display-stream (stream-cdr s) (- n 1)))))

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
      (let ((integrand (force delayed-integrand)))
        (add-streams (scale-stream integrand dt) int))))
  int)
