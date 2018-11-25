(load "queue.scm")

(define (make-segment time) (cons time (make-queue)))

(define (segment-time segment) (car segment))

(define (procedure-queue segment) (cdr segment))

(define (make-agenda) '(0))

(define (segments agenda) (cdr agenda))

(define (time-agenda agenda) (car agenda))

(define (empty? agenda) (null? (segments agenda)))

(define (set-segments! agenda segments) (set-cdr! agenda segments))

(define (set-time! agenda time) (set-car! agenda time))

;; time - delay time
;; action - is just a procedure
;; agenda - agenda to add action on
(define (add-to-agenda! time action agenda)
  (define (belongs-in-front? segments)
    (or (null? segments)
        (< time (segment-time (car segments)))))

  (define (same-time-as-front? segments)
    (eq? (segment-time (car segments)) time))

  (define (add-to-segments! segments)
    (cond ((belongs-in-front? segments)
           (let ((s (make-segment time)))
             (insert-queue! (procedure-queue s) action)
             (cons s segments)))
           ((same-time-as-front? segments)
            (begin (insert-queue! (procedure-queue (car segments)) action)
                   segments))
           (else
            (cons (car segments) (add-to-segments! (cdr segments))))))

  (let ((s (add-to-segments! (segments agenda))))
    (set-segments! agenda s)
    'done))

(define (remove-from-agenda! agenda)
  (let ((segments (segments agenda)))
    (if (not (null? segments))
        (let ((first-time-segment (car segments)))
          (let ((q (procedure-queue first-time-segment)))
            (begin
              (set-time! the-agenda (segment-time first-time-segment))
              (let ((current-action (front-queue q)))
                (delete-queue! q)
                (if (empty-queue? q)
                    (set-segments! agenda (cdr segments)))
                current-action)))))))

(define (propogate) (if (empty? the-agenda)
                        'done
                        (begin ((remove-from-agenda! the-agenda))
                               (propogate))))

(define (propogate-once) (if (empty? the-agenda)
                             'done
                             ((remove-from-agenda! the-agenda))))
                        

;(define (p1 x) (+ x 1))
;(define (p2 x) (* x x))
;(define (p3 x) (* x x x))
;(define (p4 x) (* x x x 1000))

;(define the-agenda (make-agenda))
;(add-to-agenda! 10 p1 the-agenda)
;(add-to-agenda! 5 p2 the-agenda)
;(add-to-agenda! 20 p3 the-agenda)
;(add-to-agenda! 5 p4 the-agenda)
