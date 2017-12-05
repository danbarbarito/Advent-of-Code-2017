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
        my @passphraseRowList = split( ' ', $passphraseRow );
        my @sortedPassphraseRowList;
        foreach my $passphrase (@passphraseRowList) {
            unshift @sortedPassphraseRowList, $passphrase;
        }

        my @current;
        my @prev;
        my $valid = 1;
        foreach ( sort @sortedPassphraseRowList ) {
            @current = sort( split '', $_ );
            if ( @current ~~ @prev ) {
                $valid = 0;
                last;
            }
            @prev = sort( split '', $_ );
        }

        # say "$passphraseRow: VALID" if $valid;

        # say "$passphraseRow: INVALID" if $valid == 0;
        $totalValid++ if $valid;
    }

    say "Total valid: $totalValid";
}
