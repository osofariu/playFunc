#lang racket

(require rackunit)
(require rackunit/text-ui)

;; stride can be negative, in which case you can assume low is greater than high
;; must return an error if the stride is zero

(define (sequence low high stride)
  
  (define (should-stop new-low)
    (let ((direction  (if (> stride 0) 1 -1)))
      (> (* new-low direction) (* high direction))))
  
  (define (sequence-maker low)
    (if (should-stop low)
        '()
        (cons low (sequence-maker (+ low stride)))))
  
  (cond [(= stride 0) (error "Stride cannot be zero")]
        [else (sequence-maker low)]))



(define-test-suite
 sequence-tests
 #:before (lambda () (display "Before"))
 #:after  (lambda () (display "After"))
 (test-equal? "normal increase" (sequence 12 15 2) '(12 14))
 (test-equal? "normal increase match max" (sequence 12 14 2) '(12 14))
 (test-equal? "negative stride" (sequence 15 12 -2) '(15 13))
 (test-equal? "normal with stride 1" (sequence 12 13 1) '(12 13))
 (test-equal? "negative stride" (sequence 13 12 -1) '(13 12))
 (test-exn "zero stride" exn:fail? (lambda () (sequence 1 2 0))))

(run-tests sequence-tests)