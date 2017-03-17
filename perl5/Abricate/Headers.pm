package Abricate::Headers;

use base Exporter;
@EXPORT_OK = qw(hash_encode hash_decode);

our $SEP1 = '~~';
our $SEP2 = '==';
our $NULL = '<undef>';

#----------------------------------------------------------------------

sub hash_encode {
  my($h) = @_;
  my @pair;
  for my $k (keys %{$h}) {
    my $v = $h->{$k};
    $v = $NULL if not defined $v;
    $v =~ s/\p{PosixCntrl}/?/g;
    $v =~ s/($SEP1|$SEP2)/??/g;
    push @pair, join($SEP2, $k, $v);
  }
  return join($SEP1, @pair);
}

#----------------------------------------------------------------------

sub hash_decode {
  my($s) = @_;
  my $h;
  my @kv = split $SEP1, $s;
  for my $kv (@kv) {
    my($k,$v) = split $SEP2, $kv;
    $v = undef if $v eq $NULL;
    $h->{$k} = $v;
  }
  return $h;
}
 
#----------------------------------------------------------------------

1;

