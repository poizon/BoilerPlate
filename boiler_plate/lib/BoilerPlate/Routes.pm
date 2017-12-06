package BoilerPlate::Routes;

=encoding utf-8

=head1 NAME

BoilerPlate::Routes

=head1 DESCRIPTION

Class for routes description

REST API standarts:

GET — get resourse(s)
POST — add resourse
PUT — update resourse
DELETE — delete resourse

=cut

sub collect {
  my ($self, $r) = @_;

  $r->get('/')->to('example#welcome');
  $r->get('/goods')->to('goods#list');

  # auth area
  my $auth = $r->under( sub {
    my $self = shift;
    return $self->check_acl;
  });

  # auth routes
  $auth->post( '/goods/import' )->to('goods#goods_import');

  # $r->get('/')->to('#index');
  # $r->get( '/:id' => [ id => qr/\d+/ ] )->to('#single');
  # $r->post('/')->to('#create');
  # $r->put( '/:id' => [ id => qr/\d+/ ] )->to('#update');
  # $r->delete( '/:id' => [ id => qr/\d+/ ] )->to('#delete');

}

1;