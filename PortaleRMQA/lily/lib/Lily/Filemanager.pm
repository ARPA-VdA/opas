package Lily::Filemanager;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub file_manager {
    my $self = shift;

    $self->app->log->debug("Lily::file_manager");

    $self->helperGetHomepageStash('file_manager');

    $self->render();
}

1;
