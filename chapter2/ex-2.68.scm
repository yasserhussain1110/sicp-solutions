(load "huffman.scm")

(define (encode message tree) 
   (if (null? message) 
       '() 
       (append (encode-symbol (car message) tree) 
               (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (encode-symbol-1 symbol tree)
    (if (leaf? tree)
	'()
	(cond ((memq symbol (symbols (left-branch tree)))
	       (cons '0 (encode-symbol symbol (left-branch tree))))
	      (else
	       (cons '1 (encode-symbol symbol (right-branch tree)))))))
  (if (memq symbol (symbols tree))
      (encode-symbol-1 symbol tree)
      (error "Symbol does not exist in tree" symbol)))

