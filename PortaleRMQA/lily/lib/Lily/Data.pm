package Lily::Data;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub data_validation {
    my $self = shift;

    $self->app->log->debug("Lily::Data sub data_validation");

    $self->helperGetHomepageStash('data_validation');

    $self->render( template => 'data/validation' );
}

sub stats_calculation {
    my $self = shift;

    $self->app->log->debug("Lily::Data sub stats_calculation");

    $self->helperGetHomepageStash('stats_calculation');

    $self->render( template => 'data/stats_calculation' );
}

sub stats_description {
    my $self = shift;

    $self->app->log->debug("Lily::Data sub stats_description");

    $self->helperGetHomepageStash('stats_description');

    $self->render( template => 'data/stats_description' );
}

sub stats_limits {
    my $self = shift;

    $self->app->log->debug("Lily::Data sub stats_limits");

    $self->helperGetHomepageStash('stats_limits');

    $self->render( template => 'data/stats_limits' );
}

sub stats_parameter {
    my $self = shift;

    $self->app->log->debug("Lily::Data sub stats_parameter");

    $self->helperGetHomepageStash('stats_parameter');

    $self->render( template => 'data/stats_parameter' );
}

1;
