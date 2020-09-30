#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use File::Spec;

if (0 == scalar @ARGV) {
    printf "usage: $0 install\n";
    exit 1;
}

my $ln_settings = {
    'tmux/conf'  => "$ENV{HOME}/.tmux.conf",
    'vim/vimrc'  => "$ENV{HOME}/.vimrc",
    'git/config' => "$ENV{HOME}/.gitconfig",
    'tig/tigrc'  => "$ENV{HOME}/.tigrc",
};

my @mkdirs = (
    "$ENV{HOME}/.vim",
    "$ENV{HOME}/.vim/backup/",
    "$ENV{HOME}/.vim/swap/",
    "$ENV{HOME}/.vim/undo/",
);

if ($ARGV[0] eq "install") {
    foreach my $key (keys %{$ln_settings}) {
        if (-e $ln_settings->{$key}) {
            printf "skip ln %s\n", $ln_settings->{$key};
        } else {
            ln($key, $ln_settings->{$key});
        } 
    }

    foreach my $dir (@mkdirs) {
        if (-e $dir) {
            printf "skip mkdir %s\n", $dir;
        } else {
            printf "mkdir %s\n", $dir;
            mkdir $dir or die $!;
        } 
    }



}

sub ln {
    my ($src, $dst) = @_;
    $src = File::Spec->rel2abs($src);
    $dst = File::Spec->rel2abs($dst);

    printf "%s\n", join ' ', 'ln', '-s', $src, $dst;
    symlink $src, $dst;
}
