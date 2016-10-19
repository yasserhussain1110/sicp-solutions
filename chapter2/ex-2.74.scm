;; a

(define (get-record file employee-name)
  (if (null? file)
      '()
      (let ((top-record (get-top-record file)))
        (if (eq? (get-name top-record) employee-name)
            top-record
            (get-record (get-rest-records file) employee-name)))))

(define (get-top-record set-of-records)
  ((get 'get-top-record (type set-of-records)) set-of-records))

(define (get-name-of-record a-record)
  ((get 'get-name-of-record (type a-records)) a-record))

(define (get-rest-of-records set-of-records)
  ((get 'get-rest-of-records (type set-of-records)) set-of-records))



;; b


(define (get-salary a-record)
  (define (get-salary-record record-set)
    (if (null? record-set)
        '()
        (let ((top-individual-record (get-top-individual-record record-set)))
          (if (eq? (name top-individual-record) 'salary)
              (value top-individual-record)
              (get-salary-record (get-rest-individual-records record-set))))))

        
  (let ((record-set (get-record-set a-record)))
    (let ((salary-record (get-salary-record record-set)))
      (if (null? salary-record)
          '()
          salary-record))))


(define (get-record-set a-record)
  ((get 'get-record-set (type a-record)) a-record))

(define (top-individual-record record-set)
  ((get 'top-individual-record (type record-set)) record-set))

(define (name individual-record)
  ((get 'name (type individual-record)) individual-record))

(define (value individual-record)
  ((get 'value (type individual-record)) individual-record))

;; c

(define (find-employee-record files employee-name)
  (let ((matched-employee-records (filter (lambda (record) (not (null? record))) 
                                          (map (lambda (each-file)
                                                 (get-record each-file employee-name)) files))))
    (if (null? matched-employee-records)
        '()
        (car matched-employee-records))))



;; d
;; none
            



  







  