(load "stream-commons.scm")

(define (RLC R L C dt)
  (define (circuit vC0 iL0)
    (define iL (integral (delay diL) iL0 dt))
    (define vC (integral (delay dvC) vC0 dt))
    (define dvC (scale-stream iL (/ -1 C)))
    (define diL (add-streams
                  (scale-stream iL (/ (- R) L))
                  (scale-stream vC (/ 1 L))))
    (cons vC iL))
  circuit)
