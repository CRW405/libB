#lang racket

;; printing
(print "Goodbye. Space?") ;; no newline ;; will include the ""
(displayln "Goodbye. Space?") ;; includes a newline, no quotes
(println "Goodbye. Space?") ;; same as displayln
(printf "num is ~a \n" 5) ;; like c printf

;; global variables
(define x 5)
(define y 10)
(define z (+ x y))
(define greeeting "Hello, World!")
(printf "x is ~a, y is ~a, z is ~a \n" x y z)
(printf "greeting is ~a \n" greeeting)

;; local variables
(define (add a b) ;; function
  (let ([sum (+ a b)]) ;; local variable
    (printf "sum is ~a \n" sum)
  sum)
)
(add 3 4) ;; call function

;; ;; user input
;; (display "Enter name: ")
;; (define name (read-line)) ;; read user input
;; (printf "Hello, ~a! \n" name)

;; conditionals
(define (is-even x)
  (if (even? x)
      "x is even"
      "x is odd")
  )
(is-even 5)

(define (is-greater-than-10 x)
  (if (> y 10)
      "y is greater than 10"
      "y is less than or equal to 10")
  )
(is-greater-than-10 5)

;; cond is like a switch statement
(define (check-code code)
  (cond
    [(= code 1) "Code is 1"]
    [(= code 2) "Code is 2"]
    [else "Code is something else"])
  )
(check-code 2)


