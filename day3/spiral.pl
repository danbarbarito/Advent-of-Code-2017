use Modern::Perl;
use POSIX qw(ceil);
use Switch;

my $input    = 361527;
my $size     = 1000;
my $midpoint = ceil( $size / 2 );

spiralDistance();

sub spiralDistance {
    my @up    = ( 0,  -1 );
    my @down  = ( 0,  1 );
    my @left  = ( -1, 0 );
    my @right = ( 1,  0 );
    my %directions = (
        up    => \@up,
        down  => \@down,
        left  => \@left,
        right => \@right
    );
    my @matrix = ();

    # Initialize empty matrix
    foreach ( 0 .. $size - 1 ) {
        my $y = $_;
        if ( $_ % $size == 0 ) {
            push @matrix, ();
        }
        foreach ( 0 .. $size - 1 ) {
            my $x = $_;
            $matrix[$y][$x] = 0;
        }
    }

    # Add spiral to matrix
    my $x = my $y = $midpoint - 1;
    my $cornerLen  = 1;
    my $currentNum = 1;
    my $currentDir = 'right';
    $matrix[$y][$x] = $currentNum;
    while ( ( $x != $size ) && ( $y != $size ) ) {
        my $j = 0;
        switch ($currentDir) {
            case 'right' {
                while ( $j != $cornerLen ) {
                    $matrix[$y][$x] = $currentNum;
                    $currentNum += 1;
                    $x          += @{ $directions{right} }[0];
                    $y          += @{ $directions{right} }[1];
                    $j++;
                    checkNum( $currentNum, $x, $y );
                }
                $currentDir = 'up';
            }
            case 'up' {
                while ( $j != $cornerLen ) {
                    $matrix[$y][$x] = $currentNum;
                    $currentNum += 1;
                    $x          += @{ $directions{up} }[0];
                    $y          += @{ $directions{up} }[1];
                    $j++;
                    checkNum( $currentNum, $x, $y );
                }
                $currentDir = 'left';
                $cornerLen++;
            }
            case 'left' {
                while ( $j != $cornerLen ) {
                    $matrix[$y][$x] = $currentNum;
                    $currentNum += 1;
                    $x          += @{ $directions{left} }[0];
                    $y          += @{ $directions{left} }[1];
                    $j++;
                    checkNum( $currentNum, $x, $y );
                }
                $currentDir = 'down';
            }
            case 'down' {
                while ( $j != $cornerLen ) {
                    $matrix[$y][$x] = $currentNum;
                    $currentNum += 1;
                    $x          += @{ $directions{down} }[0];
                    $y          += @{ $directions{down} }[1];
                    $j++;
                    checkNum( $currentNum, $x, $y );
                }
                $currentDir = 'right';
                $cornerLen++;
            }
        }
    }

    # Print matrix
    # foreach ( 0 .. $size - 1 ) {
    #     my $y = $_;
    #     foreach ( 0 .. $size - 1 ) {
    #         my $x = $_;
    #         if ( $x % $size == 0 ) { print "\n"; }
    #         print " " . $matrix[$y][$x] . " ";
    #     }
    # }
}

sub checkNum {
    my ( $currentNum, $x, $y ) = @_;
    if ( $currentNum == $input ) {
        say "Answer is: "
          . (
            abs( ceil( $size / 2 ) - $x ) + ( abs( ceil( $size / 2 ) - $y ) ) );
    }
}
