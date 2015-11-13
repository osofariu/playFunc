#lang racket

(require rackunit)
(require rackunit/text-ui)
(provide run-bowling)

(define (run-bowling game)
  (define-test-suite bowling
    (test-equal? "simple incomplete rolls" (game '(1  8  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 27)
    (test-equal? "one spare"               (game '(1  9  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 29)
    (test-equal? "one strike"              (game '(10 1  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 30)
    (test-equal? "two strikes"             (game '(10 10 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 49)
    (test-equal? "three strikes in a row"  (game '(10 10 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0)) 60)
    (test-equal? "perfect game"            (game '(10 10 10 10 10 10 10 10 10 10 10 10)) 300))

  (run-tests bowling))