(load "wire.scm")
(load "agenda.scm")
(load "basic-gates.scm")

;; Modify "wire.scm"

(define (make-wire)
  (let ((signal 0) (event-handlers '()))
    (define (set-signal! new-signal)
      (if (not (= new-signal signal))
          (begin (set! signal new-signal)
                 (map (lambda (f) (f)) event-handlers)
                 'updated)))
    (define (get-signal) signal)

    (define (register-handler! handler)
        (set! event-handlers (append event-handlers (list handler)))
        (handler)
        'registered)

    (define (wire command . args)
      (cond ((eq? command 'set-signal!) (apply set-signal! args))
            ((eq? command 'get-signal) (apply get-signal args))
            ((eq? command 'register-handler!) (apply register-handler! args))
            (else (error "Error: UNKNOWN COMMAND"))))
    wire))

(define (probe name wire)
  (register-handler! wire
               (lambda ()
                 (newline)
                 (display name)
                 (display " ")
                 (display (time-agenda the-agenda))
                 (display " New-value = ")
                 (display (get-signal wire)))))

(define the-agenda (make-agenda))

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))


(probe 'sum sum)
(probe 'carry carry)
(half-adder input-1 input-2 sum carry)
(set-signal! input-1 1)
(propogate)