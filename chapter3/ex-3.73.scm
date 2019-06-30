(load "stream-commons.scm")

(define (RC R C dt)
  (define (voltages current v0)
    (define partial-sums-integral (cons-stream v0 (add-streams partial-sums-integral (scale-stream current (/ dt C)))))
    (define volt-stream (add-streams partial-sums-integral (scale-stream current R)))
    volt-stream)
  voltages)
