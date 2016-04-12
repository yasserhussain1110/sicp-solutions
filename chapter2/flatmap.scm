(load "accumulate.scm")
(define (flatmap f seq)
  (accumulate append '() (map f seq)))
