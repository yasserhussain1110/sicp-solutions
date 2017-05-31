(define (make-node key value)
  (cons key value))

(define (get-key node)
  (car node))

(define (get-value node)
  (cdr node))

(define (update-value! value node)
  (set-cdr! node value))

(define (make-tree root-node left-subtree right-subtree)
  (list root-node left-subtree right-subtree))

(define (update-tree! value tree side)
  (cond ((eq? side 'left) (set-car! (cdr tree) value))
        ((eq? side 'right) (set-car! (cddr tree) value))
        (else (error "neither left nor right"))))

(define (get-root-node tree)
  (car tree))

(define (get-left-subtree tree)
  (cadr tree))

(define (get-right-subtree tree)
  (caddr tree))

(define (make-table tree)
  (cons '*tree* tree))

(define (make-empty-table)
  (make-table '()))

(define (get-tree table)
  (cdr table))

(define lt? <)
(define gt? >)
(define same-key? eq?)

(define (search-tree key tree same-key?)
  (cond ((null? tree) #f)
        ((same-key? key (get-key (get-root-node tree))) (get-root-node tree))
        ((lt? key (get-key (get-root-node tree))) (search-tree key (get-left-subtree tree) same-key?))
        ((gt? key (get-key (get-root-node tree))) (search-tree key (get-right-subtree tree) same-key?))))

(define (insert-key-tree! key value tree same-key?)
  (if (same-key? key (get-key (get-root-node tree)))
      (update-value! value (get-root-node tree))
      (let ((subtree-result (if
                             (lt? key (get-key (get-root-node tree)))
                             (cons (get-left-subtree tree) 'left)
                             (cons (get-right-subtree tree) 'right))))
        (let ((subtree-of-interest (car subtree-result)) (side (cdr subtree-result)))
          (if (null? subtree-of-interest)
              (update-tree! (make-tree (make-node key value) '() '()) tree side)
              (insert-key-tree! key value subtree-of-interest))))))

(define (search key table same-key?)
  (search-tree key (get-tree table) same-key?))

(define (insert! key value table same-key?)
  (if (null? (get-tree table))
      (set-cdr! table (make-tree (make-node key value) '() '()))
      (insert-key-tree! key value (get-tree table) same-key?)))


(define table (make-empty-table))
(insert! 1 100 table same-key?)
(insert! 2 5000 table same-key?)
(search 1 table same-key?)
(search 2 table same-key?)
(search 3 table same-key?)
