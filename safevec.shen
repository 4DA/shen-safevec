(datatype subtype 
  (subtype B A); X : B; 
  _____________________ 
  X : A;) 

(datatype positive
  if (and (number? X) (> X 0))
  ____________
  X: positive;

  ________________________
  (subtype positive number);

  _______________________________________
  +: (positive --> positive --> positive);
)

(datatype integer
  if (integer? X)
  ___________
  X: integer;

  ________________________
  (subtype integer number);
)

(datatype natural
  X: positive;
  X: integer;
  ============
  X: natural;
)

(define positive? 
  {number --> boolean}
  X -> (> X 0))

(define natural?
  {number --> boolean}
  X -> (and (integer? X) (positive? X)))

(datatype index
  X: natural;
  =============
  X: (index X);

  \* if (> X Y) *\
  \* X: natural; *\
  \* Y: natural; *\
  \* __________ *\
  \* X: (index Y); *\

  if (and (natural? X) (natural? Y) (< X Y))
  _____________
  X: (index Y);

  \* if (and (natural? K) (natural? K) (< K L)) *\
  \* A: (index K); *\
  \* B: (index L); *\
  \* _____________ *\
  \* B: (index K); *\

  if (and (positive? N1) (positive? N2))
  \* N1: positive; *\
  \* N2: positive; *\
  _____________
  (> N1 (- N1 N2)): true;
)

\* (define f *\
\*   {(index N) --> (index L)} *\
\*   N -> (- N 1)) *\

(define f
  {(index N) --> (index N)}
  N -> N)

(datatype safevec
  N : (index N);
  =========================
  (vector N) : (safevec N);
)

(define safevec-init
 {(index N) --> (safevec N)}
 N -> (vector N))

\* --------------------------------------------------------------------------------*\
(define safevec-ref
  {(safevec K) --> (index K) --> A}
  V L -> (<-vector V L))

\*---------------------------------------------------------------------------------*\
(define safevec-ref
\* returns n'th element of the vector and throws exception if (n > length) of list *\
  {(vector A) --> number --> A}
  V N -> (<-vector V N) where (>= (limit V) N)
  _ _ -> (error "Out of bounds exception"))

(define vector-ref
\* returns n'th element of the vector and throws exception if (n > length) of list *\
  {(vector A) --> number --> A}
  V N -> (<-vector V N) where (>= (limit V) N)
  _ _ -> (error "Out of bounds exception"))

\*---------------------------------------------------------------------------------*\
(define list-vect-help
  {(list A) --> (vector A) --> number --> (vector A)}
  []    V _    -> V
  [A|B] V N -> (list-vect-help B (vector-> V N A) (+ N 1)))

(define list->vector
\* makes list->vector conversion *\
  {(list A) --> (vector A)}
  L -> (list-vect-help L (vector (length L)) 1))

\*---------------------------------------------------------------------------------*\
(define vector->list-help
  {(vector A) --> number --> number --> (list A) --> (list A)}
  _ End End Acc -> (reverse Acc)
  V I End Acc -> (vector->list-help V (+ I 1) End [(<-vector V I) | Acc]))

(define vector->list
  \* makes list->vector conversion *\
  {(vector A) --> (list A)}
  V -> (vector->list-help V 1 (+ 1 (limit V)) []))

