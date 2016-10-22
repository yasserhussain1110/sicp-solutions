(load "complex-number-package.scm")
(load "rational-number-package.scm")
(load "real-number-package.scm")
(load "math-op.scm")
(load "ex-2.83.scm")
(load "ex-2.84.scm")
(load "ex-2.79.scm")


(define (install-project-module)

  (define (get-multiple-of-ten-which-removes-decimal multiple-of-ten num)
    (if (= (floor (* multiple-of-ten num)) (* multiple-of-ten num))
        multiple-of-ten
        (get-multiple-of-ten-which-removes-decimal (* multiple-of-ten 10) num)))

  (put 'project '(complex) (lambda (x) (let ((real-part (real-part x)))
                                         (make-real-number real-part))))

  (put 'project '(real) (lambda (x) (if (rational? x)
                                        (let ((multiple (get-multiple-of-ten-which-removes-decimal 1 x)))
                                          (make-rational-number (* x multiple) multiple))
                                        (error "don't know what to do. Got -" x))))
                                                              

  (put 'project '(rational) (lambda (x) (numer x)))

  'done)



(define (project num) (apply-generic 'project num))


(install-raise-module)
(install-next-module)
(install-eq-for-ordinary-rational-complex)


(define (drop num)
  (let ((project-proc (get 'project (list (type-tag num)))))
    (if (not project-proc)
        num
        (let ((projected (project num)))
          (if (equ? num (raise projected))
              (drop projected)
              num)))))


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
          (if (or (eq? op 'add) (eq? op 'sub) (eq? op 'mul) (eq? op 'div))
              (drop (apply proc (map contents args)))
              (apply proc (map contents args)))              
          (let ((coerced-args (coerce-args args)))
            (let ((proc2 (get op (map type-tag coerced-args))))
              (if proc2
                  (if (or (eq? op 'add) (eq? op 'sub) (eq? op 'mul) (eq? op 'div))
                      (drop (apply proc2 (map contents coerced-args)))
                      (apply proc2 (map contents coerced-args)))                      
                  (error "Neither method available nor coercion helped" (list op args)))))))))

; For testing


(install-complex-package)
(install-real-package)
(install-rational-package)
(install-project-module)


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

(define z1 (make-complex-from-mag-ang 20 45))
(project z1)



(define z2 (make-real-number 1.23))
(project z2)

(define z3 (make-rational-number 3 4))
(project z3)

(drop (make-complex-from-real-imag 1 0))
(drop (make-real-number 12.87))
(drop 12)

(sub (make-complex-from-real-imag 2 3) (make-complex-from-real-imag 12 3))
(add (make-rational-number 1 3) (make-complex-from-real-imag 12 3))
