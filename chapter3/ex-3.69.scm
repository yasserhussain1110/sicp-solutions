(load "pairs-stream.scm")

(define (triplets s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-map (lambda (x) (cons (stream-car s) x)) (stream-cdr (pairs t u)))
      (triplets (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define t (triplets integers integers integers))

(define pyth (stream-filter (lambda (t)
                              (let ((x (list-ref t 0))
                                    (y (list-ref t 1))
                                    (z (list-ref t 2)))
                                (= (square z) (+ (square x) (square y))))) t))
