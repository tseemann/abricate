package Abricate::DB;

use base Exporter;
@EXPORT_OK = qw(method);

#----------------------------------------------------------------------

sub method {
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

