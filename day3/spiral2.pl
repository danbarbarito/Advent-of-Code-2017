use Modern::Perl;
use POSIX qw(ceil);
use Switch;

my $input    = 361527;
my $size     = 200;
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
        $currentNum = sumOfNeighbors( \@matrix, $x, $y );
        switch ($currentDir) {
            case 'right' {
                while ( $j != $cornerLen ) {
                    $currentNum = sumOfNeighbors( \@matrix, $x, $y );
                    $matrix[$y][$x] = $currentNum;

                    $x += @{ $directions{right} }[0];
                    $y += @{ $directions{right} }[1];
                    $j++;
                    checkNum( $currentNum, $x, $y );
                }
                $currentDir = 'up';
            }
            case 'up' {
                while ( $j != $cornerLen ) {
                    $currentNum = sumOfNeighbors( \@matrix, $x, $y );
                    $matrix[$y][$x] = $currentNum;

                    $x += @{ $directions{up} }[0];
                    $y += @{ $directions{up} }[1];
                    $j++;
                    checkNum( $currentNum, $x, $y );
                }
                $currentDir = 'left';
                $cornerLen++;
            }
            case 'left' {
                while ( $j != $cornerLen ) {

                    $currentNum = sumOfNeighbors( \@matrix, $x, $y );
                    $matrix[$y][$x] = $currentNum;

                    $x += @{ $directions{left} }[0];
                    $y += @{ $directions{left} }[1];
                    $j++;
                    checkNum( $currentNum, $x, $y );
                }
                $currentDir = 'down';
            }
            case 'down' {
                while ( $j != $cornerLen ) {
                    $currentNum = sumOfNeighbors( \@matrix, $x, $y );
                    $matrix[$y][$x] = $currentNum;

                    $x += @{ $directions{down} }[0];
                    $y += @{ $directions{down} }[1];
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
    #         print "     " . $matrix[$y][$x] . "     ";
    #     }
    # }
}

sub sumOfNeighbors {
    my ( $matrix, $x, $y ) = @_;
    my @matrix = @$matrix;
    my $sum    = 0;

    # say "We are at ($x, $y)";

    return 1 if $x == $midpoint - 1 && $y == $midpoint - 1;

    $sum += $matrix[$y][ $x + 1 ] if inBound( $y, $x + 1 );

    # say $matrix[$y][ $x + 1 ];

    $sum += $matrix[ $y + 1 ][ $x + 1 ] if inBound( $y + 1, $x + 1 );

    # say $matrix[ $y + 1 ][ $x + 1 ];

    $sum += $matrix[ $y - 1 ][ $x + 1 ] if inBound( $y - 1, $x + 1 );

    # say $matrix[ $y - 1 ][ $x + 1 ];

    $sum += $matrix[$y][ $x - 1 ] if inBound( $y, $x - 1 );

    # say $matrix[$y][ $x - 1 ];

    $sum += $matrix[ $y + 1 ][ $x - 1 ] if inBound( $y + 1, $x - 1 );

    # say $matrix[ $y + 1 ][ $x - 1 ];

    $sum += $matrix[ $y - 1 ][ $x - 1 ] if inBound( $y - 1, $x - 1 );

    # say $matrix[ $y - 1 ][ $x - 1 ];

    $sum += $matrix[ $y + 1 ][$x] if inBound( $y + 1, $x );

    # say $matrix[ $y + 1 ][$x];

    $sum += $matrix[ $y - 1 ][$x] if inBound( $y - 1, $x );

    # say $matrix[ $y - 1 ][$x];

    # say "$x, $y => $sum";

    return $sum;
}

sub checkNum {
    my ( $currentNum, $x, $y ) = @_;
    if ( $currentNum > $input ) {
        say "Answer is: $currentNum";
        exit 0;
    }
}

sub inBound {
    my ( $y, $x ) = @_;

    if ( $x >= 0 && $y >= 0 && $x <= $size - 1 && $y <= $size - 1 ) {
        return 1;
    }
    return 0;
}
