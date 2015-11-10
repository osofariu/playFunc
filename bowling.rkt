#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (game rolls)
  (define (make-frames rolls)
    (cond [(null? rolls) null]
          [(= (first rolls) 10) (cons '(10 0) (make-frames (drop rolls 1)))]
          [else (cons (take rolls 2) (make-frames (drop rolls 2)))]))
  
  (define (score-game frames index)  
    (define (score-frame frames)
      (define (is-spare? frame) (= 10 (+ (first frame) (second frame))))
      (define (is-strike? frame) (= 10 (first frame)))
      (define (next-roll frames) (first (second frames)))
      (define (next-next-roll frames)
        (if (= (first (second frames)) 10)
            (first (third frames))
            (second (second frames))))
      
      (let* ((current-frame (first frames))
             (curent-frame-score  (+ (first current-frame) (second current-frame))))
        (cond [(> index  10) 0]
              [(is-strike? current-frame)
               (+ curent-frame-score (next-roll frames) (next-next-roll frames))]
              [(is-spare? current-frame)
               (+ curent-frame-score (next-roll frames))]
              [else
               curent-frame-score])))
    
    (if (null? frames)
        0
        (+ (score-frame frames)
           (score-game (rest frames) (+ index 1)))))
  
  (score-game (make-frames rolls) 1))

(define-test-suite
  bowling
  (test-equal? "simple incomplete rolls" (game '(1  8  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 27)
  (test-equal? "one spare"               (game '(1  9  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 29)
  (test-equal? "one strike"              (game '(10 1  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 30) 
  (test-equal? "two strikes"             (game '(10 10 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 49)
  (test-equal? "three strikes in a row"  (game '(10 10 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0)) 60) 
  (test-equal? "perfect game"            (game '(10 10 10 10 10 10 10 10 10 10 10 10)) 300))

(run-tests bowling)

