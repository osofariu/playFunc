#lang racket
(require (planet "better-monads.rkt" ("toups" "functional.plt" 1 1)))


(mlet* in: the-list-monad
       ((x '(1 2 3))
        (y 5)
        (z 10))
       (return (+ x y)))

