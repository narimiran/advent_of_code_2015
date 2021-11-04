#lang racket

(require openssl/md5 threading)


(define (solve target)
  (for/or ([i (in-naturals)])
    (~> (~a input i)
        (open-input-string)
        (md5)
        (string-prefix? target)
        (and i))))


(define input "ckczppom")

(solve "00000")
(solve "000000")