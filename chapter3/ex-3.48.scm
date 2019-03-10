(define (serialized-exchange account1 account2)
  (if (> (account1 'number) (account2 'number))
      (serialized-exchange account2 account1)
      (let ((serializer1 (account1 'serializer))
            (serializer2 (account2 'serializer)))
        ((serializer1 (serializer2 exchange))
         account1
         account2))))
