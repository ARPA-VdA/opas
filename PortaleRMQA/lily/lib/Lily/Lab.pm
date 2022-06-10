package Lily::Lab;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub man_statroam_list {
    my $self = shift;

    $self->app->log->debug("Lily::Lab sub man_statroam_list");

    $self->helperGetHomepageStash('man_statroam_list');

    my $stations = $self->databaseutils->getStationsList();
    $self->stash( stations => $stations );

    $self->render( template => 'management/man_statroam_list' );
}

sub man_statroam_match {
    my $self = shift;

    $self->app->log->debug("Lily::Lab sub man_statroam_match");

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -180 );
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $statroams =
      $self->databaseutils->getStatroamsListByDates( $date_from, $date_to );
    $self->stash( statroams => $statroams );

    my $mobstations = $self->databaseutils->getMobStations();
    $self->stash( mobstations => $mobstations );

    my $matchstations = $self->databaseutils->getMatchStations();
    $self->stash( matchstations => $matchstations );

    $self->helperGetHomepageStash('man_statroam_match');

    $self->render( template => 'management/man_statroam_match' );
}

sub man_statroam_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_statroam_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_statroam_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editStation($params);
    if ($res) {
    }
    else {
    }

    $self->helperGetHomepageStash('man_statroam_list');

    $self->man_statroam_list();
}

sub man_statroam_get {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_statroam_get");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    my $stat = $self->databaseutils->getStationByStId($id);

    my $json = {
        res  => 'OK',
        stat => $stat
    };

    $self->render( json => $json );
}

sub man_statroam_match_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_statroam_match_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_statroam_match_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewStatroamMatch($params);
    if ($res) {
        $self->flash( message => 'Stanziamento staz. mobile riuscito' );
    }
    else {
        $self->flash(
            message => "Errore durante l'inserimento dello stanziamento" );
    }

    my $url = $self->url_for("/man_statroam_match");
    $self->redirect_to($url);
}

sub man_statroam_match_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_statroam_match_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'man_statroam_match_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editStatroamMatch($params);
    if ($res) {
        $self->flash( message => 'Stanziamento staz. mobile modificato' );
    }
    else {
        $self->flash( message =>
              'Errore durante la modifica dello stanziamento  staz. mobile' );
    }

    my $url = $self->url_for("/man_statroam_match");
    $self->redirect_to($url);
}

sub man_statroam_match_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_statroam_match_delete");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteStatroamMatch($rpid) ) {
        $self->app->log->debug('Result: OK');
        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_statroam_get_match {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_statroam_get_match");

    my $stid = $self->param('id');
    $self->app->log->debug("stid: $stid");

    my $match = $self->databaseutils->getStatroamMatchListByStInId($stid);

    my $json = {
        res   => 'OK',
        match => $match
    };

    $self->render( json => $json );
}

1;
