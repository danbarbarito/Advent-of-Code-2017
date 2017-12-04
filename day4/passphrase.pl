use Modern::Perl;
use List::Util 'max', 'min', 'reduce';

my $filename = "passphrases.txt";

open( my $fh, '<', $filename ) or die "Could not open file: $filename";

getValidPassphrases($fh);

sub getValidPassphrases {
    my ($passphraseFile) = @_;
    my $count;
    my $totalValid = 0;
    while ( my $passphraseRow = <$passphraseFile> ) {
        chomp $passphraseRow;
        my @passphraseRowList = split / /, $passphraseRow;
        my $prev              = "";
        my $valid             = 1;
        foreach ( sort @passphraseRowList ) {
            if ( $prev eq $_ ) {
                $valid = 0;
                last;
            }
            $prev = $_;
        }
        $totalValid++ if $valid;
    }
    say "Total valid: $totalValid";
}
