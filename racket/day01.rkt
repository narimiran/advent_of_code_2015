#lang racket

(require "aoc.rkt")


(define data (read-input-line 1 'list))

(define floors
  (for/fold ([accum '(0)]
             #:result (reverse accum))
            ([c (in-list data)])
    (cons ((if (char=? #\( c) add1 sub1) (first accum)) accum)))

(last floors)
(for/first ([(f i) (in-indexed floors)] #:when (< f 0)) i)
