package BoilerPlate::Plugin::Helpers;
use Mojo::Base 'Mojolicious::Plugin';
use BoilerPlate::Model::Load;
# or use Cache::Memcached::Fast at highload case :)
use Cache::Memcached;
# alias for Data::Printer, good choice for dump variables
use DDP;

sub register {
  my ($plugin, $app) = @_;

  state $model = BoilerPlate::Model::Load->new( app  => $app );

  state $memcached = Cache::Memcached->new($app->config->{memcached}) || die "$!";

  $app->helper( model => sub {
                  my ($self, $model_name) = @_;
                  return $model->get_model($model_name);
                }
              );

  $app->helper( memd => sub { return $memcached });

  # get IP
  $app->helper( get_ip =>
    sub {
      my $self = shift;
      my $remote_ip = $self->req->headers->header('X-Real-IP')
              || $self->req->headers->header('X-Forwarded-For')
              || $self->tx->original_remote_address
              || $self->tx->remote_address;
      return $remote_ip;
    }
    );

  # example for check access
  $app->helper( check_acl  =>
   sub {
        my $self = shift;
        # my $role = $self->session('role');
        my $key = $self->param('key');
        $self->app->log->debug('Get key: ' . $key ) if $key;
        # auth success
        return 1 if $key;
        # not auth
        $self->render(status => 403, text => 'Forbidden!');
        return 0;

        # on this you can add some logic for check access rights
        # say "============= endpoint name ====================";
        # say $self->match->endpoint->name;
        # say "============= path name ====================";
        # say $self->match->path_for->{path};
        # say "============= endpoint action ====================";
        # say $self->match->stack->[-1]{action};
        # say "============= endpoint controller ====================";
        # say $self->match->stack->[-1]{controller};
      }
  );

}

1;
