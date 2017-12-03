use Modern::Perl;
use List::Util 'max', 'min', 'reduce';

my $filename = "spreadsheet.txt";

open(my $fh, '<', $filename) or die "Could not open file: $filename";

getChecksum($fh);


sub getChecksum {
	my ($spreadSheetFile) = @_;
	my @diffs;
	while (my $spreadSheetRow = <$spreadSheetFile>) {
		chomp $spreadSheetRow;
		my @spreadSheetRowList = split / /, $spreadSheetRow;
		for (my $i = 0; $i < scalar(@spreadSheetRowList); $i++) {
			for (my $j = 0; $j < scalar(@spreadSheetRowList); $j++) {
				if ($i == $j) { next }
				if ($spreadSheetRowList[$i] % $spreadSheetRowList[$j] == 0 ) { push @diffs, $spreadSheetRowList[$i] / $spreadSheetRowList[$j];	}
			}
		}
	}
	my $sum = reduce {$a + $b} @diffs;
	say $sum;
}