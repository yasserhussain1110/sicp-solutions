(define (make-table same-key?)
  (let ((table (cons '*table* '())))
    (define (is-table? value)
      (and (pair? value) (eq? (car value) '*table*)))

    (define (assoc key same-key? records)
      (cond ((null? records) #f)
            ((same-key? (caar records) key) (car records))
            (else (assoc key same-key? (cdr records)))))

    (define (lookup keys table)
      (cond ((null? keys) (if (is-table? table) #f table))
            ((not (is-table? table)) #f)
            (else (let ((record (assoc (car keys) same-key? (cdr table))))
                    (if record
                        (lookup (cdr keys) (cdr record))
                        #f)))))

    (define (insert! keys value table)
      (if (null? keys)
          table
          (let ((record (assoc (car keys) same-key? (cdr table))))
            (if (= (length keys) 1)
                (if (not record)
                    (set-cdr! table (cons (cons (car keys) value) (cdr table)))
                    (set-cdr! record value))
                (if (not record)
                    (let ((new-table (cons '*table* '())))
                      (set-cdr! table (cons
                                       (cons (car keys) new-table)
                                       (cdr table)))
                      (insert! (cdr keys) value new-table))
                    (if (is-table? (cdr record))
                        (insert! (cdr keys) value (cdr record))
                        (let ((new-table (cons '*table* '())))
                          (set-cdr! record new-table)
                          (insert! (cdr keys) value new-table))))))))

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) (lambda (keys) (lookup keys table)))
            ((eq? m 'insert-proc!) (lambda (keys value) (insert! keys value table)))
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define table (make-table equal?))

((table 'insert-proc!) '(math +) "sum")
((table 'lookup-proc) '(math +))


((table 'insert-proc!) '(a1 a2 a3) 100)
((table 'lookup-proc) '(a1 a2 a3))
((table 'insert-proc!) '(a1 a2) 50)
((table 'lookup-proc) '(a1 a2))
((table 'lookup-proc) '(a1 a2 a3))
((table 'insert-proc!) '(a1 a2 a3 a4) 1000)
((table 'lookup-proc) '(a1 a2 a3))
((table 'lookup-proc) '(a1 a2 a3 a4))

((table 'insert-proc!) '(math +) "add")
((table 'insert-proc!) '(math -) "sub")
((table 'lookup-proc) '(math -))
((table 'insert-proc!) '(math -) "new-sub")
((table 'lookup-proc) '(math -))

((table 'insert-proc!) '(c1 c2 c3) 22)
((table 'lookup-proc) '(math +))
((table 'lookup-proc) '(k1 k2 k3))
((table 'lookup-proc) '(k1 k2 k3 k4))
((table 'lookup-proc) '(c1 c2 c3))

