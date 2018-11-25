(load "agenda.scm")
(load "wire.scm")

; and 1
; or 2

(define the-agenda (make-agenda))

(define or-propogation-time 1)

(define and-propogation-time 2)

(define not-propogation-time 3)

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

(define (logical-not a)
  (cond ((= a 0) 1)
        ((= a 1) 0)
        (else (error "Invalid Signal" a))))

(define (inverter wire-in wire-out)
  (define (handler)
    (let ((new-value (logical-not (wire-in 'get-signal))))
      (add-to-agenda! (+ (time-agenda the-agenda) not-propogation-time)
                      (lambda () (wire-out 'set-signal new-value))
                      the-agenda)))
  (wire-in 'register-handler handler)
  'connected)

(define A (make-wire))
(define B (make-wire))
(define OUT (make-wire))
(A 'set-signal 1)
(or A B OUT)
(A 'get-signal)
(B 'get-signal)
(OUT 'get-signal)
(propogate-once)
(propogate-once)
(OUT 'get-signal)
