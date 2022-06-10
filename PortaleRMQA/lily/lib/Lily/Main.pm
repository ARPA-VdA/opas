package Lily::Main;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub index {
    my $self = shift;

    $self->app->log->debug("Lily::Main sub index");

    my $settings_homepage = $self->helperGetHomepageStash('');

    my $grid = $self->session('lily.app.ecometer')->{'gr_id'};
    $self->app->log->debug("grid: $grid");

    if ( $grid == 201 ) {
        $self->render( template => 'main/index_orion' );
        return 1;
    }
    if ( $grid == 202 ) {
        $self->render( template => 'main/index_iar' );
        return 1;
    }
    if ( $grid == 203 ) {
        $self->render( template => 'main/index_geie' );
        return 1;
    }

    if ( $grid == 302 ) {
        $self->render( template => 'main/index_lab' );
        return 1;
    }
    if ( $grid == 303 ) {
        $self->render( template => 'main/index_cc' );
        return 1;
    }
    if ( $grid == 304 ) {
        $self->render( template => 'main/index_as' );
        return 1;
    }

    my @rows;
    if ( $settings_homepage->{'row1_on'} eq 'true' ) { push( @rows, 'row1' ); }
    if ( $settings_homepage->{'row2_on'} eq 'true' ) { push( @rows, 'row2' ); }
    if ( $settings_homepage->{'row3_on'} eq 'true' ) { push( @rows, 'row3' ); }
    if ( $settings_homepage->{'row4_on'} eq 'true' ) { push( @rows, 'row4' ); }
    if ( $settings_homepage->{'row5_on'} eq 'true' ) { push( @rows, 'row5' ); }

    if ( grep( /row1/, @rows ) ) {

        my $station_status = $self->databasestations->getStationStatus();
        $self->stash( station_status => $station_status );

        my $station_alarms = $self->databaseutils->getStationAlarms();
        $self->stash( station_alarms => $station_alarms );

    }

    if ( grep( /row2/, @rows ) ) {

        my $homepage_counters = $self->databaseutils->getHomepageCounters(
            $self->session('lily.app.ecometer') );
        $self->stash( homepage_counters => $homepage_counters );

        my $report_surveys = $self->databaseutils->getReportSurveys(4);
        $self->stash( report_surveys => $report_surveys );

        my $report_calibrations = $self->databaseutils->getReportCalibrations();
        $self->stash( report_calibrations => $report_calibrations );

        my $report_maintenances = $self->databaseutils->getReportMaintenances();
        $self->stash( report_maintenances => $report_maintenances );
    }

    if ( grep( /row3/, @rows ) ) {

        my $data_pm10_stats = $self->databaseutils->getParametersStatsPm10();
        $self->stash( data_pm10_stats => $data_pm10_stats );

        my $data_no2_stats = $self->databaseutils->getParametersStatsNo2();
        $self->stash( data_no2_stats => $data_no2_stats );

        my $data_o3_stats = $self->databaseutils->getParametersStatsO3();
        $self->stash( data_o3_stats => $data_o3_stats );

        my $data_o3_180_stats =
          $self->databaseutils->getParametersStatsO3_180();
        $self->stash( data_o3_180_stats => $data_o3_180_stats );
    }

    if ( grep( /row4/, @rows ) ) {

        my $report_tasks = $self->databaseutils->getTasks();
        $self->stash( report_tasks => $report_tasks );

        my $report_memos = $self->databaseutils->getReportMemos(4);
        $self->helperDumper($report_memos);
        $self->stash( report_memos => $report_memos );

    }

    if ( grep( /row5/, @rows ) ) {

        my $data_tank_status = $self->databaseutils->getTankStatus();
        $self->stash( data_tank_status => $data_tank_status );

        my $data_filters_status = $self->databaseutils->getFiltersStatus();
        $self->stash( data_filters_status => $data_filters_status );
    }

    $self->render();
}

sub settings {
    my $self = shift;

    $self->app->log->debug("Lily::Main sub settings");

    $self->helperGetHomepageStash('settings');

    $self->render();
}

sub tutorial {
    my $self = shift;

    $self->app->log->debug("Lily::Main sub tutorial");

    $self->helperGetHomepageStash('tutorial');

    $self->render();
}

sub settings_homepage {
    my $self = shift;

    $self->app->log->debug("Lily::Main sub settings_homepage");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'settings_homepage', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $array_pos   = $params->{'array_pos[]'};
    my $array_onoff = $params->{'array_onoff[]'};

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};

    my $res = $self->databaseutils->setStettings_Homepage( $usid, $array_pos,
        $array_onoff );

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub settings_homepage_reset {
    my $self = shift;

    $self->app->log->debug("Lily::Main sub settings_homepage_reset");

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};

    my $res = $self->databaseutils->resetStettings_Homepage($usid);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub settings_psw {
    my $self = shift;

    $self->app->log->debug("Lily::Main sub settings_psw");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'settings_psw', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};

    my $res = $self->databaseutils->setStettings_Pwd( $usid, $params );

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Password aggiornata correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc =>
"Errore durante l\'aggiornamento della password o vecchia password errata."
        };
    }

    $self->render( json => $json );
}

sub websocket {
    my $self = shift;

    $self->app->log->debug("Ibex::Main sub websocket - WebSocket opened");

    Mojo::IOLoop->stream( $self->tx->connection )->timeout(300);

    $self->on(
        message => sub {
            my ( $self, $msg ) = @_;
            $self->app->log->debug(
                sprintf(
                    'User: %s, Msg: %s',
                    $self->session('lily.app.ecometer')->{'us_id'}, $msg
                )
            );

            $self->helperUpdateLastOnline(
                $self->session('lily.app.ecometer') );

        }
    );

    $self->on(
        finish => sub {
            my ( $self, $code, $reason ) = @_;
            $self->app->log->debug("WebSocket closed with status $code.");
        }
    );
}

1;
