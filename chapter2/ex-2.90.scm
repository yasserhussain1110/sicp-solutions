;; common term operations

(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else
         (let ((t1 (first-term L1)) (t2 (first-term L2)))
           (cond ((> (order t1) (order t2))
                  (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                 ((< (order t1) (order t2))
                  (adjoin-term t2 (add-terms L1 (rest-terms L2))))
                 (else
                  (adjoin-term
                   (make-term (order t1)
                              (add (coeff t1) (coeff t2)))
                   (add-terms (rest-terms L1) (rest-terms L2)))))))))


(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist (type-tag L1))
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist (type-tag L))
      (let ((t2 (first-term L)))
        (adjoin-term (make-term (+ (order t1) (order t2))
                                (mul (coeff t1) (coeff t2)))
                     (mul-term-by-all-terms t1 (rest-terms L))))))


(define (install-sparse-term-package)
  
  ;; Here args will be like (2 3) (sparse . ((2, 3), (1, 5)))
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  
  
  ;; (sparse . ((2, 3), (1, 5)))  <- generic call
  ;; ((2, 3), (1, 5))             <- inside this function
  (define (first-term term-list) (car term-list))
  
  (define (rest-terms term-list) (cdr term-list))
  
  (define (empty-termlist? term-list) (null? term-list))
  
  (define (tag x) (attach-tag 'sparse x))
  
  (put 'adjoin-term 'sparse (lambda (term term-list) (tag (adjoin-term term term-list))))
  
  (put 'first-term 'sparse first-term)
  
  (put 'rest-terms 'sparse (lambda (x) (tag (rest-terms x))))
  
  (put 'empty-termlist? 'sparse empty-termlist?)
  
  (put 'the-empty-termlist 'sparse (tag '()))
  
  'done)



(define (install-dense-term-package)
  
  ;; function for internal usage
  (define (order-first-term term-list) (- (length term-list) 1))
  
  ;; Here args will be like (1 8) (dense . (2 3 4 5))
  (define (adjoin-term term term-list)
    (define (pad-term-list-with-zeros number-of-zeros)
      (if (= 0 number-of-zeros)
          term-list
          (cons 0 (pad-term-list-with-zeros (- number-of-zeros 1)))))
    
    (let ((c (coeff term)) (o (order term)))
      (if (=zero? c)
          term-list
          (cons c (pad-term-list-with-zeros (- o (length term-list)))))))
  
  ;; (dense . (1, 5, 0, 8))  <- generic call
  ;; (1, 5, 0, 8)            <- inside this function
  (define (first-term term-list) (list (order-first-term term-list) (car term-list)))
  
  (define (rest-terms term-list) (cdr term-list))
  
  (define (empty-termlist? term-list) (null? term-list))
  
  (define (tag x) (attach-tag 'dense x))
  
  (put 'adjoin-term 'dense (lambda (term term-list) (tag (adjoin-term term term-list))))
  
  (put 'first-term 'dense first-term)
  
  (put 'rest-terms 'dense (lambda (x) (tag (rest-terms x))))
  
  (put 'empty-termlist? 'dense empty-termlist?)
  
  (put 'the-empty-termlist 'dense (tag '()))
  
  'done)

(define (make-term order coeff) (list order coeff))

(define (order term) (car term))

(define (coeff term) (cadr term))

(define (the-empty-termlist type)
  ((get 'empty-termlist type)))

(define (get-function-by-term-list-type op termlist-type)
  (get op termlist-type))

(define (adjoin-term term term-list)
  ((get-function-by-term-list-type (type-tag term-list)) term term-list))

(define (first-term term-list)
  ((get-function-by-term-list-type (type-tag term-list)) term-list))

(define (rest-terms term-list)
  ((get-function-by-term-list-type (type-tag term-list)) term-list))

(define (empty-termlist? term-list)
  ((get-function-by-term-list-type (type-tag term-list)) term-list))