#lang racket

(require "aoc.rkt")


(define/match (direction d)
  [(#\^) -i]
  [(#\v) +i]
  [(#\<) -1]
  [(#\>) +1])

(define (visit-houses data)
  (for/fold ([visited (set 0)]
             [loc 0]
             #:result visited)
            ([d (in-list data)])
    (define new-loc (+ loc (direction d)))
    (values (set-add visited new-loc) new-loc)))

(define (split-work data rem)
  (for/list ([(d i) (in-indexed data)]
             #:when (= rem (modulo i 2)))
    d))


(define data (read-input-line 3 'list))

(set-count (visit-houses data))
(set-count (set-union (visit-houses (split-work data 0))
                      (visit-houses (split-work data 1))))
