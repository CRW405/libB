#lang racket

(require racket/cmdline)

(define page-length (make-parameter 100))
(define page-count (make-parameter 1))
(define seed (make-parameter #f))
(define char-set (make-parameter "alphabet"))

; TODO:
; - Add and remove alphabet "packs" eg: add or not add basic ASCII, Latin-1, Arrows, puncuation, numbers etc
; - Find mode, find how long it takes to find a string such as "the quick brown fox jumps over the lazy dog"
; - Structured mode, eg: word and sentence structures with proper punctuation
; - Slop scoring
; - Markov chains?
; - File generation
; - Binary file generation (probably dont run these)
; - Racket DSL
; - Searching for coherent sections || coherency scoring
; - String mutation, eg: "input" -> "inpuu" -> "inpuv" ...

(command-line
 #:once-each
 [("-l" "--length") l "Length of each page (default 100)" (page-length (string->number l))]
 [("-c" "--count") c "Number of pages (default 1)" (page-count (string->number c))]
 [("-s" "--seed") s "Seed for page generation (default random)" (seed (string->number s))]
 [("-C" "--charset") cs "Character set to use (default 'alphabet')" (char-set cs)])

(define (select-char-set cs)
  (cond
    [(equal? cs "alphabet") (string->list "abcdefghijklmnopqrstuvwxyz ")]
    [(equal? cs "ascii") (string->list (list->string (map integer->char (range 32 127))))]
    [(equal? cs "utf-unsafe")
     (let* ([valid-ints (filter (lambda (n) (not (and (>= n 55296) (<= n 57343)))) (range 0 1114112))]
            [valid-chars (map integer->char valid-ints)])
       valid-chars)]
    [(equal? cs "utf") ; safe slices
     (let* ([ranges (list (range #x0020 #x007E) ; Basic ASCII
                          (range #x00A1 #x00FF) ; Latin-1 Supplement
                          (range #x0370 #x03FF) ; Greek and Coptic
                          (range #x0400 #x04FF) ; Cyrillic
                          (range #x2000 #x206F) ; General Punctuation
                          (range #x2190 #x21FF) ; Arrows
                          (range #x2500 #x257F) ; Box Drawing
                          (range #x2580 #x259F) ; Block Elements
                          (range #x4E00 #x9FFF) ; CJK Unified Ideographs
                          (range #x1F300 #x1F5FF) ; Misc Symbols and Pictographs
                          )]
            [all-ints (apply append ranges)])
       (map integer->char all-ints))]
    [else (error "Unknown character set")]))

(define alphabet (select-char-set (char-set)))
(define alphabet-length (length alphabet))

(define select-seed (or (seed) (random 2147483647)))
(random-seed select-seed)

(define (generate-page len)
  (list->string (for/list ([i (in-range len)])
                  (list-ref alphabet (random alphabet-length)))))

(printf "Seed / Room ~a | Page Length ~a | Page Count ~a | Character set ~a\n\n"
        select-seed
        (page-length)
        (page-count)
        (char-set))

(for ([i (in-range (page-count))])
  (define page (generate-page (page-length)))
  (printf "\nPage ~a: ~a\n" (+ i 1) page))
;; kitty --hold -o "symbol-map U+0100-U+10FFFF Unifont" racket babel.rkt -C utf
