(load "agenda.scm")
(load "wire.scm")

; and 1
; or 2

(define the-agenda (make-agenda))

(define or-propogation-time 1)

(define and-propogation-time 2)

(define (make-two-in-one-out-gate delay logical-function)
  (lambda (wire1 wire2 wire-out)
    (define (handler)
      (let ((new-value (logical-function (wire1 'get-signal) (wire2 'get-signal))))
        (add-to-agenda!
         (+ delay (time-agenda the-agenda))
         (lambda () (wire-out 'set-signal new-value))
         the-agenda)))
    (wire1 'register-handler handler)
    (wire2 'register-handler handler)
    'connected))

(define (logical-or a b)
  (cond ((and (= a 0) (= b 0)) 0)
        ((and (= a 0) (= b 1)) 1)
        ((and (= a 1) (= b 0)) 1)
        ((and (= a 1) (= b 1)) 1)
        (else (error "Invalid Signal" a b))))

(define (logical-and a b)
  (cond ((and (= a 0) (= b 0)) 0)
        ((and (= a 0) (= b 1)) 0)
        ((and (= a 1) (= b 0)) 0)
        ((and (= a 1) (= b 1)) 1)
        (else (error "Invalid Signal" a b))))

(define or (make-two-in-one-out-gate or-propogation-time logical-or))
(define and (make-two-in-one-out-gate and-propogation-time logical-and))

(define A (make-wire))
(define B (make-wire))
(define OUT (make-wire))
(A 'set-signal 1)
(or A B OUT)
(A 'get-signal)
(B 'get-signal)
(OUT 'get-signal)
(propogate the-agenda)
(propogate the-agenda)
(OUT 'get-signal)
