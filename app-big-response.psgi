my $buffer;
{
    local $/;
    open my $fh, "<", "./lg-hayes.jpg" or die "Couldn't open lg-hayes.jpg";
    $buffer = <$fh>;
}

my $app = sub {
    my $env = shift;
    return [
        200,
        ['Content-Type', 'image/jpeg'],
        [$buffer]
    ];
};
