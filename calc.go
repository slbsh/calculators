#!/usr/bin/env -S sh -c 'f=$(mktemp /tmp/XXXXXX.go); tail +2 $0 > $f; go run $f'

package main
import("container/list"; "bufio"; "fmt"; "os"; "strings"; "strconv")

func main() {
	loop: for {
		stack := list.New();
		line, _ := bufio.NewReader(os.Stdin).ReadString('\n');

		for _, e := range strings.Fields(line) {
			n, err := strconv.Atoi(e);
			if err == nil {
				stack.PushBack(n);
				continue;
			}

			if stack.Len() < 2 {
				fmt.Println("Too Few Arguments");
				continue loop;
			}

			b := stack.Remove(stack.Back()).(int);
			a := stack.Remove(stack.Back()).(int);

			switch e {
				case "+": stack.PushBack(a + b)
				case "-": stack.PushBack(a - b)
				case "*": stack.PushBack(a * b)
				case "/": stack.PushBack(a / b)
				default: {
					fmt.Println("Invalid Token");
					continue loop;
				}
			}
		}

		if stack.Len() == 1 {
			fmt.Println(stack.Front().Value)
		} else {
			fmt.Println("Invalid Input")
		}
	}
}
