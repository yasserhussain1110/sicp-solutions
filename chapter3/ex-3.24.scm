(define (assoc key same-key? records)
  (cond ((null? records) #f)
        ((same-key? (caar records) key) (car records))
        (else (assoc key same-key? (cdr records)))))

(define (make-table same-key?)
  (let ((table (cons '*table* '())))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 same-key? (cdr table))))
        (if subtable
            (let ((record (assoc key-2 same-key? (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))

    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 same-key? (cdr table))))
        (if subtable
            (let ((record (assoc key-2 same-key? (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable (cons (cons key-2 value)
                                           (cdr subtable)))))
            (set-cdr! table
                      (cons
                       (list key-1 (cons key-2 value))
                       (cdr table))))))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define table (make-table equal?))

((table 'insert-proc!) 'math '+ "sum")
((table 'lookup-proc) 'math '+)
