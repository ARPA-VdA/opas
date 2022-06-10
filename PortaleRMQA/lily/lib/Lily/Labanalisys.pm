package Lily::Labanalisys;
use Mojo::Base 'Mojolicious::Controller';
use File::Basename;
use Data::Dumper;

sub labanalisys_filter {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub labanalisys_filter");

    $self->helperGetHomepageStash('labanalisys_filter');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from        = $params->{'startDate'};
    my $date_to          = $params->{'endDate'};
    my $filter_fi_id     = $params->{'selPrel'};
    my $filter_an_id     = $params->{'selAnalysis'};
    my $filter_st_id     = $params->{'selStations'};
    my $filter_spid_from = $params->{'sampleFrom'};
    my $filter_spid_to   = $params->{'sampleTo'};

    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->app->log->debug("filter_fi_id: $filter_fi_id");
    $self->app->log->debug("filter_an_id: $filter_an_id");
    $self->app->log->debug("filter_st_id: $filter_st_id");
    $self->app->log->debug("filter_spid_from: $filter_spid_from");
    $self->app->log->debug("filter_spid_to: $filter_spid_to");

    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to      = $self->helperGetDateNoTime();
        $date_from    = $self->helperDateNoTimeAddDay( $date_to, -29 );
        $filter_fi_id = -1;
        $filter_an_id = -1;
        $filter_st_id = -1;
    }
    $date_to = "$date_to 23:59:59";
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->stash(
        date_from        => $date_from,
        date_to          => $date_to,
        filter_fi_id     => $filter_fi_id,
        filter_an_id     => $filter_an_id,
        filter_st_id     => $filter_st_id,
        filter_spid_from => $filter_spid_from,
        filter_spid_to   => $filter_spid_to
    );

    my $prels = $self->databaselabanalisys->getPrels();
    $self->stash( prels => $prels );

    my $analysis = $self->databaselabanalisys->getAnalysis();
    $self->stash( analysis => $analysis );

    my $stations = $self->databaselabanalisys->getStationsSamples();
    $self->stash( stations => $stations );

    my $samples =
      $self->databaselabanalisys->getSamplesListByDatesAndFilters( $date_from,
        $date_to,          $filter_st_id, $filter_fi_id, $filter_an_id,
        $filter_spid_from, $filter_spid_to );
    $self->stash( samples => $samples );

    my $params_get = $self->req->query_params->to_hash;
    $self->helperDumper($params_get);
    my $repid = $params_get->{'id'};
    $self->stash( repid => $repid );

    $self->render( template => 'labanalisys/labanalisys_filter' );
}

sub labanalisys_sample {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub labanalisys_sample");

    $self->helperGetHomepageStash('labanalisys_sample');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from        = $params->{'startDate'};
    my $date_to          = $params->{'endDate'};
    my $filter_fi_id     = $params->{'selPrel'};
    my $filter_an_id     = $params->{'selAnalysis'};
    my $filter_st_id     = $params->{'selStations'};
    my $filter_spid_from = $params->{'sampleFrom'};
    my $filter_spid_to   = $params->{'sampleTo'};

    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->app->log->debug("filter_fi_id: $filter_fi_id");
    $self->app->log->debug("filter_an_id: $filter_an_id");
    $self->app->log->debug("filter_st_id: $filter_st_id");
    $self->app->log->debug("filter_spid_from: $filter_spid_from");
    $self->app->log->debug("filter_spid_to: $filter_spid_to");

    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to      = $self->helperGetDateNoTime();
        $date_from    = $self->helperDateNoTimeAddDay( $date_to, -29 );
        $filter_fi_id = -1;
        $filter_an_id = -1;
        $filter_st_id = -1;
    }
    $date_to = "$date_to 23:59:59";
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->stash(
        date_from        => $date_from,
        date_to          => $date_to,
        filter_fi_id     => $filter_fi_id,
        filter_an_id     => $filter_an_id,
        filter_st_id     => $filter_st_id,
        filter_spid_from => $filter_spid_from,
        filter_spid_to   => $filter_spid_to
    );

    my $prels = $self->databaselabanalisys->getPrels();
    $self->stash( prels => $prels );

    my $analysis = $self->databaselabanalisys->getAnalysis();
    $self->stash( analysis => $analysis );

    my $stations = $self->databaselabanalisys->getStationsSamples();
    $self->stash( stations => $stations );

    my $samples =
      $self->databaselabanalisys->getSamplesListByDatesAndFilters( $date_from,
        $date_to,          $filter_st_id, $filter_fi_id, $filter_an_id,
        $filter_spid_from, $filter_spid_to );
    $self->stash( samples => $samples );

    my $params_get = $self->req->query_params->to_hash;
    $self->helperDumper($params_get);
    my $repid = $params_get->{'id'};
    $self->stash( repid => $repid );

    $self->render( template => 'labanalisys/labanalisys_sample' );
}

sub labanalisys_white {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub labanalisys_white");

    $self->helperGetHomepageStash('labanalisys_white');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from    = $params->{'startDate'};
    my $date_to      = $params->{'endDate'};
    my $filter_an_id = $params->{'selAnalysis'};
    my $filter_st_id = $params->{'selStations'};

    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->app->log->debug("filter_an_id: $filter_an_id");
    $self->app->log->debug("filter_st_id: $filter_st_id");

    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to      = $self->helperGetDateNoTime();
        $date_from    = $self->helperDateNoTimeAddDay( $date_to, -174 );
        $filter_an_id = -1;
        $filter_st_id = -1;
    }
    $date_to = "$date_to 23:59:59";
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    $self->stash(
        date_from    => $date_from,
        date_to      => $date_to,
        filter_an_id => $filter_an_id,
        filter_st_id => $filter_st_id
    );

    my $prels = $self->databaselabanalisys->getPrels();
    $self->stash( prels => $prels );

    my $analysis = $self->databaselabanalisys->getAnalysisWhite();
    $self->stash( analysis => $analysis );

    my $stations = $self->databaselabanalisys->getStationsSamples();
    $self->stash( stations => $stations );

    my $whites = $self->databaselabanalisys->getDataWhite( $date_from, $date_to,
        $filter_st_id, $filter_an_id );
    $self->stash( whites => $whites );

    my $params_get = $self->req->query_params->to_hash;
    $self->helperDumper($params_get);
    my $repid = $params_get->{'id'};
    $self->stash( repid => $repid );

    $self->render( template => 'labanalisys/labanalisys_white' );
}

sub labanalisys_files {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub labanalisys_files");

    $self->helperGetHomepageStash('labanalisys_files');

    my $analisys_types = $self->databaselabanalisys->getAnalisysFilesType();
    $self->stash( analisys_types => $analisys_types );

    my $date_to   = $self->helperGetDateTime(2);
    my $date_from = $self->helperDateNoTimeAddDay( $date_to, -360 );
    my $files = $self->databaselabanalisys->getFiles( $date_from, $date_to );
    $self->stash( files => $files );

    $self->render( template => 'labanalisys/labanalisys_files' );
}

sub labanalisys_add_data {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub labanalisys_add_data");

    $self->helperGetHomepageStash('labanalisys_add_data');

    $self->render( template => 'labanalisys/labanalisys_add_data' );
}

sub labanalisys_sample_id {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub labanalisys_sample_id");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('verify id from db');
    if ( $self->databaselabanalisys->verifyLabAnalisysSampleId($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub sample_new {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub sample_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'sample_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaselabanalisys->insertNewSample($params);
    if ($res) {
        $self->flash( message => 'Campione inserito correttamente' );
    }
    else {
        $self->flash( message =>
"Errore durante l'inserimento del campione, verificare che non ne esista uno con impostazioni uguali."
        );
    }

    my $url = $self->url_for("/labanalisys_sample");
    $self->redirect_to($url);
}

sub sample_get {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub sample_get");

    my $spid = $self->param('id');
    $self->app->log->debug("spid: $spid");

    my $sample = $self->databaselabanalisys->getSampleInfoById($spid);

    my $data = $self->databaselabanalisys->getSampleDataById($spid);

    my $json = {
        res    => 'OK',
        sample => $sample,
        data   => $data
    };

    $self->render( json => $json );
}

sub sample_edit {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub sample_edit");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'sample_edit', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaselabanalisys->editSample($params);
    if ($res) {
        $self->flash( message => 'Campione modificato' );
    }
    else {
        $self->flash( message => 'Errore durante la modifica del campione' );
    }

    my $url = $self->url_for("/labanalisys_sample");
    $self->redirect_to($url);
}

sub sample_lock {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub sample_lock");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Lock sample into db');
    if ( $self->databaselabanalisys->lockSample($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub sample_delete {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub sample_delete");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Delete sample from db');
    if ( $self->databaselabanalisys->deleteSample($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub sample_locked {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub sample_locked");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Lock sample from db');
    if ( $self->databaselabanalisys->lockSample($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub sample_unlocked {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub sample_unlocked");

    my $id = $self->param('id');
    $self->app->log->debug("id: $id");

    $self->app->log->debug('Unlock sample from db');
    if ( $self->databaselabanalisys->unlockSample($id) ) {

        $self->app->log->debug('Result: OK');

        $self->render( json => 1 );

    }
    else {
        $self->app->log->debug('Result: ERROR');

        $self->render( json => 0 );
    }
}

sub filter_empty {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub filter_empty");

    my $anid = $self->param('anid');
    $self->app->log->debug("anid: $anid");

    my $filter = $self->databaselabanalisys->getEmptyFilterById($anid);

    my $json = {
        res    => 'OK',
        filter => $filter
    };

    $self->render( json => $json );
}

sub filter_data {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub filter_data");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'filter_data', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databaselabanalisys->insertFilterData($params);
    if ($res) {
        $self->flash( message => 'Dati inseriti' );
    }
    else {
        $self->flash( message => "Errore durante l'inserimento dei dati" );
    }

    my $url = $self->url_for("/labanalisys_filter");
    $self->redirect_to($url);
}

sub labanalisys_file {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub labanalisys_file");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'labanalisys_file', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );
    my $analysis_type = $params->{'id'};

    my $analysis_type_name =
      $self->databaselabanalisys->getAnalisysFilesTypeNameById($analysis_type);

    my $file_base_dir = "uploads/labanalisi";

    my $file_dir = $self->app->static->paths->[0] . '/' . $file_base_dir;

    $self->helperCreatePath($file_dir);

    my $file = $self->req->upload('file');

    unless ($file) {
        $self->app->log->debug("Upload fallito. File non specificato.");
        $self->render(
            json => { error => "Upload fallito. File non specificato." } );
    }

    $self->app->log->debug("Upload max size check");
    my $upload_max_size = 10 * 1024 * 1024;
    my $file_size       = $file->size;
    if ( $file_size > $upload_max_size ) {
        $self->app->log->debug(
            "Upload fallito. Dimensione file troppo grande.");
        $self->render( json =>
              { error => "Upload fallito. Dimensione file troppo grande." } );
    }

    $self->app->log->debug("File uploadato.");

    $self->app->log->debug("Check file type");
    my $image_type = $file->headers->content_type;
    $self->app->log->debug("image_type: $image_type");

    my %valid_types = map { $_ => 1 } qw(application/vnd.ms-excel);
    unless ( $valid_types{$image_type} ) {
        $self->app->log->debug("Errore tipo file");
        $self->render(
            json => { error => "Upload fallito. Il contenuto è errato." } );
    }

    my $file_name_original = $file->filename;
    $self->app->log->debug("Original file name: $file_name_original");

    my ( $fp_name, $p_path, $p_ext ) =
      fileparse( $file_name_original, qr"\..[^.]*$" );

    my $file_name_temp = $self->helperFileUploadGetFileId() . "$p_ext";
    my $analysis_type_name_formatted = lc($analysis_type_name);
    $analysis_type_name_formatted =~ s/ /_/g;
    my $file_name = $analysis_type_name_formatted . "_" . $file_name_temp;
    my $full_file_name = $file_dir . "/" . $file_name;
    $self->app->log->debug("Save attachment to file");
    $file->move_to($full_file_name);

    my $json;
    $self->app->log->debug('Insert new file into db');
    my $id = $self->databaselabanalisys->insertDataFile( $analysis_type,
        $file_name_original, $file_name );
    if ($id) {
        $self->app->log->debug('Result: OK');

        my $subject = 'Laboratorio analisi - Nuovo file';
        my $body    = "Ricevuto un nuovo file dal laboratorio analisi.\n";
        $body .= "Nome file originale: $file_name_original\n";
        $body .= "Nome file salvato: $file_name\n";
        $body .= "Tipo analisi: $analysis_type_name";

        $self->helperSendEmail( $self->config->{'admin_mails'},
            $subject, $body );

        $json = { message => "File id: $id" };

    }
    else {
        $self->app->log->debug('Result: ERROR');

        my $subject = 'Laboratorio analisi - Nuovo file';
        my $body =
"Errore esecuzione insert : databaselabanalisys->insertDataFile( )\nFile: $file_name";
        $self->helperSendEmail( $self->config->{'admin_mails'},
            $subject, $body );

        $json = { error => "Insert fallito." };
    }

    $self->app->log->debug("render back");
    $self->render( json => $json );
}

sub white_chart_data {
    my $self = shift;

    $self->app->log->debug("Lily::Labanalisys sub white_chart_data");

    my $labprid = $self->param('labprid');
    $self->app->log->debug("labprid: $labprid");

    my $data = $self->databaselabanalisys->getChartDataByRpId($labprid);

    my $json = {
        res  => 'OK',
        data => $data
    };

    $self->render( json => $json );
}

1;
