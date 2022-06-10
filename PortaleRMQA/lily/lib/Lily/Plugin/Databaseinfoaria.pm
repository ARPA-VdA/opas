package Lily::Plugin::Databaseinfoaria;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databaseinfoaria :: register()');

    $self->app($app);

    $app->helper(
        databaseinfoaria => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub getTry {
    my ($self) = @_;

    $self->app->log->debug("sub getTry");

    my $sql = qq{
        SELECT
            pa_id, name, surname
        FROM
            tool_web_lily.participants
        ORDER BY
            pa_id;
    };

    return $self->app->database->database_query_records($sql);
}

1;
