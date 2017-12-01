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
	my $prevChar = substr $captcha, -1;

	# say $prevChar;
	my @matchingChars;
	foreach (split //, $captcha) {
		$index++;
		if (($_ eq $prevChar)) {
			push @matchingChars, $_;
		}
		$prevChar = $_;
	}
	foreach my $char (@matchingChars) {
		$sum += $char;
	}

	say "Sum: $sum";
}