; a> Special forms will be treated as procedure applications and will break the code

; b> 

(load "commons.scm")

(define (application? exp) (tagged-list? exp 'call))

(define (operator exp) (cadr exp))

(define (operands exp) (cddr exp))
