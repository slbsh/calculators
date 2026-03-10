#!/usr/bin/env -S java --source 17

import java.util.Scanner;
import java.util.ArrayList;

public class calc {
	public static void main(String[] args) {
		var stdin = new Scanner(System.in);

		while (true) {
			var stack = new ArrayList<Integer>();

			for (var e : stdin.nextLine().split(" ")) {
				try {
					stack.add(Integer.parseInt(e));
					continue;
				} catch (Exception l) {}
				

				if (stack.size() < 2) {
					System.out.println("Too Few Arguments");
					break;
				}

				var a = stack.remove(stack.size() - 1);
				var b = stack.remove(stack.size() - 1);
				
				switch (e) {
					case "+" -> stack.add(a + b);
					case "-" -> stack.add(a - b);
					case "*" -> stack.add(a * b);
					case "/" -> stack.add(a / b);
					default  -> {
						System.out.println("Invalid Token");
						break;
					}
				}
			}

			if (stack.size() == 1)
				System.out.println(stack.get(0));
			else
				System.out.println("Invalid Input");
		}
	}
}
