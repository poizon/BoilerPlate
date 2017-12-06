package BoilerPlate::Model::Objects::User;

use Mojo::Base '-base';
use DBIx::Struct qw(hash_ref_slice);
use DDP;

=encoding utf-8

=head1 NAME

BoilerPlate::Model::Objects::User

=head1 DESCRIPTION

Model example

Standart methods
list - list objects
load - one object
add - add object
update - update object
delete - delete object

=cut


sub list {
  my ($self, $params) = @_;
  my $result = all_rows(["mp_users" =>
                        -columns => [qw(id email)]],
                        sub { $_->data }
                        );
  return $result;
}

1;
