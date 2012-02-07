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

  if (and (natural? X) (natural? Y) (< X Y))
  _____________
  X: (index Y);
)

(datatype safevec

  K: (index K);
  =========================
  (vector K): (safevec A K);

  \* K: (index K); *\
  ______________________________________________
  <-vector: ((safevec A K) --> ((index K) --> A));

  ______________________________________________
  vector->: ((safevec A K) --> (index K) --> A --> (safevec A K));
)

\* --------------------------------------------------------------------------------*\
(define safevec-init
 {(index N) --> (safevec A N)}
 N -> (vector N))

\* --------------------------------------------------------------------------------*\
(define safevec-ref
  {(safevec A K) --> (index K) --> A}
  V L -> (<-vector V L))

\* --------------------------------------------------------------------------------*\
(define safevec-set
  {(safevec A K) --> (index K) --> A --> (safevec A K)}
  Vec I Val -> (vector-> Vec I Val))

\* Test with this: *\
\* (safevec-ref (safevec-set (safevec-init 10) 3 3) 3) - OK*\
\* (safevec-ref (safevec-set (safevec-init 10) 3 3) 12) - type error*\

