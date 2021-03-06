#lang lazy

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
  
  (! (score-game (take 10 (make-frames rolls)))))

(require "bowling-test.rkt")
(run-bowling game)