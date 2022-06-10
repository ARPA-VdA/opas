package Lily::Analyser;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub analyser_app {
    my $self = shift;

    $self->app->log->debug("Lily::analyser_app");

    $self->helperGetHomepageStash('analyser_app');

    $self->render();
}

sub analyser_settings {
    my $self = shift;

    $self->app->log->debug("Lily::analyser_settings");

    $self->helperGetHomepageStash('analyser_settings');

    $self->render();
}

1;
