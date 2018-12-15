(load "agenda.scm")
(load "wire.scm")

; and 1
; or 2

(define the-agenda (make-agenda))

(define or-propogation-time 5)

(define and-propogation-time 3)

(define not-propogation-time 2)

(define (make-two-in-one-out-gate delay logical-function)
  (lambda (wire1 wire2 wire-out)
    (define (handler)
      (let ((new-value (logical-function (get-signal wire1) (get-signal wire2))))
        (add-to-agenda!
         (+ delay (time-agenda the-agenda))
         (lambda () (set-signal! wire-out new-value))
         the-agenda)))
    (register-handler! wire1 handler)
    (register-handler! wire2 handler)
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
    (let ((new-value (logical-not (get-signal wire-in))))
      (add-to-agenda! (+ (time-agenda the-agenda) not-propogation-time)
                      (lambda () (set-signal! wire-out new-value))
                      the-agenda)))
  (register-handler! wire-in handler)
  'connected)

(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or a b d)
    (and a b c)
    (inverter c e)
    (and d e s)
    'ok))

; Time of propogation - and-delay + inverter-delay + and-delay = 2 * and-delay + inverter-delay
; (Assuming and-delay + inverter-delay > or-delay)
#|
(define A (make-wire))
(define B (make-wire))
(define OUT (make-wire))
(set-signal! A 1)
(or A B OUT)
(get-signal A)
(get-signal B)
(get-signal OUT)
(propogate-once)
(propogate-once)
(get-signal OUT)
|#