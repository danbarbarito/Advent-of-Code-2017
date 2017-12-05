use Modern::Perl;

spiralDistance(12);


sub spiralDistance {
	my ($num) = @_;
	my $closestOddSquare = $num;
	while ((sqrt($closestOddSquare) !~ /^[\d]+$/) || ($closestOddSquare % 2 == 0)) {
		$closestOddSquare--;
	}

	say "Distance: " . (sqrt($closestOddSquare) - 1);
}
