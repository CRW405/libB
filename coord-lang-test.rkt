#lang typed/racket
(require "racket-basics.rkt")

(d-coord c1 1 2)
(d-vector v1 3 4 5)
(define c2 (move c1 v1 6))
(printf "moving from ~a to ~a with vector ~a\n" c1 c2 v1)
(printf "adding c1: ~a and c2: ~a gives ~a\n" c1 c2 (add c1 c2))
