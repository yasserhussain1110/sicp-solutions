(load "ex-2.63.scm")
(load "ex-2.64.scm")
(load "ordered-set.scm")

(define (union-set-binary tree1 tree2)
  (list->tree (union-set (tree->list-2 tree1) (tree->list-2 tree2))))

(define (intersection-set-binary tree1 tree2)
  (list->tree (intersection-set (tree->list-2 tree1) (tree->list-2 tree2))))
