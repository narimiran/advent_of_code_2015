#lang racket

(require "aoc.rkt")


(define (nice-1? s)
  (and
   (<= 3 (count (λ (c) (string-contains? "aeiou" (string c))) (string->list s)))
   (for/or ([a (in-string s)]
            [b (in-string (substring s 1))])
     (char=? a b))
   (not (ormap (curry string-contains? s) '("ab" "cd" "pq" "xy")))))


(define (nice-2? s)
  (and
   (for/or ([i (in-range (sub1 (string-length s)))])
     (string-contains? (substring s 0 i) (substring s i (+ i 2))))
   (for/or ([a (in-string s)]
            [b (in-string (substring s 2))])
     (char=? a b))))


(define data (read-input 5))

(count nice-1? data)
(count nice-2? data)