#lang racket

(require "aoc.rkt" match-plus)


(define dimensions
  (for/list ([line (in-list (read-input 2))])
    (sort (extract-numbers line) <)))

(define/match* (paper (list a b c))
  (+ (* 3 a b) (* 2 b c) (* 2 c a)))

(define/match* (ribbon (list a b c))
  (+ (* 2 (+ a b)) (* a b c)))


(apply + (map paper  dimensions))
(apply + (map ribbon dimensions))
