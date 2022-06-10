package Lily::Instrument;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub instrument_control {
    my $self = shift;

    $self->app->log->debug("Lily::Instrument sub instrument_control");

    $self->helperGetHomepageStash('instrument_control');

    $self->render( template => 'instrument/instrument_control' );
}

sub instrument_excess {
    my $self = shift;

    $self->app->log->debug("Lily::Instrument sub instrument_excess");

    $self->helperGetHomepageStash('instrument_excess');

    $self->render( template => 'instrument/instrument_excess' );
}

sub instrument_mapper {
    my $self = shift;

    $self->app->log->debug("Lily::Instrument sub instrument_mapper");

    $self->helperGetHomepageStash('instrument_mapper');

    $self->render( template => 'instrument/instrument_mapper' );
}

sub instrument_techroom {
    my $self = shift;

    $self->app->log->debug("Lily::Instrument sub instrument_techroom");

    $self->helperGetHomepageStash('instrument_techroom');

    $self->render( template => 'instrument/instrument_techroom' );
}

sub instrument_pollutants {
    my $self = shift;

    $self->app->log->debug("Lily::Instrument sub instrument_pollutants");

    $self->helperGetHomepageStash('instrument_pollutants');

    $self->render( template => 'instrument/instrument_pollutants' );
}

1;
