
(define (predicate-test P x1 x2 y1 y2)
  (lambda ()
    (let ((rand-x (random-in-range x2 x1))
          (rand-y (random-in-range y2 y1)))
      (P rand-x rand-y))))

(define (square-area x1 x2 y1 y2)
  (* (- x2 x1) (- y2 y1)))

(define (estimate-integral P x1 x2 y1 y2)
  (* (square-area x1 x2 y1 y2) (monte-carlo 1000000 (predicate-test P x1 x2 y1 y2))))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random (/ range 1.0)))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (* 1.0 (/ trials-passed trials)))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))


;; Testing


(define P (lambda (x y) (<= (+ (square (- x 5)) (square (- y 7))) (square 3))))

(estimate-integral P 8 2 10 4)

;; For getting value of pi

(define (average x y) (/ (+ x y) 2))

(define rect-x1 2)
(define rect-x2 0)

(define rect-y1 2)
(define rect-y2 0)

(define center-x (average rect-x1 rect-x2))
(define center-y (average rect-y1 rect-y2))
(define radius (/ (- rect-x1 rect-x2) 2))

(define P (lambda (x y) (<= (+ (square (- x center-x)) (square (- y center-y))) (square radius))))
(estimate-integral P rect-x1 rect-x2 rect-y1 rect-y2)
