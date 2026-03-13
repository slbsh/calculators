#!/usr/bin/env dotnet

public class Calc {
	public static void Main(String[] args) {
		while (true) {
			var line = Console.ReadLine();
			if(!string.IsNullOrEmpty(line))
				ProcessLine(line);
			else 
				Console.WriteLine("Too Few Arguments");
		}
	}

	static void ProcessLine(string stdLine) {
		var stack = new Stack<int>();

		foreach (var e in stdLine.Split(" ", StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)) {
			if(int.TryParse(e, out int parseResult)){
				stack.Push(parseResult);
				continue;
			} 
			

			if (stack.Count < 2) {
				Console.WriteLine("Too Few Arguments");
				return;
			}

			var b = stack.Pop();
			var a = stack.Pop();
			
			switch (e) {
				case "+": stack.Push(a + b); break;
				case "-": stack.Push(a - b); break;
				case "*": stack.Push(a * b); break;
				case "/": stack.Push(a / b); break;
				default:
					Console.WriteLine("Invalid Token");
					return;
			}
		}

		if (stack.Count == 1)
			Console.WriteLine(stack.Pop());
		else
			Console.WriteLine("Invalid Input");
	}
}
