(load "ex-2.50.scm")
(define (below painter1 painter2)
    (let ((lower (transform-painter painter1
                                    (make-vector 0 0)
                                    (make-vector 1 0)
                                    (make-vector 0 0.5)))
          (upper (transform-painter painter2
                                    (make-vector 0 0.5)
                                    (make-vector 1 0.5)
                                    (make-vector 0 1))))
      (lambda (frame)
	(lower frame)
	(upper frame))))

(define (below painter1 painter2)
  (rotate180 (rotatecounter270
	      (beside (rotatecounter270 painter1)
		      (rotatecounter270 painter2)))))
