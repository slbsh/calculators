#!/usr/bin/env bash

while true; do
	read -ra line

	for (( i = 0; i < ${#line[@]}; i++ )); do
		if [[ "${line[i]}" =~ ^-?[0-9]+$ ]]; then
			stack+=("${line[i]}")
			continue
		fi

		if [[ ${#stack[@]} -lt 2 ]]; then
			echo "Too Few Arguments"
			break
		fi

		j=$((${#stack[@]} - 1))
		a=${stack[j]}; unset 'stack[j]'
		b=${stack[j - 1]}

		case "${line[i]}" in
			"+") stack[j - 1]=$((a + b));;
			"-") stack[j - 1]=$((a - b));;
			"*") stack[j - 1]=$((a * b));;
			"/") stack[j - 1]=$((a / b));;
			*)   echo "Invalid Token"; break;;
		esac
	done

	[[ ${#stack[@]} = 1 ]] && echo "${stack[0]}" || echo "Invalid Input"
done
