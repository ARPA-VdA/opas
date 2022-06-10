package Lily::Station;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::DOM;
use Data::Dumper;
use JSON;
use File::Find::Rule;
use Net::FTP;
use Scalar::Util qw(looks_like_number);
use Encode qw(is_utf8 encode decode);

sub station_alarm {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_alarm");

    $self->helperGetHomepageStash('station_alarm');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $st_id     = $params->{'stId'} || -1;
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("st_id: $st_id");
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -6 );
    }
    $self->stash(
        st_id     => $st_id,
        date_from => $date_from,
        date_to   => $date_to
    );
    $date_to = "$date_to 23:59:59";
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $station_alarms =
      $self->databasestations->getStationAlarmsByDatesAndStation( $date_from,
        $date_to, $st_id );
    $self->stash( station_alarms => $station_alarms );

    my $stations = $self->databaseutils->getStations();
    $self->stash( stations => $stations );

    $self->render( template => 'station/station_alarm' );
}

sub station_abnormal {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_abnormal");

    $self->helperGetHomepageStash('station_abnormal');

    $self->render( template => 'station/station_abnormal' );
}

sub station_late {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_late");

    $self->helperGetHomepageStash('station_late');

    my $station_status = $self->databasestations->getStationStatus();
    $self->stash( station_status => $station_status );

    $self->render( template => 'station/station_late' );
}

sub station_download {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_download");

    $self->helperGetHomepageStash('station_download');

    my $station_status = $self->databasestations->getStationStatus();
    $self->stash( station_status => $station_status );

    $self->render( template => 'station/station_download' );
}

sub station_istantaneous {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_istantaneous");

    $self->helperGetHomepageStash('station_istantaneous');

    my $station_status = $self->databasestations->getStationStatus();
    $self->stash( station_status => $station_status );

    $self->render( template => 'station/station_istantaneous' );
}

sub station_metadata {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_metadata");

    $self->helperGetHomepageStash('station_metadata');

    my $grid = $self->session('lily.app.ecometer')->{'gr_id'};
    $self->stash( grid => $grid );

    my $location = $self->config->{'apps'}->{'station_metadata'}->{'location'};
    $self->stash( location => $location );

    my $workstations = $self->databasestations->getMetadataStations($location);
    $self->stash( workstations => $workstations );

    $self->render( template => 'station/station_metadata' );
}

sub station_status {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_status");

    $self->helperGetHomepageStash('station_status');

    my $station_status = $self->databasestations->getStationStatus();
    $self->stash( station_status => $station_status );

    $self->render( template => 'station/station_status' );
}

sub station_istantaneous_get_camp {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_istantaneous_get_camp");

    my $ip = $self->req->body_params->param('ip');
    $self->app->log->debug("Post ip: $ip");

    my $ua = Mojo::UserAgent->new;
    my $body =
      $ua->get( 'http://' . $ip . '/?command=NewestRecord&table=Public' )
      ->res->body;

    my $dom = Mojo::DOM->new($body);

    my @rows;
    $dom->find('br')->each(
        sub {
            my $row   = shift;
            my $label = $row->previous_node->previous_node->content;
            my $value = $row->previous_node->content;

            $label =~ s/Current Record:/Record/;
            $label =~ s/Record Date:/Data & ora/;

            push @rows,
              {
                label => $label,
                value => $value
              };
        }
    );

    $dom->find('table tr')->each(
        sub {
            my $row   = shift;
            my $label = $row->children->[0]->text;
            my $value = $row->children->[1]->text;

            my $ok = 0;
            $ok++ if $label =~ m/^DL_/i;
            $ok++ if $label =~ m/^ST_/i;
            $ok++ if $label =~ m/^DATA_/i;
            $ok++ if $label =~ m/^FTP_/i;
            $ok++ if $label =~ m/^HTTP_/i;
            $ok++ if $label =~ m/^ALM_/i;

            $ok++ if $label =~ m/^AL_Free_1/i;
            $ok++ if $label =~ m/^AL_Free_2/i;

            $label =~ s/AL_Door/Porta aperta/;
            $label =~ s/AL_Power/Mancanza alimentazione/;
            $label =~ s/AL_Temp/Temperatura elevata/;
            $label =~ s/AL_PowerSupply/Alimentatore/;
            $label =~ s/AL_Free_1//;
            $label =~ s/AL_Free_2//;
            $label =~ s/AL_ProbeFlux/Flusso sonda/;

            if ( looks_like_number($value) ) {
                $value = int( $value * 100 ) / 100;
            }

            if ( $ok == 0 ) {
                push @rows,
                  {
                    label => $label,
                    value => $value
                  };
            }

        }
    );

    my $data_rows = JSON->new->encode( \@rows );
    $self->render( json => { rows => $data_rows } );
}

sub station_istantaneous_get_lognet {
    my $self = shift;

    $self->app->log->debug("Lily::Station sub station_istantaneous_get_lognet");

    my $ip = $self->req->body_params->param('ip');
    $self->app->log->debug("Post ip: $ip");

    $self->app->log->debug("Ftp connection...");
    my ( $ftp, $host, $user, $pass, $dir, $filename, $temp_filename );
    $host     = $ip;
    $user     = "ftpuser";
    $pass     = "ftpuser";
    $dir      = "/LoggerNET/file_istantanei";
    $filename = "istantenei.dat";
    $temp_filename = $self->app->home->rel_file('public/uploads/istantaneous');
    $temp_filename .= "/" . $filename;
    unlink $temp_filename;
    $self->app->log->debug("temp_filename: $temp_filename");

    $ftp = Net::FTP->new( $host, Debug => 0 );
    if ( !$ftp ) {
        $self->app->log->error("Cannot connect to some.host.name: $@");
        $self->render( json => { rows => undef } );
    }

    if ( !$ftp->login( $user, $pass ) ) {
        $self->app->log->error( "Cannot login ", $ftp->message );
        $self->render( json => { rows => undef } );
    }

    if ( !$ftp->binary() ) {
        $self->app->log->error( "Cannot set binary flag ", $ftp->message );
        $self->render( json => { rows => undef } );
    }

    if ( !$ftp->cwd($dir) ) {
        $self->app->log->error( "Cannot change working directory ",
            $ftp->message );
        $self->render( json => { rows => undef } );
    }

    if ( !$ftp->get( $filename, $temp_filename ) ) {
        $self->app->log->error( "Get failed ", $ftp->message );
        $self->render( json => { rows => undef } );
    }
    $ftp->quit;

    my @rows;
    if ( -e $temp_filename ) {

        if ( open( FILE, '<:encoding(UTF-8)', $temp_filename ) ) {

            while ( my $row = <FILE> ) {
                chomp $row;

                my @field = split /\t/, $row;
                next if $field[0] eq 'D';

                my ( $label, $value );
                if ( $field[0] eq 'P' ) {
                    $label = $field[1] . " - " . $field[2];
                    $value = $field[3];
                    if ( $field[4] ) { $value .= " - " . $field[4] }
                }
                else {
                    $label = $field[0];
                    $value = $field[1];
                }

                push @rows,
                  {
                    label => $label,
                    value => $value
                  };
            }
            close(FILE);

        }
        else {
            $self->app->log->error("Could not open file '$temp_filename' $!");
        }
    }
    my $data_rows = JSON->new->encode( \@rows );
    $self->render( json => { rows => $data_rows } );
}

sub metadata_get_station {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub metadata_get_station");

    my $stid = $self->param('id');
    $self->app->log->debug("stid: $stid");

    my $location = $self->config->{'apps'}->{'station_metadata'}->{'location'};
    $self->stash( location => $location );

    my $data = $self->databasestations->getMetadataByStid( $stid, $location );

    my $meteo =
      $self->databasestations->getMetadataParamMeteoByStid( $stid, $location );

    my $chem = $self->databasestations->getMetadataParamChemicalByStid( $stid,
        $location );

    my $analis = $self->databasestations->getMetadataParamAnalisysByStid( $stid,
        $location );

    my $public_dir = $self->app->home->rel_file('public');
    my $media_path = $public_dir . '/media-lily/st-' . $stid;
    my $base_dir   = '/media-lily/st-' . $stid;

    my $picture = $self->helperGetFileVersion("$base_dir/$stid.jpg");

    $self->app->log->debug("searching media files in: $media_path");
    my $rule = File::Find::Rule->new;
    $rule->file;
    $rule->name( '*.png', '*.jpg', '*.jpeg', '*.JPG', '*.JPEG', '*.pdf' );
    $rule->relative;
    my @files_url;
    my @files = $rule->in($media_path);
    foreach my $file (@files) {
        my $file_url = $self->helperGetFileVersion("$base_dir/$file");
        $self->app->log->debug("file: $file, $file_url");
        push @files_url, $file_url;
    }

    my $json = {
        res     => 'OK',
        data    => $data,
        meteo   => $meteo,
        chem    => $chem,
        analis  => $analis,
        picture => $picture,
        media   => \@files_url
    };

    $self->render( json => $json );
}

sub ping_station {
    my $self = shift;

    $self->app->log->debug("Lily::Report sub ping_station");

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

1;
