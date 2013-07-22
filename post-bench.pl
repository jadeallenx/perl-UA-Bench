#!/usr/bin/env perl

use 5.018;

use Benchmark qw(:all);
use LWP::UserAgent;
use Furl;
use Mojo::UserAgent;
use HTTP::Tiny;
use LWP::Curl;

my $lwp = LWP::UserAgent->new();
my $furl = Furl->new();
my $mojo = Mojo::UserAgent->new();
my $tiny = HTTP::Tiny->new();
my $curl = LWP::Curl->new();

my %post_data = (
    foo => "bar",
    qux => 1,
    23 => "skidoo",
);

my %tests = (
    lwp => sub {
        $lwp->post('http://localhost:5000', \%post_data) or die;
    },

    furl => sub {
        $furl->post('http://localhost:5000', [], \%post_data) or die;
    }, 

    mojo => sub {
        $mojo->post('http://localhost:5000' => form => \%post_data) or die;
    },

    tiny => sub {
        $tiny->post_form('http://localhost:5000', \%post_data) or die;
    },

    curl => sub {
        $curl->post('http://localhost:5000', \%post_data) or die;
    },
);

cmpthese(50000, \%tests);
