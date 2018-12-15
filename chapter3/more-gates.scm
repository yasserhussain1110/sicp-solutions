(load "basic-gates.scm")

;(define (logical-xor a b)
;  (cond ((and (= a 0) (= b 0)) 0)
;        ((and (= a 0) (= b 1)) 1)
;        ((and (= a 1) (= b 0)) 1)
;        ((and (= a 1) (= b 1)) 0)
;        (else (error "Invalid Signal" a b))))

;(define xor (make-two-in-one-out-gate or-propogation-time logical-xor))

(define (xor a b out)
  (let (
        (j (make-wire))
        (k (make-wire))
        (l (make-wire))
        (m (make-wire))
        )
    (inverter a j)
    (inverter b k)
    (and a k l)
    (and j b m)
    (or l m out)
    'done))

; inverter-delay + and-gate-dely + or-gate-delay

(define (half-adder a b s c)
  (xor a b s)
  (and a b c)
  'done)

(define (full-adder a b c sum carry)
  (let ((c1 (make-wire))
        (c2 (make-wire))
        (s1 (make-wire)))
    (half-adder a b s1 c1)
    (half-adder s1 c sum c2)
    (or c1 c2 carry)
    'done))

;; Full Adder Tests
#|
(define A (make-wire))
(define B (make-wire))
(define C (make-wire))
(define SUM (make-wire))
(define CARRY (make-wire))
(full-adder A B C SUM CARRY)
(A 'set-signal 1)
(B 'set-signal 1)
(C 'set-signal 1)
(propogate)
(SUM 'get-signal)
(CARRY 'get-signal)

(A 'set-signal 1)
(B 'set-signal 0)
(C 'set-signal 1)
(propogate)
(SUM 'get-signal)
(CARRY 'get-signal)

(A 'set-signal 1)
(B 'set-signal 1)
(C 'set-signal 0)
(propogate)
(SUM 'get-signal)
(CARRY 'get-signal)

(A 'set-signal 0)
(B 'set-signal 0)
(C 'set-signal 1)
(propogate)
(SUM 'get-signal)
(CARRY 'get-signal)

(A 'set-signal 0)
(B 'set-signal 0)
(C 'set-signal 0)
(propogate)
(SUM 'get-signal)
(CARRY 'get-signal)
|#
;; Test Over