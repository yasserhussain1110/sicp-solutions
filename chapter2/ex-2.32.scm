(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
	(append rest (map (lambda (x) (cons (car s) x)) rest)))))


#|
If I have 2 objects the total number of ways I can select from among them (I can select all 2, none or any one among them), 
is always 2 ^ 2.

In general if I have n objects I have - 2 ^ n choices. why?

Because ultimately my selection can be reduced to a binary choice.

For instance suppose I have 3 objects A, B, C -

Then total number of ways I can select any combination of objects from among them will be.

Do I have          A           B           C         in my final combination?
 
              ___________ ___________ ___________
             |either yes |either yes |either yes |
             |or no      |or no      |or no      |
             |           |           |           |
             | (0/1)     | (0/1)     | (0/1)     |
             |___________|___________|___________|


Since it has become a binary choice so total number of choices will be 2 ^ n (2 ^ 3, in this case).


When I add an extra choice D, all I am doing is adding an extra box with (0/1) value, which will simply double my number of choices.


This subset problem can be seen in a similar fashion.


If I have to list all subsets for (A,B,C,D).

That will be same as -
  1. All subsets for (A,B,C) [Note:- Here binary choice for D is 0]
+ (plus)
  2. All subsets for (A,B,C) appended with D. eg:- ( (a-subset of a,b,c), D)  ( (another-subset of a,b,c), D)
                             [Note: Here binary choice for D is 1]

Same algorithm is implemented in this exercise.
|#

