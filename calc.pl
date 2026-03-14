#!/usr/bin/env perl

use Scalar::Util qw(looks_like_number);

while (1) {
	chomp(my $line = <STDIN>);
	my @stack;

	foreach (split ' ', $line) {
		(push(@stack, 0 + $_), next) if looks_like_number $_;
		@stack >= 2 or (print("Too Few Arguments\n"), last);

		my ($b, $a) = splice @stack, -2;
		push @stack, $_ eq '+' ? $a + $b
			: $_ eq '-' ? $a - $b
			: $_ eq '*' ? $a * $b
			: $_ eq '/' ? int($a / $b)
			: (print("Invalid Token\n"), last);
	}

	@stack == 1 or (print("Invalid Input\n"), next);
	print $stack[0], "\n";
}
