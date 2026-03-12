#!/usr/bin/env racket
#lang typed/racket

(define (eval [line : String]) : String
	(define stack : (Listof Integer) (list))
	(let/ec return : String
		(for ([token (string-split line)])
			(match (string->number token)
				[x #:when (exact-integer? x) (set! stack (cons x stack))]
				[_
				(define op
					(match token
						["+" +]
						["-" -]
						["*" *]
						["/" quotient]
						[_ (return "Invalid Token")]))
				(match stack
					[`(,b ,a . ,rest) (set! stack (cons (op a b) rest))]
					[_ (return "Too Few Arguments")])]))
		(match stack
			[`(,x) (number->string x)]
			[_ "Invalid Input"])))

(do ([line (read-line) (read-line)]) ((eof-object? line))
	(displayln (eval line)))
