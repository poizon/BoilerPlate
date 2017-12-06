package BoilerPlate::Controller::Goods;
use Mojo::Base 'Mojolicious::Controller';
use DDP;# для удобной и информативной оттладки, достаточно сказать p $var и увидим в терминале

=encoding utf-8

=head1 NAME

BoilerPlate::Controller::Example

=head1 DESCRIPTION

Пример контроллера

Стандартные методы контроллера
list - список объектов
load - один объект
add - добавление объекта
update - обновление объекта
delete - удаление объекта - если реализовано

=cut

sub list {
  my $c = shift;
  my $perl_ver = `perl -v`;
  # пример работы с memcached
  my $users = $c->memd->get("users");

  if ($users)
  {
    $c->app->log->debug('Get from memcached');
  }
  else
  {
    $users = $c->model('User')->list();
    $c->memd->set("users", $users );
  }

  # пример отдачи контента в зависимости от запроса
  $c->respond_to( html => { msg => 'html!'},
                  json => { json => { users => $users } } );
}

=head2 goods_import()

Импорт товаров из магазинов на платформе S2U
Предлагается вариант с получением файла данных в json
упакованный в gzip.
Далее при успешном получении файла и постановкой в очередь - отвечаем status => OK
Очереди предлагается реализовать на Minion с mysql бэкэндом

=cut
sub goods_import {
  my $c = shift;

  my $file = $c->req->upload('import_file');

  if( $file and $file->size > 0 )
  {
    # сохраняем файл
    $file->move_to( $c->app->config('import_path') . $file->filename );
    # пример записи в лог
    $c->app->log->info("Get file from server: " . $c->get_ip );
    # добавляем задачу в очередь
    $c->minion->enqueue( parse_file => [ $file->filename ] );
    # отвечаем все ОК
    $c->render(json => { status => 'OK' } );
  }
  else
  {
    # для тестов
    $c->minion->enqueue( parse_file => [ 'no file' ] );
    $c->render(status => 404, json => { status => 'Bad request!' } );
  }
}

1;
