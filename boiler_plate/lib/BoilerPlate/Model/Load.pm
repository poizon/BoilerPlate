package BoilerPlate::Model::Load;

use Mojo::Loader qw(find_modules load_class);
use Mojo::Base '-base';
use Carp qw/ croak /;

has 'app';
has modules => sub { {} };

=encoding utf-8

=head1 NAME

BoilerPlate::Model::Load

=head1 DESCRIPTION

Класс для загрузки моделей

=cut


=head2

Загружаем все модели из папки Objects

=cut
sub new {
  my ($class, %args) = @_;
  my $self = $class->SUPER::new(%args);

  for my $module ( find_modules 'BoilerPlate::Model::Objects' ) {
      my $e = load_class $module;
      croak qq{Loading "$module" failed: $e} and next if ref $e;
      my ($basename) = $module =~ /BoilerPlate::Model::Objects::(.*)/;
      $self->modules->{ $basename } = $module->new(%args);
  }

  return bless $self,$class;
}

=head2

Получаем объект модели

=cut
sub get_model {
  my ( $self, $model ) = @_;
  return $self->modules->{$model} || croak "Unknown model '$model'";
}

1;