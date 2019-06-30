(define (lower a b) (if (< a b) a b))

(define (higher a b) (if (> a b) a b))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2)
  (define (create-stream successful-trials total-trials total-area)
    (let ((new-x (random-in-range (lower x1 x2) (higher x1 x2))) (new-y (random-in-range (lower y1 y2) (higher y1 y2))))
      (let
        ((new-successful-trials (+ successful-trials (if (P new-x new-y) 1 0)))
         (new-total-trials (+ total-trials 1)))
        (cons-stream
          (* total-area (/ new-successful-trials new-total-trials))
          (create-stream new-successful-trials new-total-trials total-area)))))
  (create-stream 0.0 0 (abs (* (- x1 x2) (- y1 y2)))))

