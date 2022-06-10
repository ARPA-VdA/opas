package Lily::Allocation;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Text::CSV::Encoded;

sub man_allocation_list {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_list");

    $self->helperGetHomepageStash('man_allocation_list');

    my $equipments = $self->databaseutils->getEquipmentsList();
    $self->stash( equipments => $equipments );

    $self->render( template => 'management/man_allocation_list' );
}

sub man_allocation_match {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_match");

    $self->helperGetHomepageStash('man_allocation_match');

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

    my $equipments = $self->databaseutils->getEquipmentsList();
    $self->stash( equipments => $equipments );

    my $workstations = $self->databaseutils->getWorkstations();
    $self->stash( workstations => $workstations );

    my $equipments_matches =
      $self->databaseutils->getEquipmentsMatchesByDates( $date_from, $date_to );
    $self->stash( equipments_matches => $equipments_matches );

    $self->render( template => 'management/man_allocation_list_match' );
}

sub man_allocation_get_equipment {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_get_equipment");

    my $eqid = $self->param('id');
    $self->app->log->debug("eqid: $eqid");

    my $equipment = $self->databaseutils->getEquipmentById($eqid);
    $self->helperDumper($equipment);

    my $json = {
        res       => 'OK',
        equipment => $equipment
    };

    $self->render( json => $json );
}

sub man_allocation_new_equipment {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_new_equipment");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'man_allocation_new_equipment', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewEquipment($params);
    if ($res) {
        $self->app->log->debug(
            "man_allocation_new_equipment insert into db OK");
    }
    else {
        $self->app->log->debug(
            "man_allocation_new_equipment insert into db ERROR");
    }

    $self->redirect_to('man_allocation_list');
}

sub man_allocation_edit_equipment {
    my $self = shift;

    $self->app->log->debug(
        "Lily::Allocation sub man_allocation_edit_equipment");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'man_allocation_edit_equipment', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editEquipment($params);
    if ($res) {
        $self->app->log->debug(
            "man_allocation_edit_equipment insert into db OK");
    }
    else {
        $self->app->log->debug(
            "man_allocation_edit_equipment insert into db ERROR");
    }

    $self->redirect_to('man_allocation_list');
}

sub man_allocation_delete_equipment {
    my $self = shift;

    $self->app->log->debug(
        "Lily::Allocation sub man_allocation_delete_equipment");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Delete equipment from db');
    if ( $self->databaseutils->deleteEquipmentById($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_allocation_arpa_id {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_arpa_id");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('verify id from db');
    if ( $self->databaseutils->verifyEquipmentArpaId($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_allocation_csv {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_csv");

    my $file_tag = $self->helperGetDateNoTime();

    my $csv = Text::CSV::Encoded->new(
        {
        }
    );

    $self->app->log->debug("Opening csv file ...");

    my $content = '';
    open my $fh, '>>', \$content;

    print $fh "sep=;\n";
    print $fh "ID;Arpa Id;Dotazione";
    print $fh "\n";

    my $report_calibrations = $self->databaseutils->getEquipmentsList_Csv();

    foreach my $report ( @{$report_calibrations} ) {
        print $fh ( $report->{'eq_id'} || '' ) . ';';
        print $fh escape_csv( $report->{'arpa_id'} ) . ';';
        print $fh escape_csv( $report->{'equipment'} );
        print $fh "\n";
    }

    my $headers  = $self->res->headers;
    my $filename = "report_dotazioni-$file_tag.csv";
    $headers->content_disposition( 'attachment; filename=' . $filename );
    $headers->content_type('text/plain; charset=ansi-1252;');

    $self->app->log->debug("Sending data file ...");
    return $self->render( data => $content );
}

sub man_allocation_get_match {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub tank_match_get_report");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    my $match = $self->databaseutils->getAllocationMatchById($id);

    my $json = {
        res   => 'OK',
        match => $match
    };

    $self->render( json => $json );
}

sub man_allocation_match_new {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_match_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'man_allocation_match_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewAllocationMatch($params);
    if ($res) {
    }
    else {
    }

    $self->redirect_to('man_allocation_match');
}

sub man_allocation_match_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_match_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'man_allocation_match_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editNewAllocationMatch($params);
    if ($res) {
    }
    else {
    }

    $self->redirect_to('man_allocation_match');
}

sub man_allocation_match_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_match_delete");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteAllocationMatch($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_allocation_match_csv {
    my $self = shift;

    $self->app->log->debug("Lily::Allocation sub man_allocation_match_csv");

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
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $file_tag = $self->helperGetDateNoTime();

    my $csv = Text::CSV::Encoded->new(
        {
        }
    );

    $self->app->log->debug("Opening csv file ...");

    my $content = '';
    open my $fh, '>>', \$content;

    print $fh "sep=;\n";
    print $fh
"Dotazione Id;Arpa Id;Dotazione;Data inizio;Data fine;Note;Stazione;Durata";
    print $fh "\n";

    my $report_calibrations =
      $self->databaseutils->getEquipmentsMatchesList_Csv( $date_from,
        $date_to );

    foreach my $report ( @{$report_calibrations} ) {
        print $fh ( $report->{'eq_id'} || '' ) . ';';
        print $fh escape_csv( $report->{'arpa_id'} ) . ';';
        print $fh escape_csv( $report->{'equipment'} ) . ';';
        print $fh escape_csv( $report->{'date_start'} ) . ';';
        print $fh escape_csv( $report->{'date_end'} ) . ';';
        print $fh escape_csv( $report->{'note'} ) . ';';
        print $fh escape_csv( $report->{'station'} ) . ';';
        print $fh escape_csv( $report->{'equipment'} );
        print $fh "\n";
    }

    my $headers  = $self->res->headers;
    my $filename = "report_dotazioni-$file_tag.csv";
    $headers->content_disposition( 'attachment; filename=' . $filename );
    $headers->content_type('text/plain; charset=ansi-1252;');

    $self->app->log->debug("Sending data file ...");
    return $self->render( data => $content );
}

sub escape_csv {
    my $field = shift;
    return "" unless defined $field;
    $field =~ s|"|'|g;
    return '"' . $field . '"';
}

1
