(define (count-pairs x)
  (define (count-pairs-aux x counted)
    (if (or
         (not (pair? x))
         (memq x counted))
        0
        (begin
          (append! counted (cons x '()))
          (+ 1
             (count-pairs-aux (car x) counted)
             (count-pairs-aux (cdr x) counted)))))
  (count-pairs-aux x (list '())))

(count-pairs '(a b c))

(define h1 '(b))
(define test2 (cons 'a (cons h1 h1)))
test2
(count-pairs test2)

(define h1 '(a))
(define h2 (cons h1 h1))
(define test3 (cons h2 h2))
test3
(count-pairs h1)
(count-pairs h2)
(count-pairs test3)


(define h1 '(a b c))
(set-cdr! (cddr h1) h1)
(count-pairs h1)
