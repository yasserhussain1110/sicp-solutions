(load "point.scm")

;; Makers , Getters of Segment
(define (make-segment point1 point2)
  (cons point1 point2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

;; Abstraction Barrier
;; Users of segment

(define (segment-length segment)
  (let ((x-distance (-
		     (x-point (start-segment segment))
		     (x-point (end-segment segment))))

	(y-distance (-
		     (y-point (start-segment segment))
		     (y-point (end-segment segment)))))

    (sqrt (+ (square x-distance) (square y-distance)))))
