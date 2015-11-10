#lang racket

(define (return v)
  (lambda ()
    v))

(define (bind a f)
  (let ((va (a)))
    (if (null? va)
        (return null)
        (return (f (a))))))

(define (inc v)
  (+ v 1))

(define (add v1)
  (lambda (v2)
    (+ v1 v2)))

(define (div v1)
  (lambda (v2)
    (if (= v1 0)
        null
        (/ v2 v1))))


(bind (return '())  inc)

(let*
 ((v1 (bind (return 10) inc))
  (v2 (bind v1 inc))
  (v3 (bind v2 inc))
  (v4 (bind v3 inc))
  (v5 (bind v4 (add 10)))
  (v6 (bind v5 (div 2)))
  (v7 (bind v6 inc)))
 (v7))


