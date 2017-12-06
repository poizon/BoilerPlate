package BoilerPlate::Plugin::Tasks;
use Mojo::Base 'Mojolicious::Plugin';
use DDP;

=encoding utf-8

=head1 NAME

BoilerPlate::Plugin::Tasks

=head1 DESCRIPTION

Class for minion jobs

In controller for add job:

$c->minion->enqueue(parse_file => [$file_id] );

This jobs will be done with standalone worker process


=cut


sub register {
  my ($plugin, $app) = @_;

  # Logic is here
  $app->minion->add_task( parse_file =>
    sub {
      my ($job, $file) = @_;
      $job->app->log->info('FILE: ' . $file);
    }
  )

}

1;
