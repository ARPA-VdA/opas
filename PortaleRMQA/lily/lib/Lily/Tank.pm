package Lily::Tank;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Text::CSV::Encoded;
use File::Basename;
use Mojo::Upload;

sub man_tank_list {
    my $self = shift;

    $self->app->log->debug("Lily::Tank sub man_tank_list");

    $self->helperGetHomepageStash('man_tank_list');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -181 );
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $tanks =
      $self->databaseutils->getTankListByDates( $date_from, $date_to );
    $self->stash( tanks => $tanks );

    my $instruments = $self->databaseutils->getInstrumentCategoriesHasTank();
    $self->helperDumper($instruments);
    $self->stash( instruments => $instruments );

    $self->render( template => 'management/man_tank_list' );
}

sub tank_list_get_report {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub tank_list_get_report");

    my $cyid = $self->param('id');
    $self->app->log->debug("cyid: $cyid");

    my $tank = $self->databaseutils->getTankById($cyid);

    my $json = {
        res  => 'OK',
        tank => $tank
    };

    $self->render( json => $json );
}

sub tank_match_get_report {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub tank_match_get_report");

    my $stcyid = $self->param('id');
    $self->app->log->debug("stcyid: $stcyid");

    my $tank = $self->databaseutils->getTankLocationByStCyId($stcyid);

    my $json = {
        res  => 'OK',
        tank => $tank
    };

    $self->render( json => $json );
}

sub man_tank_match {
    my $self = shift;

    $self->app->log->debug("Lily::Tank sub man_tank_match");

    $self->helperGetHomepageStash('man_tank_match');

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
      $self->databaseutils->getTankMatchListByDates( $date_from, $date_to );
    $self->stash( match => $match );

    my $tanks = $self->databaseutils->getTankList();
    $self->stash( tanks => $tanks );

    my $workstations = $self->databaseutils->getWorkstations();
    $self->stash( workstations => $workstations );

    $self->render( template => 'management/man_tank_match' );
}

sub man_tank_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_tank_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $file_base_dir = "uploads/files/tanks";

    my $file_dir = $self->app->static->paths->[0] . '/' . $file_base_dir;

    my $attachment      = $self->req->upload('attachment');
    my $attachment_name = $self->store_image( $file_dir, $attachment );

    my $res = $self->databaseutils->insertNewTank( $attachment_name, $params );
    if ($res) {
        $self->app->log->debug("man_tank_edit insert into db OK");
    }
    else {
        $self->app->log->debug("man_tank_edit insert into db ERROR");
    }

    $self->helperGetHomepageStash('man_tank_list');

    $self->man_tank_list();

}

sub man_tank_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_tank_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $file_base_dir = "uploads/files/tanks";

    my $file_dir = $self->app->static->paths->[0] . '/' . $file_base_dir;

    my $attachment      = $self->req->upload('attachment');
    my $attachment_name = $self->store_image( $file_dir, $attachment );

    my $res = $self->databaseutils->editTank( $attachment_name, $params );
    if ($res) {
        $self->app->log->debug("man_tank_edit insert into db OK");
    }
    else {
        $self->app->log->debug("man_tank_edit insert into db ERROR");
    }

    $self->helperGetHomepageStash('man_tank_list');

    $self->man_tank_list();

}

sub store_image {
    my $self       = shift;
    my $file_dir   = shift;
    my $attachment = shift;

    if ( $attachment && $attachment->filename ne '' ) {

        unless ($attachment) {
            $self->app->log->debug("Upload fallito. File non specificato.");
            $self->redirect_to('man_tank_list');
        }

        $self->app->log->debug("Upload max size check");
        my $upload_max_size = 10 * 1024 * 1024;

        my $file_size = $attachment->size;
        if ( $file_size > $upload_max_size ) {
            $self->app->log->debug(
                "Upload fallito. Dimensione immagine troppo grande.");
            $self->redirect_to('man_tank_list');
        }

        $self->app->log->debug("File uploaded.");

        $self->app->log->debug("Check file type");
        my $image_type = $attachment->headers->content_type;
        $self->app->log->debug("image_type: $image_type");

        my %valid_types = map { $_ => 1 } qw(image/jpeg image/png);

        my %image_types = map { $_ => 1 } qw(image/jpeg image/png);
        my $is_image    = 0;
        if ( $valid_types{$image_type} ) { $is_image = 1; }
        $self->app->log->debug("File is image : $is_image");

        my $file_name_original = lc( $attachment->filename );
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
        $attachment->move_to($full_file_name);

        return $file_name;

    }
}

sub man_tank_match_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_match_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_tank_match_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->insertNewTankMatch($params);
    if ($res) {
    }
    else {
    }

    $self->helperGetHomepageStash('man_tank_match');

    $self->man_tank_match();

}

sub man_tank_match_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_match_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'man_tank_match_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaseutils->editTankMatch($params);
    if ($res) {
    }
    else {
    }

    $self->helperGetHomepageStash('man_tank_match');

    $self->man_tank_match();

}

sub man_tank_csv {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_csv");

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
    print $fh
"ID;Stazione;ArpaID;Data costruzione;Data scadenza;Descrizione;Di zero;Valori;Esaurita;Restituita;Categoria;Note";
    print $fh "\n";

    my $report_calibrations =
      $self->databaseutils->getTankListByDates_Csv( $date_from, $date_to );

    foreach my $report ( @{$report_calibrations} ) {
        print $fh ( $report->{'cy_id'} || '' ) . ';';
        print $fh escape_csv( $report->{'stationname'} ) . ';';
        print $fh escape_csv( $report->{'arpa_id'} ) . ';';
        print $fh escape_csv( $report->{'date_built'} ) . ';';
        print $fh escape_csv( $report->{'date_expiry'} ) . ';';
        print $fh escape_csv( $report->{'description'} ) . ';';
        print $fh escape_csv( $report->{'is_zero'} ) . ';';
        print $fh escape_csv( $report->{'ch_values'} ) . ';';
        print $fh escape_csv( $report->{'exhausted_format'} ) . ';';
        print $fh escape_csv( $report->{'returned_format'} ) . ';';
        print $fh escape_csv( $report->{'instrument_category'} ) . ';';
        print $fh escape_csv( $report->{'note'} );
        print $fh "\n";
    }

    my $headers  = $self->res->headers;
    my $filename = "report_bombole-$file_tag.csv";
    $headers->content_disposition( 'attachment; filename=' . $filename );
    $headers->content_type('text/plain; charset=ansi-1252;');

    $self->app->log->debug("Sending data file ...");
    return $self->render( data => $content );
}

sub man_tank_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_delete");

    my $rpid = $self->param('id');
    $self->app->log->debug("rpid: $rpid");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteTank($rpid) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_tank_match_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_match_delete");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Delete report from db');
    if ( $self->databaseutils->deleteTankMatch($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub man_tank_arpa_id {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub man_tank_arpa_id");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('verify id from db');
    if ( $self->databaseutils->verifyTankArpaId($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub escape_csv {
    my $field = shift;
    return "" unless defined $field;
    $field =~ s|"|'|g;
    return '"' . $field . '"';
}
1;
