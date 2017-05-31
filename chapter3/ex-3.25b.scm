(define (is-table? value)
  (and (pair? value) (eq? (car value) '*table*)))

(define (lookup keys table)
  (cond ((null? keys) (if (is-table? table) #f table))
        ((not (is-table? table)) #f)
        (else (let ((record (assoc (car keys) (cdr table))))
                (if record
                    (lookup (cdr keys) (cdr record))
                    #f)))))

(define (insert! keys value table)
  (if (null? keys)
      table
      (let ((record (assoc (car keys) (cdr table))))
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


(define table (cons '*table* '()))


(insert! '(a1 a2 a3) 100 table)
(lookup '(a1 a2 a3) table)
(insert! '(a1 a2) 50 table)
(lookup '(a1 a2) table)
(lookup '(a1 a2 a3) table)
(insert! '(a1 a2 a3 a4) 1000 table)
(lookup '(a1 a2 a3) table)
(lookup '(a1 a2 a3 a4) table)


(insert! (list 'math '+) "add" table)
(insert! (list 'math '-) "sub" table)

(lookup (list 'math '-) table)

(insert! (list 'math '-) "new-sub" table)
(lookup (list 'math '-) table)

(insert! '(c1 c2 c3) 22 table)

(lookup (list 'math '+) table)
(lookup (list 'k1 'k2 'k3) table)
(lookup (list 'k1 'k2 'k3 'k4) table)
(lookup '(c1 c2 c3) table)
