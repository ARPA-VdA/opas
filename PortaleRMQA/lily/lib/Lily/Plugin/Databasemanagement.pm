package Lily::Plugin::Databasemanagement;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databasemanagement :: register()');

    $self->app($app);

    $app->helper(
        databasemanagement => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

1;
