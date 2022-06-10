package Lily::Network;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub network {
    my $self = shift;

    $self->app->log->debug("Lily::Network sub network");

    $self->helperGetHomepageStash('network');

    $self->render();
}

1;
