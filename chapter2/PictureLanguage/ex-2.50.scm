(define (flip-horiz painter)
  (transform-painter painter
		     (make-vector 1 0)
		     (make-vector 0 0)
		     (make-vector 1 1)))

(define (rotate180 painter)
  (transform-painter painter
		     (make-vector 1 1)
		     (make-vector 0 1)
		     (make-vector 1 0)))

(define (rotatecounter270 painter)
  (transform-painter painter
		     (make-vector 0 1)
		     (make-vector 0 0)
		     (make-vector 1 1)))
		     
