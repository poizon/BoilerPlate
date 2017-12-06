package BoilerPlate;

use Mojo::Base 'Mojolicious';
our $VERSION = '0.1';
$VERSION = eval $VERSION;

use DBIx::Struct;
use BoilerPlate::Routes;


sub startup {
  my $self = shift;

  my $config = $self->plugin('Config');
  # add Minion
  # as alternative backend you can use Minion::Backend::MongoDB (o rMinion::Backend::Pg )
  $self->plugin( Minion => { mysql => $config->{ minion } } );
  # Class for task perform
  $self->plugin('BoilerPlate::Plugin::Tasks');

  # DB connect. This is singleton
  DBIx::Struct::connect($config->{dsn}, $config->{db_user}, $config->{db_pass});
  #
  $self->plugin('BoilerPlate::Plugin::Helpers');
  # cookie name
  $self->sessions->cookie_name($config->{cookie_name});
  $self->secrets( $config->{secrets} );

  # some hooks
  if($self->mode eq 'development') {

    $self->log->info($self->mode . ' mode');

    $self->hook(after_dispatch  => sub {
      my $c = shift;
      # something this
      $c->res->headers->cache_control('max-age=1, no-cache');
      $c->res->headers->last_modified('Sun, 17 Aug 2008 16:27:35 GMT');
      $c->res->headers->server('Apache/2.4.9 (Unix)');
    });

  }
  # production mode
  else
  {
    $self->log->info($self->mode . ' mode');

    $self->hook(after_dispatch  => sub {
      my $c = shift;
      $c->res->headers->server('Apache/2.4.9 (Unix)');
    });
  }
  # Routers collect -
  BoilerPlate::Routes->collect( $self->routes );
}

1;
