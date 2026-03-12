#!/usr/bin/env -S clj -M

(loop []
	(loop [s [] toks (re-seq #"\S+" (read-line))]
		(if-let [t (first toks)]
			(if-let [n (parse-long t)]
				(recur (conj s n) (rest toks))
				(if-let [[b a] (take-last 2 s)]
					(if-let [op ({"+" + "-" - "*" * "/" quot} t)]
						(recur (conj (drop-last 2 s) (long (op a b))) (rest toks))
						(println "Invalid Token"))
					(println "Too Few Arguments")))
			(println (if (= 1 (count s)) (first s) "Invalid Input"))))
	(recur))
