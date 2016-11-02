

(define (make-account balance secret-password)
  (lambda (password command)
    (if (eq? password secret-password)
        (cond ((eq? command 'withdraw)
               (lambda (amount)
                 (if (> amount balance)
                     "Insufficient Funds"
                     (begin (set! balance (- balance amount))
                            balance))))
              ((eq? command 'deposit)
               (lambda (amount)
                 (set! balance (+ balance amount))
                 balance))
              (else "Command Not Recognized"))
        
        (lambda (x) "Incorrect Password"))))


;; Test

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)
((acc 'secret-password 'withdraw) 80)
(acc 'secret-password 'withdaasdraw)