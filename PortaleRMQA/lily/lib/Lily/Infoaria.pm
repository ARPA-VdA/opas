package Lily::Infoaria;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub ia_home {
    my $self = shift;

    $self->app->log->debug("Lily::Infoaria sub ia_home");

    my $try = $self->databaseinfoaria->getTry();
    $self->helperDumper($try);

    $self->helperGetHomepageStash('ia_home');

    $self->render();
}

sub views_authority {
    my $self = shift;

    $self->app->log->debug("Lily::Infoaria sub views_authority");

    $self->helperGetHomepageStash('views_authority');

    $self->render();
}

sub views_networks {
    my $self = shift;

    $self->app->log->debug("Lily::Infoaria sub views_networks");

    $self->helperGetHomepageStash('views_networks');

    $self->render();
}

sub views_stations {
    my $self = shift;

    $self->app->log->debug("Lily::Infoaria sub views_stations");

    $self->helperGetHomepageStash('views_stations');

    $self->render();
}

sub views_samples {
    my $self = shift;

    $self->app->log->debug("Lily::Infoaria sub views_samples");

    $self->helperGetHomepageStash('views_samples');

    $self->render();
}

1;
