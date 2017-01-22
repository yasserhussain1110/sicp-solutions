(load "ex-3.3.scm")

(define (make-joint old-account old-account-password new-password)
  (lambda (password command)
    (if (eq? password new-password)
        (old-account old-account-password command)
        "Password provided is incorrect")))