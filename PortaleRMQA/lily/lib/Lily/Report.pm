package Lily::Report;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use File::Basename;
use Text::CSV::Encoded;
use Encode qw(decode_utf8 encode_utf8);
use utf8;
use Mojo::JSON qw(decode_json encode_json);

sub report_memo {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_memo");

    $self->helperGetHomepageStash('report_memo');

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};
    $self->stash( usid => $usid );

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -59 );
    }
    $date_to = "$date_to";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $params_get = $self->req->query_params->to_hash;
    $self->helperDumper($params_get);
    my $repid = $params_get->{'id'};
    $self->app->log->debug("repid: $repid");
    $self->stash( repid => $repid );

    my $operators = $self->databaseutils->getOperators($usid);
    $self->stash( operators => $operators );

    my $participants = $self->databaseutils->getParticipants();
    $self->stash( participants => $participants );

    my $memos =
      $self->databasereports->getMemoReportsByDates( $date_from, $date_to );
    $self->stash( memos => $memos );
    $self->helperDumper($memos);

    $self->render( template => 'report/report_memo' );
}

sub report_memo_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_memo_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'report_memo_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databasereports->insertNewMemo($params);
    if ($res) {
    }
    else {
    }

    $self->report_memo();
}

sub report_memo_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_memo_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'report_memo_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databasereports->editMemo($params);
    if ($res) {
    }
    else {
    }

    $self->report_memo();
}

sub report_memo_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_memo_delete");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    $self->app->log->debug('Delete report from db');
    if ( $self->databasereports->deleteMemoReport($rpid) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub report_memo_get_report {
    my $self = shift;

    $self->app->log->debug("Lily::Report report_memo_get_report");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    my $report = $self->databasereports->getMemoReportById($id);

    my $json = {
        res    => 'OK',
        report => $report
    };

    $self->render( json => $json );
}

sub report_memo_pdf {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_memo_pdf");

    my $params = $self->req->body_params->to_hash;
    my $id     = $params->{'id'};

    if ( $id !~ /^\d+$/ ) {
        $self->render( json => { result => 'ERROR' } );
    }

    $self->app->log->debug("Generating pdf report id: $id");

    my $path = $self->app->home->rel_file('public/downloads/report_memo');
    my $pdfname  = 'verbale-' . sprintf( "%05d", $id ) . '.pdf';
    my $filename = $path . '/' . $pdfname;

    $self->app->log->debug("Generating pdf filename: $filename");

    my $script = $self->app->home->rel_file('latex/report-memo.pl');
    $self->app->log->debug("Running system: $script");
    my @cmd = ('perl');
    push @cmd, $script;
    push @cmd, $id;
    if ( $^O eq 'linux' ) {
        system(@cmd);
        system(@cmd);
    }
    else {
        system(@cmd);
    }
    if ( $? == -1 ) {
        $self->app->log->debug("command failed: $!");
        $self->redirect_to('report_memo');
    }
    else {
        $self->app->log->debug( printf "command exited with value %d",
            $? >> 8 );
    }

    $self->app->log->debug("Checking file $filename exists...");
    if ( -e $filename ) {
        $self->render_file( 'filepath' => $filename, 'filename' => $pdfname );
    }
    else {
        $self->app->log->debug("Pdf file NOT found!");
        $self->redirect_to('report_memo');
    }
}

sub report_calibration {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_calibration");

    $self->helperGetHomepageStash('report_calibration');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from         = $params->{'startDate'};
    my $date_to           = $params->{'endDate'};
    my $filter_station    = $params->{'selStation'};
    my $filter_instrument = $params->{'selInstrument'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->app->log->debug("filter_station: $filter_station");
    $self->app->log->debug("filter_instrument: $filter_instrument");

    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -6 );
    }
    $date_to = "$date_to 23:59:59";
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->stash(
        date_from         => $date_from,
        date_to           => $date_to,
        filter_station    => $filter_station,
        filter_instrument => $filter_instrument
    );

    my $params_get = $self->req->query_params->to_hash;
    $self->helperDumper($params_get);
    my $repid = $params_get->{'id'};
    $self->stash( repid => $repid );

    my $stations = $self->databaseutils->getStations();
    $self->stash( stations => $stations );

    my $instruments = $self->databaseutils->getInstrumentCategories();
    $self->stash( instruments => $instruments );

    my $grid = $self->session('lily.app.ecometer')->{'gr_id'};
    my $report_calibrations =
      $self->databaseutils->getReportCalibrationsByDatesAndFilters( $date_from,
        $date_to, $grid, $filter_station, $filter_instrument );
    $self->stash( report_calibrations => $report_calibrations );

    $self->render( template => 'report/report_calibration' );
}

sub calibration_data {
    my $self = shift;

    $self->app->log->debug("Lily::calibration_data");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'calibration_data', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $json;
    $self->app->log->debug('calibration_data');

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};

    my $operators = $self->databaseutils->getOperatorsNetcom($usid);

    my $stations = $self->databaseutils->getStations();

    my $reasons = $self->databaseutils->getReasons();

    my $methods_zero = $self->databaseutils->getMethods('zero');

    my $methods_span = $self->databaseutils->getMethods('span');

    my $calibrators = $self->databaseutils->getCalibrators();

    $json = {
        res  => 'OK',
        data => {
            operators    => $operators,
            stations     => $stations,
            reasons      => $reasons,
            methods_zero => $methods_zero,
            methods_span => $methods_span,
            calibrators  => $calibrators
        }
    };

    $self->render( json => $json );
}

sub calibration_instrument {
    my $self = shift;

    $self->app->log->debug("Lily::calibration_instrument");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'calibration_instrument', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $json;
    $self->app->log->debug('calibration_instrument');

    my $instruments = $self->databaseutils->getInstruments( $params->{'stid'} );

    my $tanks_zero =
      $self->databaseutils->getTanks( 'zero', $params->{'stid'} );

    my $tanks_span =
      $self->databaseutils->getTanks( 'span', $params->{'stid'} );

    $json = {
        res  => 'OK',
        data => {
            instruments => $instruments,
            tanks_zero  => $tanks_zero,
            tanks_span  => $tanks_span,
        }
    };

    $self->render( json => $json );
}

sub report_calibration_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_calibration_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'report_calibration_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewCalibration($params);
    if ($res) {
    }
    else {
    }

    $self->helperGetHomepageStash('report_calibration');

    $self->report_calibration();

}

sub report_calibration_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_calibration_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'report_calibration_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->updateCalibration($params);
    if ($res) {
    }
    else {
    }

    $self->helperGetHomepageStash('report_calibration');

    $self->report_calibration();
}

sub report_calibration_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_calibration_delete");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteCalibrationReport($rpid) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub report_calibration_get_report {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_calibration_get_report");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    my $report = $self->databaseutils->getCalibrationReport($rpid);

    my $json = {
        res    => 'OK',
        report => $report
    };

    $self->render( json => $json );
}

sub report_calibration_csv {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_calibration_csv");

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -6 );
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $file_tag = $date_from . "_" . $date_to;

    my $csv = Text::CSV::Encoded->new();

    $self->app->log->debug("Opening csv file ...");

    my $content = '';
    open my $fh, '>>', \$content;

    print $fh "sep=;\n";
    print $fh
"ID;Data;Operatore;Stazione;Strumento;Zero;Zero modificato;Span;Span modificato;Note";
    print $fh "\n";

    my $report_calibrations =
      $self->databaseutils->getReportCalibrationsByDatesAndFilters( $date_from,
        $date_to );

    foreach my $report ( @{$report_calibrations} ) {
        print $fh ( $report->{'ca_id'}         || '' ) . ';';
        print $fh ( $report->{'fulldate'}      || '' ) . ';';
        print $fh ( $report->{'user_fullname'} || '' ) . ';';
        print $fh ( $report->{'station_name'}  || '' ) . ';';
        print $fh ( $report->{'instrument'}    || '' ) . ';';
        print $fh ( $report->{'zero_info'}     || '' ) . ';';
        print $fh ( $report->{'zero_changed'}  || '' ) . ';';
        print $fh ( $report->{'span_info'}     || '' ) . ';';
        print $fh ( $report->{'span_changed'}  || '' ) . ';';
        print $fh escape_csv( $report->{'note'} );
        print $fh "\n";
    }

    my $headers  = $self->res->headers;
    my $filename = "report_calibrazioni-$file_tag.csv";
    $headers->content_disposition( 'attachment; filename=' . $filename );
    $headers->content_type('text/plain; charset=ansi-1252;');

    $self->app->log->debug("Sending data file ...");
    return $self->render( data => $content );
}

sub report_calibration_pdf {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_calibration_pdf");

    my $params = $self->req->body_params->to_hash;
    my $id     = $params->{'id'};

    if ( $id !~ /^\d+$/ ) {
        $self->render( json => { result => 'ERROR' } );
    }

    $self->app->log->debug("Generating pdf report id: $id");

    my $path =
      $self->app->home->rel_file('public/downloads/report_calibration');
    my $pdfname  = 'taratura-' . sprintf( "%05d", $id ) . '.pdf';
    my $filename = $path . '/' . $pdfname;

    $self->app->log->debug("Generating pdf filename: $filename");

    my $script = $self->app->home->rel_file('latex/report-calibration.pl');
    $self->app->log->debug("Running system: $script");
    my @cmd = ('perl');
    push @cmd, $script;
    push @cmd, $id;
    if ( $^O eq 'linux' ) {
        system(@cmd);
        system(@cmd);
    }
    else {
        system(@cmd);
    }
    if ( $? == -1 ) {
        $self->app->log->debug("command failed: $!");
        $self->redirect_to('report_calibration');
    }
    else {
        $self->app->log->debug( printf "command exited with value %d",
            $? >> 8 );
    }

    $self->app->log->debug("Checking file $filename exists...");
    if ( -e $filename ) {
        $self->render_file( 'filepath' => $filename, 'filename' => $pdfname );
    }
    else {
        $self->app->log->debug("Pdf file NOT found!");
        $self->redirect_to('report_calibration');
    }
}

sub report_maintenance {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_maintenance");

    $self->helperGetHomepageStash('report_maintenance');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from      = $params->{'startDate'};
    my $date_to        = $params->{'endDate'};
    my $filter_station = $params->{'selStation'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->app->log->debug("filter_station: $filter_station");

    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -6 );
    }
    $date_to = "$date_to 23:59:59";
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->stash(
        date_from      => $date_from,
        date_to        => $date_to,
        filter_station => $filter_station
    );

    my $params_get = $self->req->query_params->to_hash;
    $self->helperDumper($params_get);
    my $repid = $params_get->{'id'};
    $self->stash( repid => $repid );

    my $stations = $self->databaseutils->getStations();
    $self->stash( stations => $stations );

    my $grid = $self->session('lily.app.ecometer')->{'gr_id'};
    my $report_maintenances =
      $self->databaseutils->getReportMaintenancesByDatesAndFilters( $date_from,
        $date_to, $grid, $filter_station );
    $self->stash( report_maintenances => $report_maintenances );

    $self->render( template => 'report/report_maintenance' );
}

sub report_maintenance_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_maintenance_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'report_maintenance_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewMaintenance($params);
    if ($res) {
    }
    else {
    }

    $self->helperGetHomepageStash('report_maintenance');

    $self->report_maintenance();

}

sub maintenance_data {
    my $self = shift;

    $self->app->log->debug("Lily::maintenance_data");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'maintenance_data', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $json;
    $self->app->log->debug('maintenance_data');

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};

    my $operators = $self->databaseutils->getOperatorsNetcom($usid);

    my $stations = $self->databaseutils->getStations();

    $json = {
        res  => 'OK',
        data => {
            operators => $operators,
            stations  => $stations
        }
    };

    $self->render( json => $json );
}

sub maintenance_instrument {
    my $self = shift;

    $self->app->log->debug("Lily::maintenance_instrument");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'maintenance_instrument', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $json;
    $self->app->log->debug('maintenance_instrument');

    my $instruments = $self->databaseutils->getInstruments( $params->{'stid'} );

    $json = {
        res  => 'OK',
        data => {
            instruments => $instruments
        }
    };

    $self->render( json => $json );
}

sub maintenance_instrument_operations {
    my $self = shift;

    $self->app->log->debug("Lily::maintenance_instrument_operations");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'maintenance_instrument_operations',
        $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $json;
    $self->app->log->debug('maintenance_instrument_operations');

    my $operations =
      $self->databaseutils->getInstrumentsOperations( $params->{'arpaid'} );

    $json = {
        res  => 'OK',
        data => {
            operations => $operations
        }
    };

    $self->render( json => $json );
}

sub maintenance_instrument_spareparts {
    my $self = shift;

    $self->app->log->debug("Lily::maintenance_instrument_spareparts");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'maintenance_instrument_spareparts',
        $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $json;
    $self->app->log->debug('maintenance_instrument_spareparts');

    my $spareparts =
      $self->databaseutils->getInstrumentsSpareParts( $params->{'arpaid'} );

    $json = {
        res  => 'OK',
        data => {
            spareparts => $spareparts
        }
    };

    $self->render( json => $json );
}

sub maintenance_calibrations_latest {
    my $self = shift;

    $self->app->log->debug("Lily::maintenance_calibrations_latest");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'maintenance_calibrations_latest', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $json;
    $self->app->log->debug('maintenance_calibrations_latest');

    my $calibrations_latest =
      $self->databaseutils->getCalibrationsLatest($params);

    $json = { data => decode_utf8( encode_json($calibrations_latest) ) };

    $self->render( json => $json );
}

sub report_maintenance_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_maintenance_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'report_maintenance_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->updateMaintenance($params);
    if ($res) {
    }
    else {
    }

    $self->helperGetHomepageStash('report_maintenance');

    $self->report_maintenance();
}

sub report_maintenance_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_maintenance_delete");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteMaintenanceReport($rpid) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub report_maintenance_get_report {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_maintenance_get_report");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    my $report = $self->databaseutils->getMaintenanceReport($rpid);

    my $report_operations =
      $self->databaseutils->getMaintenanceReportOperations($rpid);

    my $report_spareparts =
      $self->databaseutils->getMaintenanceReportSpareparts($rpid);

    my $json = {
        res        => 'OK',
        report     => $report,
        operations => $report_operations,
        spareparts => $report_spareparts
    };

    $self->render( json => $json );
}

sub report_maintenance_csv {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_maintenance_csv");

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -6 );
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $file_tag = $date_from . "_" . $date_to;

    my $csv = Text::CSV::Encoded->new(
        {
        }
    );

    $self->app->log->debug("Opening csv file ...");

    my $content = '';
    open my $fh, '>>', \$content;

    print $fh "sep=;\n";
    print $fh "ID;Data;Operatore;Stazione;Note";
    print $fh "\n";

    my $report_calibrations =
      $self->databaseutils->getReportMaintenancesByDates_Csv( $date_from,
        $date_to );

    foreach my $report ( @{$report_calibrations} ) {
        print $fh ( $report->{'ma_id'}         || '' ) . ';';
        print $fh ( $report->{'fulldate'}      || '' ) . ';';
        print $fh ( $report->{'user_fullname'} || '' ) . ';';
        print $fh ( $report->{'station_name'}  || '' ) . ';';
        print $fh escape_csv( $report->{'note'} );
        print $fh "\n";
    }

    my $headers  = $self->res->headers;
    my $filename = "report_manutenzioni-$file_tag.csv";
    $headers->content_disposition( 'attachment; filename=' . $filename );
    $headers->content_type('text/plain; charset=ansi-1252;');

    $self->app->log->debug("Sending data file ...");
    return $self->render( data => $content );
}

sub report_maintenance_pdf {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_maintenance_pdf");

    my $params = $self->req->body_params->to_hash;
    my $id     = $params->{'id'};

    if ( $id !~ /^\d+$/ ) {
        $self->render( json => { result => 'ERROR' } );
    }

    $self->app->log->debug("Generating pdf report id: $id");

    my $path =
      $self->app->home->rel_file('public/downloads/report_maintenance');
    my $pdfname  = 'manutenzione-' . sprintf( "%05d", $id ) . '.pdf';
    my $filename = $path . '/' . $pdfname;

    $self->app->log->debug("Generating pdf filename: $filename");

    my $script = $self->app->home->rel_file('latex/report-maintenance.pl');
    $self->app->log->debug("Running system: $script");
    my @cmd = ('perl');
    push @cmd, $script;
    push @cmd, $id;
    if ( $^O eq 'linux' ) {
        system(@cmd);
        system(@cmd);
    }
    else {
        system(@cmd);
    }
    if ( $? == -1 ) {
        $self->app->log->debug("command failed: $!");
        $self->redirect_to('report_maintenance');
    }
    else {
        $self->app->log->debug( printf "command exited with value %d",
            $? >> 8 );
    }

    $self->app->log->debug("Checking file $filename exists...");
    if ( -e $filename ) {
        $self->render_file( 'filepath' => $filename, 'filename' => $pdfname );
    }
    else {
        $self->app->log->debug("Pdf file NOT found!");
        $self->redirect_to('report_maintenance');
    }
}

sub report_survey_new_next_id {
    my $self = shift;

    my $repid = $self->databaseutils->getSurveyNextReportId();
    $self->app->log->debug("Report global id: $repid");

    my $json = { suid => $repid };

    $self->render( json => $json );
}

sub report_survey {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey");

    $self->helperGetHomepageStash('report_survey');

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};
    $self->stash( usid => $usid );

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -59 );
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $params_get = $self->req->query_params->to_hash;
    $self->helperDumper($params_get);
    my $repid = $params_get->{'id'};
    $self->stash( repid => $repid );

    my $operators = $self->databaseutils->getOperatorsNetcom($usid);
    $self->stash( operators => $operators );

    my $report_surveys =
      $self->databaseutils->getReportSurveysByDates( $date_from, $date_to );
    $self->stash( report_surveys => $report_surveys );

    $self->render( template => 'report/report_survey' );
}

sub report_survey_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'report_survey_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewSurvey($params);
    if ($res) {
    }
    else {
    }

    $self->report_survey();

}

sub report_survey_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'report_survey_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editSurvey($params);
    if ($res) {
    }
    else {
    }

    $self->report_survey();
}

sub report_survey_new_upload_file {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey_new_upload_file");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'report_survey_new_upload_file', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $rpid      = $self->req->body_params->param('suid');
    my $rpid_file = sprintf( "%09d", $rpid );
    $self->app->log->debug("rpid_file: $rpid_file");

    my $file_base_dir = "uploads/sopralluoghi/allegati_" . $rpid_file;

    my $file_dir = $self->app->static->paths->[0] . '/' . $file_base_dir;

    $self->helperCreatePath($file_dir);

    my $image = $self->req->upload('file');

    unless ($image) {
        $self->app->log->debug("Upload fallito. File non specificato.");
        $self->render(
            json => {
                "id"    => undef,
                message => "Upload fallito. File non specificato."
            }
        );
    }

    $self->app->log->debug("Upload max size check");
    my $upload_max_size = 10 * 1024 * 1024;

    my $file_size = $image->size;
    if ( $file_size > $upload_max_size ) {
        $self->app->log->debug(
            "Upload fallito. Dimensione immagine troppo grande.");
        $self->render(
            json => {
                "id"    => undef,
                message => "Upload fallito. Dimensione immagine troppo grande."
            }
        );
    }

    $self->app->log->debug("File uploadato.");

    $self->app->log->debug("Check file type");
    my $image_type = $image->headers->content_type;
    $self->app->log->debug("image_type: $image_type");

    my %valid_types = map { $_ => 1 } qw(image/jpeg image/png);

    unless ( $valid_types{$image_type} ) {
        $self->app->log->debug("Errore tipo immagine");
        $self->render(
            json => {
                "id"    => undef,
                message => "Upload fallito. Il contenuto è errato."
            }
        );
    }

    my %image_types = map { $_ => 1 } qw(image/jpeg image/png);
    my $is_image    = 0;
    if ( $valid_types{$image_type} ) { $is_image = 1; }
    $self->app->log->debug("File is image : $is_image");

    my $file_name_original = lc( $image->filename );
    $self->app->log->debug("Original file name: $file_name_original");

    my ( $fp_name, $p_path, $p_ext ) =
      fileparse( $file_name_original, qr"\..[^.]*$" );

    my $file_name      = $self->helperFileUploadGetFileId() . "$p_ext";
    my $full_file_name = $file_dir . "/" . $file_name;

    while ( -f $full_file_name ) {
        $file_name      = $self->helperFileUploadGetFileId() . "$p_ext";
        $full_file_name = $file_dir . "/" . $file_name;
    }

    $self->app->log->debug("Save attachment to file");
    $image->move_to($full_file_name);

    $self->app->log->debug("create thumb if image");
    my $thumbnail_url = '';
    if ($is_image) {
        $self->app->log->debug("Create thumbnail");
        $self->helperImageCreateThumbanail( $file_name, $file_dir );
        $thumbnail_url = $file_base_dir . "/thumb_" . $file_name;
        $self->app->log->debug("thumbnail_url: $thumbnail_url");
    }

    my $json;
    $self->app->log->debug('Insert new file into db');
    my $atid = $self->databaseutils->insertSurveyAttachmentFiles( $rpid,
        $file_name_original, $file_name, $is_image );
    if ($atid) {

        $self->app->log->debug('Result: OK');

        $json = { "id" => $atid };

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $json = { "id" => undef, message => "Insert fallito." };
    }

    $self->app->log->debug("render back");
    $self->render( json => $json );
}

sub report_survey_new_delete_file {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey_new_delete_file");

    my $fiid = $self->param('fiid');
    $self->app->log->debug("fiid: $fiid");

    my $rpid      = $self->param('suid');
    my $rpid_file = sprintf( "%09d", $rpid );
    $self->app->log->debug("rpid_file: $rpid_file");

    $self->app->log->debug('Delete file from db');
    if ( $self->databaseutils->deleteSurveyAttachmentFiles( $rpid, $fiid ) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub report_survey_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey_delete");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteSurveyReport($rpid) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub report_survey_get_report {
    my $self = shift;

    $self->app->log->debug("Lily::Report report_survey_get_report");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    my $report = $self->databaseutils->getSurveyReport($rpid);

    my $json = {
        res    => 'OK',
        report => $report
    };

    $self->render( json => $json );
}

sub report_survey_csv {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey_csv");

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -6 );
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $file_tag = $date_from . "_" . $date_to;

    my $csv = Text::CSV::Encoded->new();

    $self->app->log->debug("Opening csv file ...");

    my $content = '';
    open my $fh, '>>', \$content;

    print $fh "sep=;\n";
    print $fh
      "ID;Località;Data;Ora inizio;Ora fine;Operatore;Note;Directory;Allegati";
    print $fh "\n";

    my $report_surveys =
      $self->databaseutils->getReportSurveysByDates( $date_from, $date_to );

    foreach my $report ( @{$report_surveys} ) {
        print $fh ( $report->{'us_id'} || '' ) . ';';
        print $fh escape_csv( $report->{'survey_place'} || '' ) . ';';
        print $fh ( $report->{'survey_date_format'}       || '' ) . ';';
        print $fh ( $report->{'survey_start_time_format'} || '' ) . ';';
        print $fh ( $report->{'survey_end_time_format'}   || '' ) . ';';
        print $fh ( $report->{'user_fullname'}            || '' ) . ';';
        print $fh escape_csv( $report->{'survey_desc'} || '' ) . ';';
        print $fh ( $report->{'path_id'} || '' ) . ';';
        print $fh escape_csv( $report->{'attachments'} || '' );
        print $fh "\n";
    }

    my $headers  = $self->res->headers;
    my $filename = "sopralluoghi-$file_tag.csv";
    $headers->content_disposition( 'attachment; filename=' . $filename );
    $headers->content_type('text/plain; charset=ansi-1252;');

    $self->app->log->debug("Sending data file ...");
    return $self->render( data => $content );
}

sub report_survey_pdf {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub report_survey_pdf");

    my $params = $self->req->body_params->to_hash;
    my $id     = $params->{'id'};

    if ( $id !~ /^\d+$/ ) {
        $self->render( json => { result => 'ERROR' } );
    }

    $self->app->log->debug("Generating pdf report id: $id");

    my $path = $self->app->home->rel_file('public/downloads/report_survey');
    my $pdfname  = 'sopralluogo-' . sprintf( "%05d", $id ) . '.pdf';
    my $filename = $path . '/' . $pdfname;

    $self->app->log->debug("Generating pdf filename: $filename");

    my $script = $self->app->home->rel_file('latex/report-survey.pl');
    $self->app->log->debug("Running system: $script");
    my @cmd = ('perl');
    push @cmd, $script;
    push @cmd, $id;
    if ( $^O eq 'linux' ) {
        system(@cmd);
        system(@cmd);
    }
    else {
        system(@cmd);
    }
    if ( $? == -1 ) {
        $self->app->log->debug("command failed: $!");
        $self->redirect_to('report_survey');
    }
    else {
        $self->app->log->debug( printf "command exited with value %d",
            $? >> 8 );
    }

    $self->app->log->debug("Checking file $filename exists...");
    if ( -e $filename ) {
        $self->render_file( 'filepath' => $filename, 'filename' => $pdfname );
    }
    else {
        $self->app->log->debug("Pdf file NOT found!");
        $self->redirect_to('report_survey');
    }
}

sub escape_csv {
    my $field = shift;
    return "" unless defined $field;
    $field =~ s|"|'|g;
    return '"' . $field . '"';
}
1;
