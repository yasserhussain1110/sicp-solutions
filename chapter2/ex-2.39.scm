(load "ex-2.38.scm")
(define (l-reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) '() sequence))

(define (r-reverse sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))
