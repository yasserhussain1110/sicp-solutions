(load "op-type-table.scm")
(load "complex-number-package.scm")
(load "rational-number-package.scm")
(load "ex-2.83.scm")
(load "real-number-package.scm")

(define (install-next-module)

  (put 'next 'integer 'rational)
  (put 'next 'rational 'real)
  (put 'next 'real 'complex)

  'done)


(define (apply-generic op . args)
  (define (t1-lower-to-t2? t1 t2)
    (let ((next-type (get 'next t1)))
      (cond ((not next-type) #f)
            ((eq? next-type t2) #t)
            (else (t1-lower-to-t2? next-type t2)))))
  
  (define (repeatedly-raise-arg-to-type a1 type)
    (cond ((eq? (type-tag a1) type) a1)
          (else (repeatedly-raise-arg-to-type (raise a1) type))))
  
  (define (highest-type types)
    (if (= (length types) 1)
        (car types)
        (let ((t1 (car types)) (t2 (cadr types)))
          (if (t1-lower-to-t2? t1 t2)
              (highest-type (cdr types))
              (highest-type (cons t1 (cddr types)))))))
  
  (define (coerce-args args)
    (if (<= (length args) 1)
        args
        (let ((highest-arg-type (highest-type (map type-tag args))))
          (cons (repeatedly-raise-arg-to-type (car args) highest-arg-type)
                (coerce-args (cdr args))))))
  
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((coerced-args (coerce-args args)))
            (let ((proc2 (get op (map type-tag coerced-args))))
              (if proc2
                  (apply proc (map contents coerced-args))
                  (error "Neither method available nor coercion helped" (list op args)))))))))


; For testing

(define (attach-tag type-tag contents)
  (cond ((eq? type-tag 'integer) contents)
        (else (cons type-tag contents))))

(define (type-tag datum)
  (cond ((integer? datum) 'integer)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((integer? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))


(install-rational-package)
(install-complex-package)
(install-real-package)
(install-raise-module)
(install-next-module)

(define (t1-lower-to-t2? t1 t2)
    (let ((next-type (get 'next t1)))
      (cond ((not next-type) #f)
            ((eq? next-type t2) #t)
            (else (t1-lower-to-t2? next-type t2)))))

(define (repeatedly-raise-arg-to-type a1 type)
  (cond ((eq? (type-tag a1) type) a1)
        (else (repeatedly-raise-arg-to-type (raise a1) type))))

(define (highest-type types)
  (if (= (length types) 1)
      (car types)
      (let ((t1 (car types)) (t2 (cadr types)))
        (if (t1-lower-to-t2? t1 t2)
            (highest-type (cdr types))
            (highest-type (cons t1 (cddr types)))))))

(define (coerce-args args)
    (if (<= (length args) 1)
        args
        (let ((highest-arg-type (highest-type (map type-tag args))))
          (cons (repeatedly-raise-arg-to-type (car args) highest-arg-type)
                (coerce-args (cdr args))))))

;(repeatedly-raise-arg1-to-arg2 1 2.1)
;(repeatedly-raise-arg1-to-arg2 1 (make-real-number 2.1))


(coerce-args (list 2 (make-real-number 1.0)))
(coerce-args (list (make-rational-number 2 3) (make-real-number 25)))
(coerce-args (list 15 (make-rational-number 2 3)))
(coerce-args (list 12 (make-rational-number 2 3) (make-real-number 1.0)))
    

