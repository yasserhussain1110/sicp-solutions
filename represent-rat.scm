(load "gcd.scm")
(define (make-rat n d) (let ((g (gcd n d))) (cons (/ n g) (/ d g))))

(define (make-rat-better n d)
  (define (make-simple-rat a b)
    (cond ((< b 0) (cons (- a) (- b)))
	  (else (cons a b))))

  (let ((g (gcd n d)))
    (make-simple-rat (/ n g) (/ d g))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))
