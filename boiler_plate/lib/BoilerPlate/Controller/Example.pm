package BoilerPlate::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';
use DDP;

=encoding utf-8

=head1 NAME

BoilerPlate::Controller::Example

=head1 DESCRIPTION

Controller example

Standart methods
list - list objects
load - one object
add - add object
update - update object
delete - delete object

=cut

sub welcome {
  my $c = shift;
  my $perl_ver = `perl -v`;
  my $users = $c->model('User')->list();
  # можно указать имя шаблона и предварительно передать все в stash
  # $c->stash (news_list => $news_list );
  # $c->render('inc/front/news_block');
  # либо использовать шаблон по умолчанию
  # который соответсвует пути: ./templates/имя_класса_контроллера/метод_контроллера.html.ep
  # в примере будет использоваться шаблон ./templates/example/welcome.html.ep
  $c->render(
    msg => 'Welcome to the Mojolicious real-time web framework!',
    ver => $perl_ver,
    users => $users,
    );
}

1;
