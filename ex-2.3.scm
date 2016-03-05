(load "point.scm")
(load "ex-2.2.scm")

;; Makers, Selectors of rectangle
(define (make-rectangle length breadth)
  (cons length breadth))

(define (length-rectangle rectangle)
  (car rectangle))

(define (breadth-rectangle rectangle)
  (cdr rectangle))

;; If make-rectangle was defined this way:-
;; (define (make-rectangle breadth length)
;;   (cons breadth length))

;; (define (length-rectangle rectangle)
;;   (cdr rectangle))

;; (define (breadth-rectangle rectangle)
;;   (car rectangle))

;; That would not effect area-rect method below

;; Abstraction Barrier
;; Users of rectangle

(define (area-rect rectangle)
  (let ((length (segment-length (length-rectangle rectangle)))

	(breadth (segment-length (breadth-rectangle rectangle))))

    (* length breadth)))

(define (perimeter-rect rectangle)
  (let ((length (segment-length (length-rectangle rectangle)))

	(breadth (segment-length (breadth-rectangle rectangle))))

    (* 2 (+ length breadth))))
