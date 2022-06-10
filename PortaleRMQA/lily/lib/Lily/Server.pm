package Lily::Server;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub server_hardware {
    my $self = shift;

    $self->app->log->debug("Lily::Server sub server_hardware");

    $self->helperGetHomepageStash('server_hardware');

    $self->render( template => 'server/hardware' );
}

sub server_logical {
    my $self = shift;

    $self->app->log->debug("Lily::Server sub server_logical");

    $self->helperGetHomepageStash('server_logical');

    $self->render( template => 'server/logical' );
}

1;
