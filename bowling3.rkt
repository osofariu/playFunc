#lang lazy

(define (drop ct lst) (if (<= ct 0) lst (drop (- ct 1) (rest lst))))
                
(define (game rolls) 
  (define (is-spare? frame) (= 10 (+ (first frame) (second frame))))
  (define (is-strike? frame) (= 10 (first frame)))

  (define (advance-rolls rolls)
    (let ((advance-ct (if (or (is-strike? rolls) (is-spare? rolls)) 3 2)))
      (take advance-ct rolls)))

  (define (drop-rolls rolls)
    (let ((drop-ct (if (is-strike? rolls) 1 2) ))
      (drop drop-ct rolls)))
  
  (define (make-frames rolls)
    (if (null? rolls)
        null
        (cons (advance-rolls rolls) (make-frames (drop-rolls rolls)))))
    
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