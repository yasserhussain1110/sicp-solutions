(load "ex-2.69.scm")
(load "ex-2.68.scm")

(define rock-huff (generate-huffman-tree '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1))))

(length 
 (encode '(
	  get a job
	  sha na na na na na na na na
	  get a job
	  sha na na na na na na na na
	  wah yip yip yip yip yip yip yip yip yip
	  sha boom
	  ) rock-huff))

;; with fixed length: - 108
