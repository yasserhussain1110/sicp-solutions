(define (or-gate a b out)
  (let ((j (make-wire)) (k (make-wire)) (l (make-wire)))
    (inverter (a j))
    (inverter (b k))
    (and j k l)
    (inverter l out)))

; Total delay = inverter-delay * 2 + and-gate-delay
