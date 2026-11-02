#lang typed/racket

;; defining a coordinate language type
(define-type Coord (Pairof Number Number))
(define-type Scalar Number)
(define-type Vector (Pairof Coord Scalar))
(define-type Time Scalar)

;; define some macros to make it easier to define coordinates and vectors
(define-syntax-rule (d-coord name x y)
  (define name (cons x y))
  )
(define-syntax-rule (d-vector name x y s)
  (define name (cons (cons x y) s))
  )

;; type checked function to move a coordinate by a vector over time
(: move (-> Coord Vector Time Coord))
(define (move c v t)
  (cons (+ (car c) (* (car (car v)) t)) (+ (cdr c) (* (cdr (car v)) t)))
  )

;; create addition function and make + use it for coordinates
(: add (-> Coord Coord Coord))
(define (add c1 c2)
  (cons (+ (car c1) (car c2)) (+ (cdr c1) (cdr c2)))
  )
(provide Coord Vector Time Scalar d-coord d-vector move add (rename-out [add +]))
