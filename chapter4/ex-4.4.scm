;a

(load "commons.scm")

(define (or? exp) (tagged-list 'or exp))

(define (or-exps exp) (cdr exp))

(define (make-or-exp exps) (cons 'or exps))

(define (eval-or exp env)
  (if
    (null? (or-exps exp))
    'false
    (if
      (eval (car (or-exps exp)) exp)
      'true
      (eval-or (make-or-exp (cdr (or-exps exp))) env))))

(define (and? exp) (tagged-list 'and exp))

(define (and-exps exp) (cdr exp))

(define (make-and-exp exps) (cons 'and exps))

(define (eval-and exp env)
  (if
    (null? (and-exps exp))
    'true
    (if
      (eval (car (and-exps exp)) exp)
      (eval-and (make-and-exp (cdr (and-exps exp))) env)
      'true)))

;b

(define (or->if exp)
  (expand-or-exps (or-exps exp)))
      

(define (expand-or-exps exps)
  (if (null? exps) 'false (make-if (car exps) 'true (expand-or-exps (cdr exps)))))

(define (and->if exp)
  (expand-and-exps (and-exps exp)))

(define (expand-and-exps exps)
  (if (null? exps) 'true (make-if (car exps) (expand-and-exps (cdr exps)) 'false)))
