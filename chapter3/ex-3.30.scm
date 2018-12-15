(load "basic-gates.scm")
(load "common.scm")

(define (full-adder a b c sum carry)
  (let ((c1 (make-wire))
        (c2 (make-wire))
        (s1 (make-wire)))
    (half-adder a b s1 c1)
    (half-adder s1 c sum c2)
    (or c1 c2 carry)
    'done))

; Time of propogation - 2 * half-adder-delay + or-delay = 4 * and-delay + 2 * inverter-delay + or-delay

;; Created pre-requisites

(define (identity-circuit a b)
  (define (handler)
    (let ((new-value (get-signal a)))
      (add-to-agenda! (+ 0 (time-agenda the-agenda))
                      (lambda () (set-signal! b new-value))
                      the-agenda)))

  (register-handler! a handler)
  'connected)

(define (n-full-adder a b c-in s c-out)
  (define (make-full-adder c triplet)
    (let ((a-n (car triplet))
          (b-n (cadr triplet))
          (s-n (caddr triplet))
          (c-n (make-wire)))
      (full-adder a-n b-n c s-n c-n)
      c-n))

  (identity-circuit (reduce make-full-adder c-in (zip a b s))
            c-out))

(define a-n (list (make-wire) (make-wire)))
(define b-n (list (make-wire) (make-wire)))
(define s-n (list (make-wire) (make-wire)))
(define c-in (make-wire))
(define c-out (make-wire))
(n-full-adder a-n b-n c-in s-n c-out)
(map (lambda (x) (set-signal! x 1)) a-n)
(map (lambda (x) (set-signal! x 1)) b-n)
(set-signal! c-in 1)
(propogate)
(map (lambda (x) (get-signal x)) s-n)
(get-signal c-out)

; delay - n * full-adder-delay = n * (4 * and-delay + 2 * inverter-delay + or-delay)
