(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


(count-pairs '(a b c))



(define h1 '(b))
(define test2 (cons 'a (cons h1 h1)))
test2
(count-pairs test2)


(define h1 '(a))
(define h2 (cons h1 h1))
(define test3 (cons h2 h2))
test3
(count-pairs test3)


(define h1 '(a b c))
(set-cdr! (cddr h1) h1)
(count-pairs h1)