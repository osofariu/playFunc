#lang lazy
(require rackunit)
(require rackunit/text-ui)

(define (game rolls) 
  (define (is-spare? frame) (= 10 (+ (first frame) (second frame))))
  (define (is-strike? frame) (= 10 (first frame)))
  
  (define (make-frames rolls)
    (cond [(null? rolls)
           null]
          [(is-strike? (take 1 rolls))
           (cons (take 3 rolls) (make-frames (rest rolls)))]
          [(is-spare? (take 2 rolls))
           (cons (take 3 rolls) (make-frames (rest (rest rolls))))]
          [else (cons (take 2 rolls)
                      (make-frames (rest (rest rolls))))]))
  
  (define (score-game frames)
    (define (score-frame frame)
      (foldl + 0 frame))

    (if (null? frames)
        0
        (+ (score-frame (first frames))
           (score-game (rest frames)))))
  
  (score-game (take 10 (make-frames rolls))))

(define-test-suite bowling
  (test-equal? "simple incomplete rolls" (! (game '(1  8  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))) 27)
  (test-equal? "one spare"               (! (game '(1  9  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))) 29)
  (test-equal? "one strike"              (! (game '(10 1  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))) 30)
  (test-equal? "two strikes"             (! (game '(10 10 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))) 49)
  (test-equal? "three strikes in a row"  (! (game '(10 10 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0))) 60)
  (test-equal? "perfect game"            (! (game '(10 10 10 10 10 10 10 10 10 10 10 10))) 300))

(run-tests bowling)

