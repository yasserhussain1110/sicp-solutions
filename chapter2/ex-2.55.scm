'a

get translated to

(quote a)


So, ''abracadabra

gets translated to - 

(quote (quote abracadabra))

which is equivalent to -

(list 'quote 'abracadabra)

Hence (car ''abra...) gives quote

