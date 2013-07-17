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

my %tests = (
    lwp => sub {
        $lwp->get('http://localhost:5000') or die;
    },

    furl => sub {
        $furl->get('http://localhost:5000') or die;
    }, 

    mojo => sub {
        $mojo->get('http://localhost:5000') or die;
    },

    tiny => sub {
        $tiny->get('http://localhost:5000') or die;
    },

    curl => sub {
        $curl->get('http://localhost:5000') or die;
    },
);

cmpthese(50000, \%tests);
