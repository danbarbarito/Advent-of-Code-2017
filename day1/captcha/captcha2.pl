use Modern::Perl;

my $filename = "captcha.txt";

open(my $fh, '<', $filename)
  or die "Could not open file: $filename";

while (my $input = <$fh>) {
	chomp $input;
	solveCaptcha($input);
}


sub solveCaptcha {
	my ($captcha) = @_;

	my $sum = 0;
	my $index = -1;

	my @matchingChars;
	my @list = split //, $captcha;
	my @doubledList = (@list, @list);
	foreach (@list) {
		$index++;
		my $halfBefore = $index + (scalar @list / 2);
		if (($_ eq $doubledList[$halfBefore])) {
			push @matchingChars, $_;
		}
	}

	foreach my $char (@matchingChars) {
		$sum += $char;
	}

	say "Sum: $sum";
}