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
		my @spreadSheetRowList = split /	/, $spreadSheetRow;
		push @diffs, max(@spreadSheetRowList) - min(@spreadSheetRowList);
	}
	my $sum = reduce {$a + $b} @diffs;
	say $sum;
}