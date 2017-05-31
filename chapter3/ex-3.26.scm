(define (lt? k1 k2)
  (cond ((and (number? k1) (number? k2)) (< k1 k2))
        ((and (symbol? k1) (symbol? k2)) (string<? (symbol->string k1) (symbol->string k2)))
        ((and (symbol? k1) (number? k2)) #t)
        ((and (number? k1) (symbol? k2)) #f)))

(define (gt? k1 k2)
  (cond ((and (number? k1) (number? k2)) (> k1 k2))
        ((and (symbol? k1) (symbol? k2)) (string>? (symbol->string k1) (symbol->string k2)))
        ((and (symbol? k1) (number? k2)) #f)
        ((and (number? k1) (symbol? k2)) #t)))

(define (make-table)
  (cons '() '*table*))

(define (table? table)
  (and (pair? table) (eq? (cdr table) '*table*)))

(define (make-tree root left right)
  (list root left right))

(define (update-subtree! tree-leg sub-tree)
  (set-car! tree-leg sub-tree))

(define (get-left-leg tree)
  (cdr tree))

(define (get-right-leg tree)
  (cddr tree))

(define (get-subtree leg)
  (car leg))

(define (get-root-node tree)
  (car tree))

(define (make-node key value)
  (cons key value))

(define (get-key node)
  (car node))

(define (get-value node)
  (cdr node))

(define (update-node-value! node value)
  (set-cdr! node value))


(define (search key tree-leg)
  (if (null? (get-subtree tree-leg))
      tree-leg
      (let ((sub-tree (get-subtree tree-leg)))
        (let ((k (get-key (get-root-node sub-tree))))
          (cond ((eq? key k) tree-leg)
                ((lt? key k) (search key (get-left-leg sub-tree)))
                ((gt? key k) (search key (get-right-leg sub-tree))))))))

(define (lookup-single key table)
  (let ((tree-leg (search key table)))
    (if (null? (get-subtree tree-leg))
        #f
        (get-value (get-root-node (get-subtree tree-leg))))))

(define (insert-single! key value table)
  (let ((tree-leg (search key table)))
    (if (null? (get-subtree tree-leg))
        (update-subtree! tree-leg (make-tree (make-node key value) '() '()))
        (update-node-value! (get-root-node (get-subtree tree-leg)) value))))

#|
(define table (make-table))
(insert-single! 50 'yasser table)
(insert-single! 25 'roman table)
(insert-single! 35 'victory table)
(insert-single! 20 'elephant table)

(lookup-single 50 table)
(lookup-single 25 table)
(insert-single! 25 'neo table)
(lookup-single 25 table)
table
|#

(define (insert! keys value table)
  (let ((top-key (car keys)))
    (let ((tree-leg (search top-key table)))
      (if (= 1 (length keys))
          (if (null? (get-subtree tree-leg))
              (update-subtree! tree-leg (make-tree (make-node top-key value) '() '()))
              (update-node-value! (get-root-node (get-subtree tree-leg)) value))
          (if (null? (get-subtree tree-leg))
              (let ((new-table (make-table)))
                (update-subtree! tree-leg (make-tree (make-node top-key new-table) '() '()))
                (insert! (cdr keys) value new-table))
              (if (table? (get-value (get-root-node (get-subtree tree-leg))))
                  (insert! (cdr keys) value (get-value (get-root-node (get-subtree tree-leg))))
                  (let ((new-table (make-table)))
                    (update-node-value! (get-root-node (get-subtree tree-leg)) new-table)
                    (insert! (cdr keys) value new-table))))))))

(define (lookup keys table)
  (let ((top-key (car keys)))
    (let ((tree-leg (search top-key table)))
      (if (null? (get-subtree tree-leg))
          #f
          (let ((value (get-value (get-root-node (get-subtree tree-leg)))))
            (if (= 1 (length keys))
                (if (table? value) #f value)
                (and (table? value) (lookup (cdr keys) value))))))))



(define table (make-table))

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

(insert! '(c1 c2 nb1 nb2) 1022 table)
(lookup '(c1 c2 nb1 nb2) table)
(lookup '(c1 c2 c3) table)
