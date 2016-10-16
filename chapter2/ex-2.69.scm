(load "huffman.scm")

(define (successive-merge leaf-set)
  (cond ((null? (cdr leaf-set)) (car leaf-set))
	(else
	 (let ((first-sub-tree (car leaf-set))
	       (second-sub-tree (cadr leaf-set))
	       (remaining-sub-tree (cddr leaf-set)))
	   (successive-merge
	    (adjoin-set (make-code-tree first-sub-tree second-sub-tree)
			remaining-sub-tree))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
