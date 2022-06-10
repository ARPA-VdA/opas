package Lily::Tool;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub man_instrument_list {
    my $self = shift;

    $self->app->log->debug("Lily::Tool sub man_instrument_list");

    $self->helperGetHomepageStash('man_instrument_list');

    my $ins_types = $self->databaseutils->getInstrumentTypes();
    $self->stash( ins_types => $ins_types );

    my $instruments = $self->databaseutils->getInstrumentList();
    $self->stash( instruments => $instruments );

    $self->render( template => 'management/man_instrument_list' );
}

sub man_instrument_match {
    my $self = shift;

    $self->app->log->debug("Lily::Tool sub man_instrument_match");

    $self->helperGetHomepageStash('man_instrument_match');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $date_to;
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $match =
      $self->databaseutils->getinstrumentsMatchListByDates( $date_from,
        $date_to );
    $self->stash( match => $match );

    my $workstations = $self->databaseutils->getWorkstations();
    $self->stash( workstations => $workstations );

    my $instruments = $self->databaseutils->getInstrumentList();
    $self->stash( instruments => $instruments );

    $self->render( template => 'management/man_instrument_match' );
}

sub man_instrument_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_instrument_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewInstrument($params);
    if ($res) {
        $self->flash( message => 'Strumento inserito' );
    }
    else {
        $self->flash(
            message => "Errore durante l'inserimento dello strumento" );
    }

    my $url = $self->url_for("/man_instrument_list");
    $self->redirect_to($url);
}

sub man_instrument_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_instrument_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editInstrument($params);
    if ($res) {
        $self->flash( message => 'Strumento modificato' );
    }
    else {
        $self->flash( message => 'Errore durante la modifica dello strumento' );
    }

    my $url = $self->url_for("/man_instrument_list");
    $self->redirect_to($url);
}

sub man_instrument_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_delete");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteInstrument($rpid) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_instrument_arpa_id {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_arpa_id");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('verify id from db');
    if ( $self->databaseutils->verifyIntrumentArpaId($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_instrument_get {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_get");

    my $inid = $self->param('id');
    $self->app->log->debug("inid: $inid");

    my $instrument = $self->databaseutils->getInstrumentById($inid);

    my $json = {
        res        => 'OK',
        instrument => $instrument
    };

    $self->render( json => $json );
}

sub man_instrument_match_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_match_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'man_instrument_match_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewInstrumentMatch($params);
    if ($res) {
        $self->flash( message => 'Stanziamento strumento inserito' );
    }
    else {
        $self->flash( message =>
              "Errore durante l'inserimento dello stanziamento strumento" );
    }

    my $url = $self->url_for("/man_instrument_match");
    $self->redirect_to($url);
}

sub man_instrument_match_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_match_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'man_instrument_match_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editInstrumentMatch($params);
    if ($res) {
        $self->flash( message => 'Stanziamento strumento modificato' );
    }
    else {
        $self->flash( message =>
              'Errore durante la modifica dello stanziamento strumento' );
    }

    my $url = $self->url_for("/man_instrument_match");
    $self->redirect_to($url);
}

sub man_instrument_match_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_match_delete");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteInstrumentMatch($id) ) {
        $self->app->log->debug('Result: OK');
        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_instrument_get_match {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_instrument_get_match");

    my $stid = $self->param('id');
    $self->app->log->debug("stid: $stid");

    my $match = $self->databaseutils->getinstrumentsMatchListByStInId($stid);

    my $json = {
        res   => 'OK',
        match => $match
    };

    $self->render( json => $json );
}

1;
