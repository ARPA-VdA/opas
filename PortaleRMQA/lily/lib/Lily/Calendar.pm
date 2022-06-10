package Lily::Calendar;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub calendar {
    my $self = shift;

    $self->app->log->debug("Lily::Calendar sub calendar");

    $self->helperGetHomepageStash('calendar');

    $self->render();
}

1;
